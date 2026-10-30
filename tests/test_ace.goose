// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.io.ace;
fn main() {
    let text = "AS 1 1\nCO c 4 1 1 U\nA*CG\n\nBQ\n8 9 10\n\nAF r C 0\nBS 1 4 r\nRD r 5 0 0\nTA*CG\n\nQA 1 5 2 5";
    let result = bio::parse_ace(text);
    assert(result.error.len == 0);
    for c in result.assembly.contigs {
        let inspection = bio::ace_inspect_placement(copy(c), "r");
        assert(inspection.error.len == 0 && inspection.bases.len == 5);
        for b, i in inspection.bases {
            assert(b.contig_padded == i);
            assert(b.in_contig == (i > 0));
        }
        assert(bio::ace_inspect_placement(copy(c), "missing").error.len > 0);
    }
    var with_ds: u8[>..] = []; with_ds.append(text); with_ds.append("\nDS CHROMAT_FILE: a  \r\n");
    let raw = bio::parse_ace(with_ds); assert(raw.error.len == 0);
    for c in raw.assembly.contigs { for r in c.reads { assert(r.has_ds && r.ds == "CHROMAT_FILE: a  "); } }
    var tag: u8[>..] = []; tag.append(text); tag.append("\nCT{\nc TYPE prog 1 4 date\nCOMMENT{\nordinary text\nC}\n}\n");
    assert(bio::parse_ace(tag).error.len == 0);
    tag.clear(); tag.append(text); tag.append("\nCT{\nc TYPE prog 1 4 date\nCOMMENT{\ntext { nested }\nC}\n}\n");
    assert(bio::parse_ace(tag).error.len > 0);
    for opening in ["COMMENT{inline { nested }", "COMMENT{inline }"] {
        var inline_tag: u8[>..] = []; inline_tag.append(text); inline_tag.append("\nCT{\nc TYPE prog 1 4 date\n");
        inline_tag.append(opening); inline_tag.append("\nC}\n}\n");
        assert(bio::parse_ace(inline_tag).error.len > 0);
    }
    for text in ["AS 1 1", "AS 1 1\nCO c 4 1 0 U\nACGT", "AS 1 1\nCO c 4 1 0 U\nACGT\n\nBQ\n1 2 3 4"] {
        let result = bio::parse_ace(text);
        assert(result.error.len > 0 && result.assembly.contigs.len == 0);
    }
}
