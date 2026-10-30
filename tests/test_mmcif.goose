import bio from "..";
import bio.structure.mmcif;
fn main() {
    let text = "data_demo\n_title 'a # title'\n_note\n;first\nsecond\n;\nloop_\n_test.id\n_test.value\n1 .\n2 ?\n3 '.'\n4 '?'\n5 'don\'t stop'\n";
    let p = bio::parse_mmcif(text);
    assert(p.error.len == 0);
    let w = bio::write_mmcif(p.document);
    assert(w.error.len == 0);
    let q = bio::parse_mmcif(w.text);
    assert(q.error.len == 0);
    assert(p.document.items.len == q.document.items.len);
    var before: const bio::CifToken&[>..] = [];
    for item in p.document.items { for t in item.values { before.push(t); } }
    var n = 0;
    for item in q.document.items { for t in item.values {
        assert(t.text == before[n].text && t.kind == before[n].kind); n += 1;
    } }
    assert(bio::parse_mmcif("data_x\nloop_\n_a\n_b\n1\n").error.len > 0);
    assert(bio::parse_mmcif("data_x\n_a 'bad\n").error.len > 0);
    assert(bio::parse_mmcif("data_x\n_a\n;bad\n").error.len > 0);
    assert(bio::parse_mmcif("data_x\nsave_a\n").error.len > 0);
    assert(bio::parse_mmcif("data_x\ndata_y\n").error.len > 0);
    assert(bio::parse_mmcif("data_x\n_a 1\n_A 2\n").error.len > 0);
    let lex = bio::tokenize_mmcif("abc#def 'loop_' \"a'b\" # comment\n. ? '.' '?'\n");
    assert(lex.error.len == 0 && lex.tokens.len == 7);
    let impossible = bio::CifDocument { "x", [bio::CifItem { ["_a"],
        [bio::CifToken { "both'\"\n;delimiter", 0, true }], false }] };
    assert(bio::write_mmcif(impossible).error.len > 0);
    let loop_text = bio::parse_mmcif("data_x\nloop_\n_a\n_b\n1\n;line one\nline two\n;\n2 'loop_'\n");
    assert(loop_text.error.len == 0);
    let loop_written = bio::write_mmcif(loop_text.document);
    assert(loop_written.error.len == 0);
    for ending in ["\r", "\r\n", "\n"] {
        let cr = bio::parse_mmcif(str("data_x", ending, "_a 1", ending,
            "# comment", ending, "_b 2", ending, "_c", ending,
            ";first", ending, "second", ending, ";", ending));
        assert(cr.error.len == 0 && cr.document.items.len == 3);
        for item in cr.document.items {
            for t in item.values {
                assert(t.text == "1" || t.text == "2" || t.text == "first\nsecond");
            }
        }
    }
    for value in ["$foo", "[foo]", "]foo", ";foo"] {
        assert(bio::parse_mmcif(str("data_x\n_a ", value, "\n")).error.len > 0);
        let reserved = bio::parse_mmcif(str("data_x\n_a '", value, "'\n"));
        assert(reserved.error.len == 0);
        let encoded = bio::write_mmcif(reserved.document);
        assert(encoded.error.len == 0);
        assert(encoded.text == str("data_x\n_a\n'", value, "'\n"));
        assert(bio::parse_mmcif(encoded.text).error.len == 0);
    }
    assert(bio::parse_mmcif("data_x\n_a 'a\rb'\n").error.len > 0);
    let cr_literal = bio::CifDocument { "x", [bio::CifItem { ["_a"],
        [bio::CifToken { "a\rb", 0, true }], false }] };
    assert(bio::write_mmcif(cr_literal).error.len > 0);
    print("mmcif: passed");
}
