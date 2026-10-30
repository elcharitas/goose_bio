import bio from "..";
import bio.phylo.newick;
fn main() {
    let tree = bio::parse_newick("((human:0.1,chimp:0.2)apes:0.3,'mouse rat':0.4)root;");
    assert(tree.error.len == 0);
    assert(tree.nodes.len == 5 && tree.root == 4);
    assert(bio::tree_leaf_count(tree.nodes) == 3);
    for node, i in tree.nodes {
        if i == 0 { assert(node.label == "human" && node.length == 0.1); }
        if i == 2 { assert(node.label == "apes" && node.children.len == 2); }
        if i == 3 { assert(node.label == "mouse rat"); }
    }
    let escaped = bio::parse_newick("('O''Brien':1e-3,B:2);");
    assert(escaped.error.len == 0);
    for node, i in escaped.nodes { if i == 0 { assert(node.label == "O'Brien"); } }
    assert(bio::parse_newick("(A,B)").error.len > 0);
    assert(bio::parse_newick("(A,,B);").error.len > 0);
    assert(bio::parse_newick("(A:bad,B);").error.len > 0);
    assert(bio::parse_newick("A;extra").error.len > 0);
    assert(bio::parse_newick("'unterminated;").error.len > 0);
    assert(bio::parse_newick("(A[comment],B);").error.len > 0);
    var deep: u8[>..] = [];
    for i in 514 { deep.push('('); }
    deep.push('A');
    for i in 514 { deep.push(')'); }
    deep.push(';');
    assert(bio::parse_newick(deep).error.len > 0);
    var wide: u8[>..] = [];
    wide.push('(');
    for i in 1025 { if i > 0 { wide.push(','); } wide.push('A'); }
    wide.push(')'); wide.push(';');
    assert(bio::parse_newick(wide).error.len > 0);
    print("phylogeny: passed");
}
