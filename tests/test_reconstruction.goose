import bio from "..";
import bio.phylo.reconstruction;
import bio.phylo.newick;
import math;
fn verify_distances(tree: const bio::TreeResult&, expected: const f64[:], count: i64, scale: f64) {
    var parents: i64[>..] = []; var lengths: f64[>..] = [];
    for node in tree.nodes { parents.push(-1); lengths.push(node.length/scale); }
    for node, i in tree.nodes { for child in node.children { parents[child] = i; } }
    for a in count { for b in count {
        var x = a; var da = 0.0; var found = false;
        while x >= 0 && !found {
            var y = b; var db = 0.0;
            while y >= 0 {
                if x == y { assert(abs(da+db-expected[a*count+b]) < 1e-10); found = true; break; }
                db += lengths[y]; y = parents[y];
            }
            da += lengths[x]; x = parents[x];
        }
        assert(found);
    } }
}
fn main() {
    let labels: u8[][] = ["A", "B", "C", "O'Brien rat"];
    let d = [0.0,2,6,6, 2,0,6,6, 6,6,0,4, 6,6,4,0];
    let tree = bio::upgma(labels,d);
    assert(tree.error.len == 0 && tree.nodes.len == 7);
    for node, i in tree.nodes {
        if i < 2 { assert(node.length == 1); }
        if i == 2 || i == 3 { assert(node.length == 2); }
        if i == 4 { assert(node.length == 2); }
        if i == 5 { assert(node.length == 1); }
    }
    verify_distances(tree,d,4,1);
    let text = bio::serialize_newick(tree);
    assert(text.error.len == 0);
    let parsed = bio::parse_newick(text.text);
    assert(parsed.error.len == 0 && parsed.nodes.len == 7);
    var found = false;
    for node in parsed.nodes { if node.label == "O'Brien rat" { found = true; } }
    assert(found);
    let nj = bio::neighbor_joining(labels,[0.0,5,9,9, 5,0,10,10, 9,10,0,8, 9,10,8,0]);
    assert(nj.error.len == 0);
    verify_distances(nj,[0.0,5,9,9, 5,0,10,10, 9,10,0,8, 9,10,8,0],4,1);
    var nr: const bio::TreeNode&[>..] = [];
    for node in nj.nodes { nr.push(node); }
    assert(abs(nr[0].length-2) < 1e-12);
    assert(abs(nr[1].length-3) < 1e-12);
    assert(abs(nr[2].length-4) < 1e-12);
    assert(abs(nr[3].length-4) < 1e-12);
    assert(bio::upgma(labels,[0.0]).error.len > 0);
    let duplicates: u8[][] = ["A","A"];
    let pair: u8[][] = ["A","B"];
    let singleton: u8[][] = ["A"];
    assert(bio::upgma(duplicates,[0.0,1,1,0]).error.len > 0);
    assert(bio::upgma(pair,[0.0,1,2,0]).error.len > 0);
    assert(bio::upgma(pair,[0.0,-1,-1,0]).error.len > 0);
    let one = bio::neighbor_joining(singleton,[0.0]);
    assert(one.error.len == 0 && one.root == 0);
    let weighted = bio::upgma(labels,[0.0,2,4,10, 2,0,6,12, 4,6,0,14, 10,12,14,0]);
    assert(weighted.error.len == 0);
    for node, i in weighted.nodes { if i == 3 { assert(node.length == 6); } }
    let triple: u8[][] = ["A","B","C"];
    let negative = bio::neighbor_joining(triple,[0.0,1,1, 1,0,3, 1,3,0]);
    assert(negative.error.len == 0);
    verify_distances(negative,[0.0,1,1, 1,0,3, 1,3,0],3,1);
    for node, i in negative.nodes { if i == 0 { assert(node.length == -0.5); } }
    let source = bio::parse_newick("('a''b':0.1234567890123456,B:-1.25e-12)root:4;");
    let round = bio::parse_newick(bio::serialize_newick(source).text);
    assert(round.error.len == 0);
    var rr: const bio::TreeNode&[>..] = [];
    for node in round.nodes { rr.push(node); }
    for node, i in source.nodes {
        assert(rr[i].label == node.label);
        assert(rr[i].length == node.length);
        assert(rr[i].has_length == node.has_length);
    }
    for joining in [false,true] {
        let huge = bio::reconstruct_tree(triple,
            [0.0,1e308,1e308,1e308,0,1e308,1e308,1e308,0],joining);
        assert(huge.error.len == 0);
        verify_distances(huge,[0.0,1,1,1,0,1,1,1,0],3,1e308);
        for node, i in huge.nodes {
            if i < 2 { assert(abs(node.length/5e307-1) < 1e-12); }
            if i == 2 && !joining { assert(abs(node.length/5e307-1) < 1e-12); }
        }
    }
    let unsupported = bio::upgma(triple,
        [0.0,1e-300,1e308,1e-300,0,1e308,1e308,1e308,0]);
    assert(unsupported.error == "unsupported distance scale separation");
    print("reconstruction: passed");
}
