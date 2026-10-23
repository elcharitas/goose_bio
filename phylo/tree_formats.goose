namespace bio;
import std;
import .phylo_analysis;

// Canonical single-tree NEXUS subset; no implicit metadata conversion.
/*
Requires exactly #NEXUS\nBEGIN TREES;\nTREE tree = followed by one Newick tree and
\nEND;\n, including final LF and exact keywords/spacing/name. Supports quoted Newick
labels and finite lengths; numeric internal labels remain labels, never support.
*/
/*
Comments, annotations, rooting directives, TRANSLATE, extra trees/blocks, and bracket
labels fail explicitly. This canonical envelope is not general NEXUS; names/annotations
are never silently discarded.
*/
fn parse_nexus_tree(text: const u8[:]) -> TreeResult {
    let prefix = "#NEXUS\nBEGIN TREES;\nTREE tree = ";
    let suffix = "\nEND;\n";
    if text.len <= prefix.len + suffix.len {
        return TreeResult { [], -1, "unsupported NEXUS envelope" };
    }
    if text[..prefix.len] != prefix || text[text.len-suffix.len..] != suffix {
        return TreeResult { [], -1, "only canonical single TREE tree envelope supported" };
    }
    for c in text {
        if c == '[' || c == ']' {
            return TreeResult { [], -1, "NEXUS comments and annotations unsupported" };
        }
    }
    let tree = parse_newick(text[prefix.len..text.len-suffix.len]);
    let a = tree_analysis(tree);
    if a.error.len > 0 { return TreeResult { [], -1, copy(a.error) }; }
    tree
}

/*
Quotes labels and preserves their values/lengths; numeric spelling may change. Consensus
support has no writer here. Export its tree only when intentionally omitting the
separate support array.
*/
fn serialize_nexus_tree(tree: const TreeResult&) -> NewickResult {
    let a = tree_analysis(tree);
    if a.error.len > 0 { return NewickResult { "", copy(a.error) }; }
    let nw = serialize_newick(tree);
    for c in nw.text {
        if c == '[' || c == ']' {
            return NewickResult { "", "bracket labels unsupported in NEXUS subset" };
        }
    }
    var out: u8[>..] = [];
    for c in "#NEXUS\nBEGIN TREES;\nTREE tree = " { out.push(c); }
    for c in nw.text { out.push(c); }
    for c in "\nEND;\n" { out.push(c); }
    NewickResult { copy(out), "" }
}
