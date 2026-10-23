namespace bio;
import std;
import .specialist_fields;
struct UniGeneEntry { fields: SpecialistField[], raw: u8[] }
struct UniGeneRecord { id: u8[], species: u8[], metadata: SpecialistField[], sequences: UniGeneEntry[], raw: u8[] }
struct UniGeneResult { records: UniGeneRecord[], error: u8[] }
/*
Retains cluster ID, species prefix, ordered metadata, sequence pairs, and raw text.
EXPRESS, RESTR_EXPR, PROTSIM, STS, TXMAP, and unknown tags remain untyped strings.
Sequence pairs split at the first equals sign only.
*/
/*
SCOUNT must occur once and equal the SEQUENCE count; records end with //. Indented
continuations fail. Empty input yields no records. Raw omits blank lines, normalizes
CRLF, and ends with LF; field order and duplicate keys survive. Whole-input byte parsing
has no file, encoding, or network API.
*/
fn parse_unigene(text: u8[:]) -> UniGeneResult {
    var records: UniGeneRecord[>..] = []; var id: u8[>..] = [];
    var metadata: SpecialistField[>..] = []; var sequences: UniGeneEntry[>..] = [];
    var raw: u8[>..] = []; var count = -1;
    for input in split(text,'\n') {
        let line = format_line(input);
        if line.len == 0 { continue; }
        if line == "//" {
            if id.len == 0 || count != sequences.len { return UniGeneResult { [], "UniGene SCOUNT mismatch or missing ID" }; }
            raw.append("//\n");
            var species: u8[>..] = [];
            for c in id { if c == '.' { break; } species.push(c); }
            records.push(UniGeneRecord { copy(id), copy(species), copy(metadata), copy(sequences), copy(raw) });
            id.clear(); metadata.clear(); sequences.clear(); raw.clear(); count = -1; continue;
        }
        if line.len < 12 { return UniGeneResult { [], "short UniGene field" }; }
        let key = trim(line[..12]); let value = trim(line[12..]);
        if key.len == 0 { return UniGeneResult { [], "UniGene continuation unsupported" }; }
        if key == "ID" {
            if id.len > 0 || value.len == 0 { return UniGeneResult { [], "invalid UniGene ID" }; }
            id.append(value);
        } else {
            if id.len == 0 { return UniGeneResult { [], "UniGene field before ID" }; }
            if key == "SCOUNT" {
                let n, ok = specialist_uint(value);
                if !ok || count >= 0 { return UniGeneResult { [], "invalid duplicate UniGene SCOUNT" }; }
                count = n;
            }
            if key == "SEQUENCE" {
                var fields: SpecialistField[>..] = [];
                for part in split(value,';') {
                    let p = specialist_pair(part,'=');
                    if p.error.len > 0 { return UniGeneResult { [], "invalid UniGene sequence entry" }; }
                    fields.push(copy(p.field));
                }
                sequences.push(UniGeneEntry { copy(fields), str(value) });
            } else { metadata.push(SpecialistField { str(key), str(value) }); }
        }
        raw.append(line); raw.push('\n');
    }
    if id.len > 0 { return UniGeneResult { [], "unterminated UniGene record" }; }
    return UniGeneResult { copy(records), "" };
}
