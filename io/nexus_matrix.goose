// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
struct NexusCell { kind: i64, states: u8[] }
struct NexusSet { name: u8[], taxa: bool, indices: i64[] }
struct NexusPartition { name: u8[], taxa: bool, parts: NexusSet[] }
struct NexusMatrix { taxa: u8[][], rows: NexusCell[][], datatype: u8[], symbols: u8[], respectcase: bool, missing: u8[], gap: u8[], matchchar: u8[], sets: NexusSet[], partitions: NexusPartition[] }
struct NexusResult { matrix: NexusMatrix, error: u8[] }
struct NexusTokens { words: u8[][], error: u8[] }
fn nm_empty() -> NexusMatrix { return NexusMatrix { [], [], ['S','T','A','N','D','A','R','D'], ['0','1'], false, ['?'], ['-'], ['.'], [], [] }; }
fn nm_fail(s: u8[:]) -> NexusResult { return NexusResult { nm_empty(), str(s) }; }
fn nm_upper(s: u8[:]) -> u8[] { var o: u8[>..] = []; for b in s { o.push(if b >= 'a' && b <= 'z' { b-32 } else { b }); } return copy(o); }
// A control prefix preserves quote identity; input forbids controls.
fn nm_text(s: u8[:]) -> u8[] { return if s.len > 0 && s[0] == 1 { str(s[1..]) } else { str(s) }; }
/*
Accepts printable ASCII, tabs/endings, nested comments, single/double labels, and
doubled quote escapes. Quoted punctuation/keywords retain literal identity through
parsing, set expansion, and export; they never act as syntax.
*/
/*
Limits: 64 MiB input, two million tokens, 1 MiB/token, 64 comment levels, 4096
expression tokens. Whole-input owned arrays/copies provide no streaming or high-
throughput guarantee.
*/
fn nm_tokens(s: u8[:]) -> NexusTokens {
    var w: u8[][>..] = []; var i = 0;
    while i < s.len {
        let b = s[i];
        if b == '[' { var depth = 1; i += 1; while i < s.len && depth > 0 { if s[i] == '[' { depth += 1; } if s[i] == ']' { depth -= 1; } if depth > 64 { return NexusTokens { [], "comment nesting" }; } i += 1; } if depth != 0 { return NexusTokens { [], "unclosed comment" }; } continue; }
        if b == ']' { return NexusTokens { [], "stray comment close" }; }
        if b == ' ' || b == '\t' { i += 1; continue; }
        var t: u8[>..] = [];
        if b == '\'' || b == '"' {
            t.push(1); let quote = b; i += 1; var closed = false;
            while i < s.len { if s[i] == quote { i += 1; if i < s.len && s[i] == quote { t.push(quote); i += 1; } else { closed = true; break; } } else { if s[i] < 32 { return NexusTokens { [], "control in quote" }; } t.push(s[i]); i += 1; } }
            if i < s.len && s[i] > 32 && s[i] != ';' && s[i] != ',' && s[i] != ':' && s[i] != '=' && s[i] != '[' { return NexusTokens { [], "adjacent quoted token" }; }
            if !closed || t.len == 1 { return NexusTokens { [], "invalid quote" }; }
        } else if b == '\n' || b == '\r' || b == ';' || b == '=' || b == ':' || b == ',' || b == '(' || b == ')' || b == '{' || b == '}' || b == '\\' || b == '-' { t.push(if b == '\r' { '\n' } else { b }); i += 1; }
        else { while i < s.len { let c = s[i]; if c <= 32 || c == '[' || c == ']' || c == ';' || c == '=' || c == ':' || c == ',' || c == '(' || c == ')' || c == '{' || c == '}' || c == '\\' || c == '-' || c == '\'' || c == '"' { break; } t.push(c); i += 1; } if t.len == 0 { return NexusTokens { [], "invalid character" }; } }
        if t.len > 1048576 { return NexusTokens { [], "token size limit" }; } w.push(copy(t)); if w.len > 2000000 { return NexusTokens { [], "token limit" }; }
    }
    return NexusTokens { copy(w), "" };
}
fn nm_num(s: u8[:]) -> i64 { if s.len == 0 || s.len > 7 { return -1; } for b in s { if b < '0' || b > '9' { return -1; } } let n, ok = parse_int(s); return if ok { n } else { -1 }; }
fn nm_has(s: u8[:], b: u8) -> bool { for a in s { if a == b { return true; } } return false; }
/*
Cells occupy one character: kind 0 singleton, 1 polymorphic (01), 2 uncertain {01}.
Groups require STANDARD and distinct declared states. Match characters copy resolved
first-taxon cells; a match in that reference taxon fails. Matches expand before
transforms.
*/
/*
Matrix caps: one million cells, 4096 taxa, 128 symbols, 16 million cell-copy work units.
Valid larger workloads may reject before cell limits.
*/
fn nm_cells(w: const u8[:][:], m: NexusMatrix) -> NexusCell[], u8[:] {
    var cells: NexusCell[>..] = []; var kind = 0; var states: u8[>..] = [];
    for t in w {
        if cells.len >= 1000000 { return [], "cell limit"; }
        if t == "(" || t == "{" { if kind != 0 || m.datatype != "STANDARD" { return [], "invalid cell group"; } kind = if t == "(" { 1 } else { 2 }; states.clear(); continue; }
        if t == ")" || t == "}" { if kind == 0 || (t == ")" && kind != 1) || (t == "}" && kind != 2) || states.len == 0 { return [], "cell delimiter"; } cells.push(NexusCell { kind, copy(states) }); kind = 0; continue; }
        for raw in nm_text(t) { let special = nm_has(m.missing,raw) || nm_has(m.gap,raw) || nm_has(m.matchchar,raw); let b = if !special && !m.respectcase && raw >= 'a' && raw <= 'z' { raw-32 } else { raw };
            let alphabet: u8[] = if m.respectcase { copy(m.symbols) } else { nm_upper(m.symbols) }; if !nm_has(alphabet,b) && !special { return [], "invalid matrix symbol"; }
            if cells.len >= 1000000 { return [], "cell limit"; } if kind == 0 { cells.push(NexusCell { 0, str([b]) }); } else { if special || nm_has(states,b) { return [], "invalid grouped state"; } states.push(b); }
        }
    }
    if kind != 0 { return [], "unclosed cell"; } return copy(cells), "";
}
struct NmDefinition { name: u8[], taxa: bool, expression: u8[][] }
/*
CHARSET/TAXSET resolve named sets, inclusive one-based ranges, positive strides (1-9\2),
and . for final index; TAXSET also accepts labels. Public indices are
sorted/deduplicated zero-based. Names ignore case, labels match exactly; unquoted
numbers are indices, quoted numeric labels are labels.
*/
/*
Partitions resolve sets, never other partitions; sets may overlap and members need not
cover/disjointly partition positions. Empty expressions survive. Caps: 256
sets/partitions, 256 members each, 65 expansion passes, two million membership/expansion
work units.
*/
fn nm_resolve(defs: NmDefinition[:], at: i64, labels: u8[][:], size: i64, work: i64&) -> i64[], u8[] {
    work += size; if work > 2000000 { return [], "membership limit"; }
    var expr: u8[][>..] = []; var target_taxa = false;
    for d,i in defs { if i == at { target_taxa = d.taxa; expr.append(d.expression); } }
    var expanded = false;
    for depth in 65 {
        var next: u8[][>..] = []; expanded = false;
        for t in expr {
            work += 1; if work > 2000000 { return [], "set work limit"; }
            if nm_num(t) >= 0 || t == "." || t == "-" || t == "\\" || t == "," { next.push(copy(t)); continue; }
            var found = false;
            if target_taxa { for label,i in labels { if label == nm_text(t) { next.push(str(i+1)); found = true; } } }
            if !found { for d in defs { if d.taxa == target_taxa && nm_upper(d.name) == nm_upper(nm_text(t)) { if next.len+d.expression.len > 4096 { return [], "expression expansion limit"; } next.append(d.expression); found = true; expanded = true; } } }
            if !found { return [], "unknown set reference"; }
        }
        if next.len > 4096 { return [], "expression limit"; } expr.clear(); expr.append(next); if !expanded { break; }
    }
    if expanded { return [], "set cycle or nesting limit"; }
    var values: bool[>..] = []; for i in size { values.push(false); }
    var ex_tokens: const u8[:][>..] = []; for t in expr { ex_tokens.push(t); } var p = 0; while p < ex_tokens.len {
        let t = ex_tokens[p]; p += 1; if t == "," { continue; }
        let a = if t == "." { size } else { nm_num(t) };
        var end = a; var stride = 1;
        if p < expr.len && ex_tokens[p] == "-" { p += 1; if p == expr.len { return [], "missing range end"; } end = if ex_tokens[p] == "." { size } else { nm_num(ex_tokens[p]) }; p += 1; }
        if p < expr.len && ex_tokens[p] == "\\" { p += 1; if p == expr.len { return [], "missing stride"; } stride = nm_num(ex_tokens[p]); p += 1; }
        if a < 1 || end < a || end > size || stride < 1 { return [], "set range bounds"; }
        var x = a; while x <= end { work += 1; if work > 2000000 { return [], "membership work limit"; } values[x-1] = true; x += stride; }
    }
    var out: i64[>..] = []; for yes,i in values { if yes { out.push(i); } } return copy(out), "";
}
/*
Returns an ordered matrix or empty matrix/error. Accepts TAXA/DATA/CHARACTERS/SETS;
unknown blocks/commands fail without discarding semantics. TREES, ASSUMPTIONS, CODONS,
TOKENS, TRANSPOSE, continuous/mixed, EQUATE, and tree integration are unsupported.
*/
/*
Sequential rows may wrap with unlabeled continuations. Interleaved pages need labels in
taxon order, equal widths, and complete pages; blank lines do not define pages. Taxa
compare case-insensitively for duplicates and must match TAXLABELS order.
*/
/*
FORMAT supports DNA/RNA/NUCLEOTIDE/PROTEIN/STANDARD, SYMBOLS, RESPECTCASE, MISSING, GAP,
MATCHCHAR, and INTERLEAVE (bare/YES/NO). Defaults: STANDARD, 01, ?, -, ., case-
insensitive. Declared strings survive; singleton states uppercase unless RESPECTCASE.
*/
fn parse_nexus_matrix(text: u8[:]) -> NexusResult {
    if text.len == 0 || text.len > 67108864 { return nm_fail("input limit"); }
    for b in text { if (b < 32 && b != '\n' && b != '\r' && b != '\t') || b > 126 { return nm_fail("non-ASCII input"); } }
    let lex = nm_tokens(text); if lex.error.len > 0 { return nm_fail(lex.error); }
    var w: const u8[:][>..] = []; for t in lex.words { w.push(t); } var p = 0; while p < w.len && w[p] == "\n" { p += 1; }
    if p == w.len || nm_upper(w[p]) != "#NEXUS" { return nm_fail("expected NEXUS header"); } p += 1;
    var m_taxa: u8[][>..] = []; var m_rows: NexusCell[][>..] = []; var m_datatype: u8[>..] = []; m_datatype.append("STANDARD"); var declared_symbols: u8[>..] = []; var m_symbols: u8[>..] = []; m_symbols.append("01"); var m_respectcase = false; var m_missing: u8[>..] = ['?']; var m_gap: u8[>..] = ['-']; var m_matchchar: u8[>..] = ['.']; var m_sets: NexusSet[>..] = []; var m_partitions: NexusPartition[>..] = []; var section: u8[>..] = []; var ntax = -1; var nchar = -1; var interleave = false; var matrix_seen = false;
    var defs: NmDefinition[>..] = []; var parts: NexusPartition[>..] = []; var partdefs: NmDefinition[][>..] = [];
    while p < w.len {
        var cmd: const u8[:][>..] = []; while p < w.len && w[p] != ";" { cmd.push(w[p]); p += 1; }
        var c: const u8[:][>..] = []; for t in cmd { if t != "\n" { c.push(t); } }
        if c.len == 0 { if p < w.len { return nm_fail("empty command"); } break; }
        if p == w.len { return nm_fail("unterminated command"); } p += 1; let op = nm_upper(c[0]);
        if op == "BEGIN" { if section.len > 0 || c.len != 2 { return nm_fail("nested section"); } section.clear(); section.append(nm_upper(c[1])); if section != "TAXA" && section != "DATA" && section != "CHARACTERS" && section != "SETS" { return nm_fail("unsupported semantic section"); } continue; }
        if op == "END" || op == "ENDBLOCK" { if section.len == 0 || c.len != 1 { return nm_fail("invalid END"); } section.clear(); continue; }
        if section.len == 0 { return nm_fail("command outside section"); }
        if op == "DIMENSIONS" && section != "SETS" && !matrix_seen {
            var j = 1; while j < c.len { if j+2 >= c.len || c[j+1] != "=" { return nm_fail("invalid dimensions"); } let key = nm_upper(c[j]); let n = nm_num(c[j+2]); if n < 1 || n > 1000000 { return nm_fail("dimension bounds"); }
                if key == "NTAX" { if ntax != -1 && ntax != n { return nm_fail("conflicting NTAX"); } ntax = n; } else if key == "NCHAR" && section != "TAXA" { if nchar != -1 { return nm_fail("repeated NCHAR"); } nchar = n; } else { return nm_fail("unsupported dimension"); } j += 3;
            } continue;
        }
        if op == "TAXLABELS" && section == "TAXA" { if m_taxa.len != 0 || matrix_seen { return nm_fail("repeated labels"); } if c.len > 4097 { return nm_fail("taxa label limit"); } var labels: u8[][>..] = []; for t in c[1..] { for old in labels { if nm_upper(old) == nm_upper(nm_text(t)) { return nm_fail("duplicate taxon"); } } labels.push(nm_text(t)); } m_taxa.clear(); m_taxa.append(copy(labels)); continue; }
        if op == "FORMAT" && (section == "DATA" || section == "CHARACTERS") && !matrix_seen {
            var j = 1; while j < c.len { let key = nm_upper(c[j]); j += 1;
                if key == "RESPECTCASE" { m_respectcase = true; continue; }
                if key == "INTERLEAVE" { interleave = true; if j < c.len && c[j] == "=" { j += 1; if j == c.len { return nm_fail("interleave value"); } let v = nm_upper(c[j]); if v != "YES" && v != "NO" { return nm_fail("interleave value"); } interleave = v == "YES"; j += 1; } continue; }
                if j+1 >= c.len || c[j] != "=" { return nm_fail("unsupported FORMAT"); } let v = nm_text(c[j+1]); j += 2;
                if key == "DATATYPE" { m_datatype.clear(); m_datatype.append(nm_upper(v)); if m_datatype == "DNA" || m_datatype == "RNA" || m_datatype == "NUCLEOTIDE" { m_symbols.clear(); m_symbols.append(if m_datatype == "RNA" { "ACGURYSWKMBDHVNX" } else if m_datatype == "NUCLEOTIDE" { "ACGTURYSWKMBDHVNX" } else { "ACGTRYSWKMBDHVNX" }); } else if m_datatype == "PROTEIN" { m_symbols.clear(); m_symbols.append("ACDEFGHIKLMNPQRSTVWYBXZJUO*"); } else if m_datatype != "STANDARD" { return nm_fail("unsupported datatype"); } }
                else if key == "SYMBOLS" { declared_symbols.clear(); declared_symbols.append(v); m_symbols.clear(); m_symbols.append(str(v)); } else if key == "MISSING" { m_missing.clear(); m_missing.append(str(v)); } else if key == "GAP" { m_gap.clear(); m_gap.append(str(v)); } else if key == "MATCHCHAR" { m_matchchar.clear(); m_matchchar.append(str(v)); } else { return nm_fail("unsupported FORMAT"); }
            } continue;
        }
        if op == "MATRIX" && (section == "DATA" || section == "CHARACTERS") && !matrix_seen {
            if ntax > 0 && nchar > 0 && ntax > 16000000/nchar/ntax { return nm_fail("matrix copy work limit"); }
            if ntax < 1 || nchar < 1 || ntax > 1000000/nchar || ntax > 4096 { return nm_fail("matrix bounds"); }
            if declared_symbols.len > 0 { m_symbols.clear(); m_symbols.append(declared_symbols); }
            if m_symbols.len > 128 { return nm_fail("symbol limit"); } for a,i in m_symbols { if a < 33 || a > 126 || nm_has("(){}[];,:=\\\"'",a) { return nm_fail("invalid symbol declaration"); } for b,j in m_symbols { if i != j && a == b { return nm_fail("duplicate symbol"); } } }
            if m_missing.len == 0 || m_gap.len == 0 || m_matchchar.len == 0 { return nm_fail("empty setting"); } if nm_has(m_symbols,m_missing[0]) || nm_has(m_symbols,m_gap[0]) || nm_has(m_symbols,m_matchchar[0]) { return nm_fail("symbol setting collision"); }
            if m_missing.len != 1 || m_gap.len != 1 || m_matchchar.len != 1 || m_missing == m_gap || m_gap == m_matchchar || m_missing == m_matchchar || m_symbols.len == 0 { return nm_fail("invalid settings"); }
            for setting in [m_missing[0],m_gap[0],m_matchchar[0]] { if setting < 33 || nm_has("(){}[];,:=\\\"'",setting) { return nm_fail("invalid special character"); } }
            var labels: u8[][>..] = []; labels.append(m_taxa); var owned_rows: NexusCell[][>..] = []; for i in ntax { owned_rows.push([]); }
            var line: const u8[:][>..] = []; var row = 0; var widths: i64[>..] = []; var first = true; var continuing = false; var copied_cells = 0;
            var tokens: const u8[:][>..] = []; var started = false; for t in cmd { if !started && nm_upper(t) == "MATRIX" { started = true; } else if started { tokens.push(t); } } tokens.push("\n");
            for t in tokens { if t != "\n" { line.push(t); continue; } if line.len == 0 { continue; }
                if !continuing && line.len < 2 { return nm_fail("matrix requires labeled rows"); }
                let idx = row % ntax;
                if !continuing && row < ntax { if m_taxa.len > 0 { if idx >= labels.len || nm_label(copy(labels),idx) != nm_text(line[0]) { return nm_fail("taxon order mismatch"); } } else { for old in labels { if nm_upper(old) == nm_upper(nm_text(line[0])) { return nm_fail("duplicate taxon"); } } labels.push(nm_text(line[0])); } }
                else if !continuing && (!interleave || nm_label(copy(labels),idx) != nm_text(line[0])) { return nm_fail("invalid interleave order"); }
                let cells, e = nm_cells(if continuing { line[..] } else { line[1..] },NexusMatrix { copy(m_taxa), copy(m_rows), copy(m_datatype), copy(m_symbols), m_respectcase, copy(m_missing), copy(m_gap), copy(m_matchchar), copy(m_sets), copy(m_partitions) }); if e.len > 0 { return nm_fail(e); }
                if interleave && idx == 0 { widths.clear(); widths.push(cells.len); } else if interleave && cells.len != widths[0] { return nm_fail("unequal page width"); }
                var joined: NexusCell[>..] = []; joined.append(nm_row(copy(owned_rows),idx)); joined.append(cells); if joined.len > nchar { return nm_fail("matrix exceeds dimensions"); } var next_rows: NexusCell[][>..] = []; for r,i in owned_rows { next_rows.push(if i == idx { copy(joined) } else { copy(r) }); } owned_rows.clear(); owned_rows.append(next_rows); copied_cells += ntax*nchar; if copied_cells > 16000000 { return nm_fail("matrix copy work limit"); } continuing = !interleave && joined.len < nchar; if !continuing { row += 1; } line.clear(); first = false;
            }
            if continuing || first || row % ntax != 0 || labels.len != ntax { return nm_fail("incomplete matrix page"); }
            var resolved_rows: NexusCell[][>..] = [];
            let reference = nm_row(copy(owned_rows),0); var ref_cells: NexusCell&[>..] = []; for c in reference { ref_cells.push(&c); }
            for r,i in owned_rows { if r.len != nchar { return nm_fail("matrix dimensions mismatch"); } var resolved: NexusCell[>..] = []; for cell,j in r { if cell.states == m_matchchar { if i == 0 || ref_cells[j].states == m_matchchar { return nm_fail("unresolved match character"); } resolved.push(copy(ref_cells[j])); } else { resolved.push(copy(cell)); } } resolved_rows.push(copy(resolved)); }
            m_taxa.clear(); m_taxa.append(copy(labels)); m_rows.clear(); m_rows.append(copy(resolved_rows)); matrix_seen = true; continue;
        }
        if section == "SETS" && (op == "CHARSET" || op == "TAXSET" || op == "CHARPARTITION" || op == "TAXPARTITION") {
            if c.len > 4096 || c.len < 3 || c[2] != "=" || defs.len+parts.len >= 256 { return nm_fail("invalid set definition"); } let taxa = op == "TAXSET" || op == "TAXPARTITION";
            if op == "CHARSET" || op == "TAXSET" { for d in defs { if d.taxa == taxa && nm_upper(d.name) == nm_upper(nm_text(c[1])) { return nm_fail("duplicate set"); } } defs.push(NmDefinition { nm_text(c[1]),taxa,nm_own(c[3..]) }); }
            else { var pd: NmDefinition[>..] = []; var j = 3; while j < c.len { if j+1 >= c.len || c[j+1] != ":" { return nm_fail("partition syntax"); } let name = c[j]; j += 2; var ex: u8[][>..] = []; while j < c.len && c[j] != "," { ex.push(str(c[j])); j += 1; } for d in pd { if nm_upper(d.name) == nm_upper(nm_text(name)) { return nm_fail("duplicate part"); } } if pd.len >= 256 { return nm_fail("partition membership limit"); } pd.push(NmDefinition { nm_text(name),taxa,copy(ex) }); if j < c.len { j += 1; if j == c.len { return nm_fail("trailing comma"); } } }
                for old in parts { if old.taxa == taxa && nm_upper(old.name) == nm_upper(nm_text(c[1])) { return nm_fail("duplicate partition"); } } parts.push(NexusPartition { nm_text(c[1]),taxa,[] }); partdefs.push(copy(pd)); }
            continue;
        }
        return nm_fail("unsupported command");
    }
    if section.len > 0 || !matrix_seen { return nm_fail("incomplete NEXUS"); }
    var sets: NexusSet[>..] = []; var work = 0;
    for d, i in defs { let indices,e = nm_resolve(defs,i,m_taxa,if d.taxa { ntax } else { nchar },work); if e.len > 0 { return nm_fail(e); } sets.push(NexusSet { copy(d.name),d.taxa,copy(indices) }); }
    for part, i in parts { var ps: NexusSet[>..] = []; for ds, di in partdefs { if di != i { continue; } for d in ds { var all: NmDefinition[>..] = []; all.append(defs); all.push(NmDefinition { "",d.taxa,copy(d.expression) }); let indices,e = nm_resolve(all,all.len-1,m_taxa,if d.taxa { ntax } else { nchar },work); if e.len > 0 { return nm_fail(e); } ps.push(NexusSet { copy(d.name),d.taxa,copy(indices) }); } } m_partitions.push(NexusPartition { copy(part.name),part.taxa,copy(ps) }); }
    m_sets.clear(); m_sets.append(copy(sets)); return NexusResult { NexusMatrix { copy(m_taxa), copy(m_rows), copy(m_datatype), copy(m_symbols), m_respectcase, copy(m_missing), copy(m_gap), copy(m_matchchar), copy(m_sets), copy(m_partitions) },"" };
}

fn nm_own(w: const u8[:][:]) -> u8[][] { var o: u8[][>..] = []; for t in w { o.push(str(t)); } return copy(o); }
fn nm_label(w: u8[][], at: i64) -> u8[] { for t,i in w { if i == at { return copy(t); } } return ""; }
fn nm_cell(w: NexusCell[], at: i64) -> NexusCell { for t,i in w { if i == at { return copy(t); } } return NexusCell {0,""}; }

fn nm_row(w: NexusCell[][], at: i64) -> NexusCell[] { for r,i in w { if i == at { return copy(r); } } return []; }
