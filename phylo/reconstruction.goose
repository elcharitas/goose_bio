namespace bio;
import std;
import math;
import .newick;

// Dense O(n^3) reconstruction with deterministic first-pair ties.
// NJ returns an arbitrary degree-two root on the last edge.
// No bootstrap support, clock test, or evolutionary model fitting.
// Matrices are row-major, finite, symmetric, and nonnegative.
fn distance_matrix_error(labels: const u8[][:], distances: const f64[:]) -> u8[] {
    let n = labels.len;
    if n == 0 || distances.len / n != n || distances.len % n != 0 {
        return "distance matrix dimensions do not match labels";
    }
    for label, i in labels {
        if label.len == 0 { return "empty taxon label"; }
        for other, j in labels {
            if j < i && label == other { return "duplicate taxon label"; }
        }
    }
    for d, k in distances {
        if is_nan(d) || is_inf(d) || d < 0 { return "invalid distance"; }
        let i = k / n; let j = k % n;
        if i == j && d != 0 { return "nonzero matrix diagonal"; }
        if d != distances[j * n + i] { return "asymmetric distance matrix"; }
    }
    ""
}

// NJ retains negative limbs for nonadditive data; it does not clip them.
// UPGMA assumes a molecular clock; input need not be ultrametric.
fn reconstruct_tree(labels: const u8[][:], distances: const f64[:], nj: bool) -> TreeResult {
    let error = distance_matrix_error(labels, distances);
    if error.len > 0 { return TreeResult { [], -1, error }; }
    let n = labels.len;
    var nodes:   TreeNode[>..] = [];
    var active:  i64[>..]      = [];
    var sizes:   f64[>..]      = [];
    var heights: f64[>..]      = [];
    var d:       f64[>..]      = [];
    for label, i in labels {
        nodes.push(TreeNode { copy(label), [], 0, false });
        active.push(i); sizes.push(1); heights.push(0);
    }
    var scale = 0.0;
    for value in distances { scale = max(scale, value); }
    if scale == 0 { scale = 1; }
    for value in distances {
        let normalized = value / scale;
        if value != 0 && normalized == 0 {
            return TreeResult { [], -1, "unsupported distance scale separation" };
        }
        d.push(normalized);
    }
    while active.len > 1 {
        let m = active.len;
        var sums: f64[>..] = [];
        for i in m {
            var sum = 0.0;
            for j in m { sum += d[i * m + j]; }
            sums.push(sum);
        }
        var a: i64 = 0; var b: i64 = 1;
        var best = 0.0;
        for i in m {
            for j in m {
                if j <= i { continue; }
                var score = d[i * m + j];
                if nj && m > 2 { score = (m - 2) * score - sums[i] - sums[j]; }
                if (i == 0 && j == 1) || score < best { best = score; a = i; b = j; }
            }
        }
        let distance = d[a * m + b];
        let height = distance / 2;
        var left = height - heights[a]; var right = height - heights[b];
        if nj {
            left = distance / 2;
            if m > 2 { left += (sums[a] - sums[b]) / (2 * (m - 2)); }
            right = distance - left;
        }
        let parent = nodes.len;
        // Rebuild immutable nodes when adding their incoming edge.
        var updated: TreeNode[>..] = [];
        for node, i in nodes {
            var length = node.length; var has = node.has_length;
            if i == active[a] { length = left; has = true; }
            if i == active[b] { length = right; has = true; }
            updated.push(TreeNode { copy(node.label), copy(node.children), length, has });
        }
        updated.push(TreeNode { "", [active[a], active[b]], 0, false });
        nodes = copy(updated);
        var next:         i64[>..] = [];
        var next_sizes:   f64[>..] = [];
        var next_heights: f64[>..] = [];
        var keep:         i64[>..] = [];
        for id, i in active {
            if i == a || i == b { continue; }
            next.push(id); next_sizes.push(sizes[i]);
            next_heights.push(heights[i]); keep.push(i);
        }
        next.push(parent); next_sizes.push(sizes[a] + sizes[b]); next_heights.push(height);
        var matrix: f64[>..] = [];
        for i in next.len {
            for j in next.len {
                var value = 0.0;
                if i < keep.len && j < keep.len { value = d[keep[i] * m + keep[j]]; }
                else if i != j {
                    var k = i; if j < keep.len { k = j; }
                    let da = d[keep[k] * m + a]; let db = d[keep[k] * m + b];
                    value = (da * sizes[a] + db * sizes[b]) / (sizes[a] + sizes[b]);
                    if nj { value = (da + db - distance) / 2; }
                }
                if is_nan(value) || is_inf(value) { return TreeResult { [], -1, "distance arithmetic overflow" }; }
                matrix.push(value);
            }
        }
        if is_nan(left) || is_inf(left) || is_nan(right) || is_inf(right) {
            return TreeResult { [], -1, "branch arithmetic overflow" };
        }
        active = copy(next); sizes = copy(next_sizes);
        heights = copy(next_heights); d = copy(matrix);
    }
    var restored: TreeNode[>..] = [];
    for node in nodes {
        let length = node.length * scale;
        if is_inf(length) || is_nan(length) || (node.length != 0 && length == 0) {
            return TreeResult { [], -1, "branch scale out of range" };
        }
        restored.push(TreeNode { copy(node.label), copy(node.children), length, node.has_length });
    }
    TreeResult { copy(restored), active[0], "" }
}

fn upgma(labels: const u8[][:], distances: const f64[:]) -> TreeResult {
    reconstruct_tree(labels, distances, false)
}
fn neighbor_joining(labels: const u8[][:], distances: const f64[:]) -> TreeResult {
    reconstruct_tree(labels, distances, true)
}

struct NewickResult { text: u8[], error: u8[] }
recursive fn write_newick_node(nodes: const TreeNode&[:], id: i64,
    output: u8[>..]&, visited: bool[>..]&, depth: i64) -> bool {
    if depth > 512 || id < 0 || id >= nodes.len || visited[id] { return false; }
    visited[id] = true;
    let node = nodes[id];
    if node.children.len > 0 {
        output.push('(');
        for child, i in node.children {
            if i > 0 { output.push(','); }
            if !write_newick_node(nodes, child, output, visited, depth + 1) { return false; }
        }
        output.push(')');
    }
    if node.label.len > 0 {
        output.push('\'');
        for c in node.label {
            output.push(c); if c == '\'' { output.push(c); }
        }
        output.push('\'');
    } else if node.children.len == 0 { return false; }
    if node.has_length {
        if is_nan(node.length) || is_inf(node.length) { return false; }
        output.push(':'); for c in str(node.length) { output.push(c); }
    }
    true
}
fn serialize_newick(tree: const TreeResult&) -> NewickResult {
    if tree.error.len > 0 { return NewickResult { "", copy(tree.error) }; }
    var output: u8[>..] = []; var visited: bool[>..] = [];
    for node in tree.nodes { visited.push(false); }
    var refs: const TreeNode&[>..] = [];
    for node in tree.nodes { refs.push(node); }
    if !write_newick_node(refs, tree.root, output, visited, 0) {
        return NewickResult { "", "invalid tree or depth exceeds 512" };
    }
    for seen in visited { if !seen { return NewickResult { "", "unreachable tree node" }; } }
    output.push(';'); NewickResult { copy(output), "" }
}
