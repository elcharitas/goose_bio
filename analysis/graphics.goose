namespace bio;
import math;

fn graphic_min(a: i64, b: i64) -> i64 { if a < b { return a; } b }
fn graphic_max(a: i64, b: i64) -> i64 { if a > b { return a; } b }

/* Exact integer boundaries satisfy 0<=start<=end<=1000000000. Compound parts retain caller order,
 * overlaps, and duplicates. Each feature has one shared strand (-1, 0, or 1); strand-specific compound
 * parts are unsupported. */
struct GraphicPart { start: i64, end: i64 }

/* Only BOX and exact locations are supported; exact asserts no converted fuzzy positions. Forward
 * boxes fill the upper track half, reverse the lower, and unstranded both. Labels sit at upper start
 * for forward/unstranded and lower end rotated 180 degrees for reverse. Each retained part gets a
 * label. No automatic labels come from feature types/qualifiers. */
struct GraphicFeature {
    parts: GraphicPart[], strand: i64, color: u8[], label: u8[],
    sigil: u8[], exact: bool,
}

/* Levels are contiguous 1..N from bottom to top, with equal heights even when empty. Tracks have
 * unit relative height, without scales or grey backgrounds. No graph tracks, axes, scales,
 * backgrounds, or variable heights. */
struct GraphicTrack { features: GraphicFeature[] }

/* Caller supplies dimensions and range; sequence length is not inferred. Range is integer
 * 0<=start<end<=1000000000. Dimensions are finite 1..1000000 SVG points. Requires at least one track
 * and exactly one linear fragment without cross-links. The single fragment starts at the origin and
 * fills the track area without track lines; landscape when width>=height, portrait otherwise. */
struct GraphicPage {
    start:     i64, end: i64, width: f64, height: f64,
    fragments: i64, circular: bool, cross_links: bool,
}

/* Errors return empty SVG. Whole-document buffering needs memory proportional to emitted parts/labels.
 * SVG uses a bottom-left drawing group and local text transforms, with no scripts, links, images, or
 * font downloads. Helvetica uses installed fonts/fallback; metrics and raster output can differ.
 * Numbers use Goose str(f64). */
struct GraphicSvg { svg: u8[], error: u8[] }

/* Unsupported page modes and sigils return errors. Output is SVG with one linear fragment;
 * circular layouts, fuzzy locations, other sigils, and PDF/PS/bitmap output are unsupported. */
fn graphic_error(message: const u8[:]) -> GraphicSvg {
    GraphicSvg { "", message }
}

/* Requires exactly #RRGGBB, case-insensitive hex, retaining spelling. No CSS names, alpha, URLs, or
 * styles. */
fn graphic_color(color: const u8[:]) -> bool {
    if color.len != 7 || color[0] != '#' { return false; }
    for i in 1..7 {
        let c = color[i];
        if !(c >= '0' && c <= '9') && !(c >= 'a' && c <= 'f') &&
            !(c >= 'A' && c <= 'F') { return false; }
    }
    true
}

/* Requires printable ASCII; empty labels emit no text. Controls and non-ASCII fail. Labels use
 * Helvetica size 10, black, label_angle=0 and label_position=start; no custom fonts/angles/positions
 * or Unicode. */
fn graphic_label(label: const u8[:]) -> bool {
    for c in label { if c < 32 || c > 126 { return false; } }
    true
}

/* Escapes the five XML metacharacters. Boxes retain track/feature/part order; all labels follow all
 * boxes without collision avoidance. Features use borderless boxes. */
fn graphic_escape(label: const u8[:]) -> u8[] {
    var out: u8[>..] = [];
    for c in label {
        if c == '&' { out.append("&amp;"); }
        else if c == '<' { out.append("&lt;"); }
        else if c == '>' { out.append("&gt;"); }
        else if c == '"' { out.append("&quot;"); }
        else if c == '\'' { out.append("&apos;"); }
        else { out.push(c); }
    }
    out
}
// Linear geometry uses endpoint selection.

/* Uses end-start+1 as denominator, so a part ending at page end leaves the last width unit unused.
 * Selects features with either bounding endpoint in the inclusive page range; features spanning both
 * boundaries are omitted. Compound selection uses minimum start/maximum end, then clips parts
 * independently. Edge-touching and zero-length parts still produce zero-width polygons and labels.
 * This is drawing selection, not interval overlap. */
fn genome_diagram_svg(page: const GraphicPage&, tracks: const GraphicTrack[:]) -> GraphicSvg {
    if page.circular || page.cross_links || page.fragments != 1 {
        return graphic_error("only one linear fragment without cross-links is supported");
    }
    if page.start < 0 || page.end <= page.start || page.end > 1000000000 {
        return graphic_error("range must satisfy 0 <= start < end <= 1000000000");
    }
    if is_nan(page.width) || is_inf(page.width) || is_nan(page.height) ||
        is_inf(page.height) || page.width < 1 || page.height < 1 ||
        page.width > 1000000 || page.height > 1000000 || tracks.len == 0 {
        return graphic_error("invalid page dimensions or missing tracks");
    }
    for track in tracks { for f in track.features {
        if !f.exact || f.sigil != "BOX" || f.parts.len == 0 ||
            f.strand < -1 || f.strand > 1 {
            return graphic_error("feature requires exact parts, BOX, and strand -1, 0, or 1");
        }
        if !graphic_color(f.color) || !graphic_label(f.label) {
            return graphic_error("color requires #RRGGBB; label requires printable ASCII");
        }
        for p in f.parts {
            if p.start < 0 || p.end < p.start || p.end > 1000000000 {
                return graphic_error("invalid feature location");
            }
        }
    } }
    var out: u8[>..] = [];
    out.append("<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"");
    out.append(str(page.width)); out.append("\" height=\"");
    out.append(str(page.height)); out.append("\" viewBox=\"0 0 ");
    out.append(str(page.width)); out.push(' '); out.append(str(page.height));
    out.append("\"><g transform=\"translate(0 "); out.append(str(page.height));
    out.append(") scale(1 -1)\">");
    var labels: u8[>..] = [];
    let unit = page.height / tracks.len;
    for track, ti in tracks { for f in track.features {
        var low = f.parts[0].start; var high = f.parts[0].end;
        for p in f.parts { low = graphic_min(low, p.start); high = graphic_max(high, p.end); }
        // Selects features by bounding endpoints.
        if !(low >= page.start && low <= page.end) &&
            !(high >= page.start && high <= page.end) { continue; }
        let bottom = unit * ti; let top = unit * (ti + 1);
        let center = (bottom + top) / 2;
        var y0 = bottom; var y1 = top;
        if f.strand == 1 { y0 = center; }
        if f.strand == -1 { y1 = center; }
        for p in f.parts {
            if p.end < page.start || p.start > page.end { continue; }
            let x0 = page.width * (graphic_max(p.start, page.start) - page.start) / (page.end - page.start + 1);
            let x1 = page.width * (graphic_min(p.end, page.end) - page.start) / (page.end - page.start + 1);
            out.append("<polygon points=\"");
            for v, i in [x0, y0, x1, y0, x1, y1, x0, y1] {
                if i > 0 { out.push(' '); } out.append(str(v));
            }
            out.append("\" fill=\""); out.append(f.color); out.append("\" stroke=\"none\"/>");
            if f.label.len > 0 {
                var x = x0; var y = top; var angle: i64 = 0;
                if f.strand == -1 { x = x1; y = bottom; angle = 180; }
                labels.append("<g transform=\"translate("); labels.append(str(x));
                labels.push(' '); labels.append(str(y)); labels.append(") rotate(");
                labels.append(str(angle)); labels.append(")\"><text transform=\"scale(1 -1)\" x=\"0\" y=\"0\" font-family=\"Helvetica\" font-size=\"10\" fill=\"#000000\">");
                labels.append(graphic_escape(f.label)); labels.append("</text></g>");
            }
        }
    } }
    out.append(labels); out.append("</g></svg>");
    GraphicSvg { out, "" }
}
