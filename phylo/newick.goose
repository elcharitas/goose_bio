namespace bio;
import std;
import math;

struct TreeNode { label: u8[], children: i64[], length: f64, has_length: bool }
struct TreeResult { nodes: TreeNode[], root: i64, error: u8[] }
struct NewickCursor { position: i64 = 0, failed: bool = false }

fn newick_space(text: const u8[:], cursor: NewickCursor&) {
    while cursor.position < text.len {
        let c = text[cursor.position];
        if c != ' ' && c != '\t' && c != '\r' && c != '\n' { break; }
        cursor.position++;
    }
}

recursive fn newick_node(text: const u8[:], cursor: NewickCursor&,
               nodes: TreeNode[>..]&, depth: i64) -> i64 {
    if depth > 512 { cursor.failed = true; return -1; }
    newick_space(text, cursor);
    if cursor.position >= text.len { cursor.failed = true; return -1; }
    var children: i64[1024];
    var child_count: i64 = 0;
    if text[cursor.position] == '(' {
        cursor.position++;
        loop {
            let child = newick_node(text, cursor, nodes, depth + 1);
            if cursor.failed { return -1; }
            if child_count == 1024 { cursor.failed = true; return -1; }
            children[child_count] = child; child_count++;
            newick_space(text, cursor);
            if cursor.position >= text.len { cursor.failed = true; return -1; }
            let delimiter = text[cursor.position];
            cursor.position++;
            if delimiter == ')' { break; }
            if delimiter != ',' { cursor.failed = true; return -1; }
        }
    }
    newick_space(text, cursor);
    var label: u8[>..] = [];
    if cursor.position < text.len && text[cursor.position] == '\'' {
        cursor.position++;
        var closed = false;
        while cursor.position < text.len {
            let c = text[cursor.position];
            cursor.position++;
            if c == '\'' {
                if cursor.position < text.len && text[cursor.position] == '\'' {
                    label.push('\''); cursor.position++;
                } else { closed = true; break; }
            } else { label.push(c); }
        }
        if !closed { cursor.failed = true; return -1; }
    } else {
        while cursor.position < text.len {
            let c = text[cursor.position];
            if c == ':' || c == ',' || c == ')' || c == ';' || c == '(' ||
               c == ' ' || c == '\t' || c == '\r' || c == '\n' { break; }
            if c == '[' || c == ']' { cursor.failed = true; return -1; }
            label.push(c); cursor.position++;
        }
    }
    if child_count == 0 && label.len == 0 { cursor.failed = true; return -1; }
    newick_space(text, cursor);
    var length = 0.0;
    var has_length = false;
    if cursor.position < text.len && text[cursor.position] == ':' {
        cursor.position++;
        newick_space(text, cursor);
        let start = cursor.position;
        while cursor.position < text.len {
            let c = text[cursor.position];
            if c == ',' || c == ')' || c == ';' || c == ' ' || c == '\n' || c == '\r' || c == '\t' { break; }
            cursor.position++;
        }
        let value, ok = parse_flt(text[start..cursor.position]);
        if !ok || (is_nan(value) || is_inf(value)) { cursor.failed = true; return -1; }
        length = value; has_length = true;
    }
    let index = nodes.len;
    nodes.push(TreeNode { copy(label), children[..child_count], length, has_length });
    index
}

fn parse_newick(text: const u8[:]) -> TreeResult {
    var nodes: TreeNode[>..] = [];
    var cursor = NewickCursor {};
    let root = newick_node(text, cursor, nodes, 0);
    newick_space(text, cursor);
    if cursor.failed || cursor.position >= text.len || text[cursor.position] != ';' {
        return TreeResult { [], -1, "invalid or unsupported Newick tree" };
    }
    cursor.position++;
    newick_space(text, cursor);
    if cursor.position != text.len { return TreeResult { [], -1, "trailing Newick data" }; }
    TreeResult { copy(nodes), root, "" }
}

fn tree_leaf_count(nodes: const TreeNode[:]) -> i64 {
    var count: i64 = 0;
    for node in nodes { if node.children.len == 0 { count++; } }
    count
}
