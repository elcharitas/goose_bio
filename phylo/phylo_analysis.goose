namespace bio;
import std;
import math;
import .reconstruction;

/*
Labels follow leaf storage order; bit i in each u64 clade mask refers to labels[i]. Root
and leaf masks are included. At most 63 leaves are supported; label validation is
quadratic.
*/
struct TreeAnalysis { labels: u8[][], masks: u64[], error: u8[] }
struct TreeDistances { values: f64[], error: u8[] }
struct TreeSupport { percent: f64[], error: u8[] }
struct ConsensusResult { tree: TreeResult, support: f64[], error: u8[] }

recursive fn phylo_mask(nodes: const TreeNode&[:], id: i64,
    labels: const u8[][:], masks: u64[>..]&) -> u64 {
    var mask: u64 = 0;
    if nodes[id].children.len == 0 {
        for label, i in labels {
            if label == nodes[id].label { mask = (1 as u64) << i; }
        }
    } else {
        for child in nodes[id].children {
            mask |= phylo_mask(nodes, child, labels, masks);
        }
    }
    masks[id] = mask; mask
}

/*
Rejects empty/duplicate leaves, unary nodes, invalid indices, cycles, shared children,
unreachable nodes, and nonfinite present lengths. Existing serialization limits depth to
512.
*/
fn tree_analysis(tree: const TreeResult&) -> TreeAnalysis {
    let checked = serialize_newick(tree);
    if checked.error.len > 0 { return TreeAnalysis { [], [], copy(checked.error) }; }
    var labels: u8[][>..] = []; var masks: u64[>..] = [];
    var refs: const TreeNode&[>..] = [];
    for node in tree.nodes {
        refs.push(node); masks.push(0);
        if node.children.len == 1 {
            return TreeAnalysis { [], [], "unary nodes are unsupported" };
        }
        if node.children.len == 0 {
            for label in labels {
                if label == node.label { return TreeAnalysis { [], [], "duplicate leaf" }; }
            }
            labels.push(copy(node.label));
        }
    }
    if labels.len > 63 { return TreeAnalysis { [], [], "at most 63 leaves supported" }; }
    phylo_mask(refs, tree.root, labels, masks);
    TreeAnalysis { copy(labels), copy(masks), "" }
}

/*
Requires exactly the same unique taxa in the explicit label order; replicate storage
order may differ.
*/
fn phylo_remap(tree: const TreeResult&, labels: const u8[][:]) -> TreeAnalysis {
    let checked = tree_analysis(tree);
    if checked.error.len > 0 { return checked; }
    if checked.labels.len != labels.len { return TreeAnalysis { [], [], "inconsistent taxa" }; }
    for label in checked.labels {
        var found = false;
        for expected in labels { if expected == label { found = true; } }
        if !found { return TreeAnalysis { [], [], "inconsistent taxa" }; }
    }
    var masks: u64[>..] = []; var refs: const TreeNode&[>..] = [];
    for node in tree.nodes { masks.push(0); refs.push(node); }
    phylo_mask(refs, tree.root, labels, masks);
    var names: u8[][>..] = [];
    for label in labels { names.push(copy(label)); }
    TreeAnalysis { copy(names), copy(masks), "" }
}

/*
Returns row-major leaf distances in analysis order. Root lengths do not contribute.
Missing incoming lengths fail unless missing_zero is explicit. Negative finite lengths,
including NJ limbs, retain signed path sums.
*/
fn tree_path_distances(tree: const TreeResult&, missing_zero: bool = false) -> TreeDistances {
    let a = tree_analysis(tree);
    if a.error.len > 0 { return TreeDistances { [], copy(a.error) }; }
    var values: f64[>..] = [];
    for i in a.labels.len {
        for j in a.labels.len {
            var sum = 0.0;
            for node, k in tree.nodes {
                if k == tree.root { continue; }
                if !node.has_length && !missing_zero {
                    return TreeDistances { [], "missing branch length" };
                }
                let x = (a.masks[k] >> i) & 1;
                let y = (a.masks[k] >> j) & 1;
                if x != y && node.has_length { sum += node.length; }
            }
            if is_nan(sum) || is_inf(sum) { return TreeDistances { [], "distance overflow" }; }
            values.push(sum);
        }
    }
    TreeDistances { copy(values), "" }
}

/*
Each supplied replicate counts once and must have the same taxa. Percent support
includes the root; absent clades get zero and leaves get -1. Replicates are supplied,
without resampling or a random-number contract.
*/
fn bootstrap_support(target: const TreeResult&, replicates: const TreeResult&[:]) -> TreeSupport {
    let a = tree_analysis(target);
    if a.error.len > 0 { return TreeSupport { [], copy(a.error) }; }
    if replicates.len == 0 { return TreeSupport { [], "no replicate trees" }; }
    var counts: f64[>..] = [];
    for node in target.nodes { counts.push(0); }
    var target_refs: const TreeNode&[>..] = [];
    for node in target.nodes { target_refs.push(node); }
    for tree in replicates {
        let b = phylo_remap(tree, a.labels);
        if b.error.len > 0 { return TreeSupport { [], copy(b.error) }; }
        for mask, i in a.masks {
            if target_refs[i].children.len == 0 { continue; }
            for other in b.masks { if mask == other { counts[i] += 1; break; } }
        }
    }
    for node, i in target.nodes {
        if node.children.len == 0 { counts[i] = -1; }
        else { counts[i] = 100*counts[i]/replicates.len; }
    }
    TreeSupport { copy(counts), "" }
}

/*
Cutoffs lie in [0.5,1]. Frequencies must exceed the cutoff, except 1 selects unanimous
clades. Exactly half-supported clades remain unresolved. Support is separate percent
data, with -1 for leaves.
*/
/* Nodes have absent lengths and empty internal labels; replicate metadata is not copied or averaged.
 * Parent/clade scans are quadratic. No rerooting, unrooted splits, evolutionary models, likelihood,
 * or supermatrix API. */
fn rooted_majority_consensus(replicates: const TreeResult&[:], cutoff: f64 = 0.5) -> ConsensusResult {
    var empty = TreeResult { [], -1, "" };
    if replicates.len == 0 || is_nan(cutoff) || cutoff < 0.5 || cutoff > 1 {
        return ConsensusResult { empty, [], "cutoff must be finite in [0.5,1]; trees required" };
    }
    let first = tree_analysis(replicates[0]);
    if first.error.len > 0 { return ConsensusResult { empty, [], copy(first.error) }; }
    var candidates: u64[>..] = []; var counts: i64[>..] = [];
    for tree in replicates {
        let a = phylo_remap(tree, first.labels);
        if a.error.len > 0 { return ConsensusResult { empty, [], copy(a.error) }; }
        for node, k in tree.nodes {
            let mask = a.masks[k];
            if node.children.len == 0 || k == tree.root { continue; }
            var found = false;
            for other, i in candidates {
                if mask == other { counts[i]++; found = true; break; }
            }
            if !found { candidates.push(mask); counts.push(1); }
        }
    }
    var masks: u64[>..] = []; var labels: u8[][>..] = [];
    var support: f64[>..] = [];
    for label, i in first.labels {
        masks.push((1 as u64) << i); labels.push(copy(label)); support.push(-1);
    }
    for mask, i in candidates {
        let frequency = (counts[i] as f64)/replicates.len;
        if frequency > cutoff || (cutoff == 1 && counts[i] == replicates.len) {
            masks.push(mask); labels.push(""); support.push(100*frequency);
        }
    }
    let root = masks.len;
    masks.push(((1 as u64) << first.labels.len)-1); labels.push(""); support.push(100);
    if first.labels.len == 1 {
        for label in first.labels {
            return ConsensusResult { TreeResult { [TreeNode { copy(label), [], 0, false }], 0, "" }, [-1], "" };
        }
    }
    var parents: i64[>..] = [];
    for mask, i in masks {
        var parent = root;
        for outer, j in masks {
            if i != j && (mask & outer) == mask && outer != mask {
                if (outer & masks[parent]) == outer { parent = j; }
            }
        }
        parents.push(parent);
    }
    var nodes: TreeNode[>..] = [];
    for label, i in labels {
        var children: i64[>..] = [];
        for parent, j in parents { if j != root && parent == i { children.push(j); } }
        nodes.push(TreeNode { copy(label), copy(children), 0, false });
    }
    ConsensusResult { TreeResult { copy(nodes), root, "" }, copy(support), "" }
}
