namespace bio;
import math;

/* Use constructors; check error before results. Operations return new records and preserve inputs. No
 * mutable parent links or arbitrary qualifiers. Each record is buffered; floating arithmetic follows
 * platform IEEE behavior and can overflow, without compensated sums or extreme-range guarantees. */
struct PhenotypeWell { id: u8[], times: f64[], signals: f64[], error: u8[] }
struct PhenotypePlate { id: u8[], wells: PhenotypeWell[], error: u8[] }
struct PhenotypeSummary { minimum: f64, maximum: f64, average_height: f64, error: u8[] }
struct PhenotypeArea { value: f64, error: u8[] }

// Assignment order resolves repeated times; storage follows numeric time.

/* Sorts finite numeric times with last assignment winning duplicates; signals may be NaN/infinite.
 * Insertion sorting has quadratic worst-case cost. */
fn phenotype_well(id: u8[], times: const f64[:], signals: const f64[:]) -> PhenotypeWell {
    if times.len != signals.len { return PhenotypeWell { id, [], [], "series lengths differ" }; }
    var ts: f64[>..] = []; var ys: f64[>..] = [];
    for t, k in times {
        if is_nan(t) || is_inf(t) { return PhenotypeWell { id, [], [], "finite times required" }; }
        var pos = 0;
        while pos < ts.len && ts[pos] < t { pos += 1; }
        if pos < ts.len && ts[pos] == t { ys[pos] = signals[k]; }
        else {
            ts.push(t); ys.push(signals[k]);
            var j = ts.len - 1;
            while j > pos { ts[j] = ts[j - 1]; ys[j] = ys[j - 1]; j -= 1; }
            ts[pos] = t; ys[pos] = signals[k];
        }
    }
    return PhenotypeWell { id, ts, ys, "" };
}

/* Linear interpolation scans samples; outside closed support, empty wells, and errored wells give NaN.
 * Single points yield their signal only at the exact time. */
fn phenotype_interpolate(w: const PhenotypeWell&, time: f64) -> f64 {
    if w.error.len > 0 || w.times.len == 0 || is_nan(time) { return log(-1.0); }
    if time < w.times[0] || time > w.times[w.times.len - 1] { return log(-1.0); }
    for t, i in w.times {
        if time == t { return w.signals[i]; }
        if time < t {
            let left = w.signals[i - 1]; let right = w.signals[i];
            if is_inf(left) || is_inf(right) {
                if is_nan(left) || is_nan(right) ||
                   (is_inf(left) && is_inf(right) && left != right) { return log(-1.0); }
                return if is_inf(left) { left } else { right };
            }
            let fraction = (time - w.times[i - 1]) / (t - w.times[i - 1]);
            return w.signals[i - 1] + fraction * (w.signals[i] - w.signals[i - 1]);
        }
    }
    return log(-1.0);
}

/* Uses the sorted union of times and interpolates both operands, retaining the left ID. Unequal
 * supports produce NaNs. Arithmetic scans the union and interpolates at each time. */
fn phenotype_combine(a: const PhenotypeWell&, b: const PhenotypeWell&, subtract: bool) -> PhenotypeWell {
    if a.error.len > 0 { return copy(a); }
    if b.error.len > 0 { return PhenotypeWell { copy(a.id), [], [], copy(b.error) }; }
    var times: f64[>..] = []; var values: f64[>..] = [];
    var i = 0; var j = 0;
    while i < a.times.len || j < b.times.len {
        var t = 0.0;
        if j == b.times.len || (i < a.times.len && a.times[i] <= b.times[j]) { t = a.times[i]; i += 1; }
        else { t = b.times[j]; j += 1; }
        if j < b.times.len && b.times[j] == t { j += 1; }
        let x = phenotype_interpolate(a, t); let y = phenotype_interpolate(b, t);
        times.push(t); values.push(if subtract { x - y } else { x + y });
    }
    return PhenotypeWell { copy(a.id), times, values, "" };
}
fn phenotype_add(a: const PhenotypeWell&, b: const PhenotypeWell&) -> PhenotypeWell { phenotype_combine(a, b, false) }
fn phenotype_subtract(a: const PhenotypeWell&, b: const PhenotypeWell&) -> PhenotypeWell { phenotype_combine(a, b, true) }

/* Computes minimum, maximum, and average sampled height, including ordered NaN extrema comparisons
 * and NaN propagation in the mean. No nonlinear fitting, covariance, convergence, fitted parameters,
 * or model selection/evaluation; no SciPy is needed. */
fn phenotype_summary(w: const PhenotypeWell&) -> PhenotypeSummary {
    if w.error.len > 0 { return PhenotypeSummary { 0, 0, 0, copy(w.error) }; }
    if w.signals.len == 0 { return PhenotypeSummary { 0, 0, 0, "empty well" }; }
    var low = w.signals[0]; var high = low; var sum = 0.0;
    for x in w.signals {
        if x < low { low = x; }
        if x > high { high = x; }
        sum += x;
    }
    return PhenotypeSummary { low, high, sum / w.signals.len, "" };
}
// Area is independent of summary and has no fitted model semantics.

/* Separate sampled integration: one point has zero area, empty wells error. Area is computed
 * independently of model fitting. */
fn phenotype_trapezoidal_area(w: const PhenotypeWell&) -> PhenotypeArea {
    if w.error.len > 0 { return PhenotypeArea { 0, copy(w.error) }; }
    if w.times.len == 0 { return PhenotypeArea { 0, "empty well" }; }
    var area = 0.0;
    for i in w.times.len { if i > 0 { area += (w.times[i] - w.times[i - 1]) * (w.signals[i] + w.signals[i - 1]) / 2; } }
    return PhenotypeArea { area, "" };
}
fn phenotype_id_less(a: const u8[:], b: const u8[:]) -> bool {
    var i = 0;
    while i < a.len && i < b.len { if a[i] != b[i] { return a[i] < b[i]; } i += 1; }
    return a.len < b.len;
}

/* Lexicographic well-ID order; last duplicate ID replaces its predecessor. No slicing,
 * resampling-grid, plate addition, or plate subtraction APIs. */
fn phenotype_plate(id: u8[], wells: const PhenotypeWell[:]) -> PhenotypePlate {
    var refs: const PhenotypeWell&[>..] = [];
    for w in wells { refs.push(w); }
    var order: i64[>..] = [];
    for w, k in wells {
        if w.error.len > 0 { return PhenotypePlate { id, [], copy(w.error) }; }
        var pos = 0;
        while pos < order.len && phenotype_id_less(refs[order[pos]].id, w.id) { pos += 1; }
        if pos < order.len && refs[order[pos]].id == w.id { order[pos] = k; }
        else {
            order.push(k); var j = order.len - 1;
            while j > pos { order[j] = order[j - 1]; j -= 1; }
            order[pos] = k;
        }
    }
    var result: PhenotypeWell[>..] = [];
    for k in order { result.push(copy(refs[k])); }
    return PhenotypePlate { id, result, "" };
}
// all=true selects every well; all=false uses the explicit list.

/* Returns a new plate: all=true subtracts control from every well; otherwise only selected IDs
 * change, and an empty selection changes none. Missing control/selected IDs error. Plate qualifiers
 * are empty. PM JSON, qualifier serialization, and vendor CSV are unsupported; no JSON roundtrip is
 * promised. */
fn phenotype_subtract_control(p: const PhenotypePlate&, control: const u8[:], selected: const u8[][:], all: bool) -> PhenotypePlate {
    if p.error.len > 0 { return copy(p); }
    var index = -1;
    for w, i in p.wells { if w.id == control { index = i; } }
    if index < 0 { return PhenotypePlate { copy(p.id), [], "control well absent" }; }
    for id in selected {
        var found = false;
        for w in p.wells { if w.id == id { found = true; } }
        if !found { return PhenotypePlate { copy(p.id), [], "selected well absent" }; }
    }
    var refs: const PhenotypeWell&[>..] = [];
    for v in p.wells { refs.push(v); }
    var result: PhenotypeWell[>..] = [];
    for w in p.wells {
        var apply = all;
        for id in selected { if id == w.id { apply = true; } }
        result.push(if apply { phenotype_subtract(w, refs[index]) } else { copy(w) });
    }
    return PhenotypePlate { copy(p.id), result, "" };
}
