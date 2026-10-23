// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
import .nexus_matrix;
struct NexusTransform { matrix: NexusMatrix, taxon_map: i64[], character_map: i64[], error: u8[] }
struct NexusText { text: u8[], error: u8[] }
fn nm_remap(s: NexusSet, tm: i64[:], cm: i64[:]) -> NexusSet {
    var out: i64[>..] = []; for x in s.indices { let y = if s.taxa { tm[x] } else { cm[x] }; if y >= 0 { out.push(y); } }
    return NexusSet { copy(s.name),s.taxa,copy(out) };
}
/*
Deletes taxa/excludes characters by zero-based indices, returning original- to-output
maps (-1 removed). Repeated indices are idempotent; invalid indices or removal of all
taxa/characters fail atomically with empty maps. Remaps all sets/partition members,
retaining empty entries.
*/
fn nexus_select(m: NexusMatrix, delete_taxa: i64[:], exclude_characters: i64[:]) -> NexusTransform {
    let valid = write_nexus_matrix(copy(m)); if valid.error.len > 0 { return NexusTransform { nm_empty(),[],[],copy(valid.error) }; }
    let nc = nm_row(copy(m.rows),0).len;
    var tm: i64[>..] = []; var cm: i64[>..] = []; var tn = 0; var cn = 0;
    for x in delete_taxa { if x < 0 || x >= m.taxa.len { return NexusTransform { nm_empty(),[],[],"taxon deletion bounds" }; } }
    for x in exclude_characters { if x < 0 || x >= nc { return NexusTransform { nm_empty(),[],[],"character exclusion bounds" }; } }
    for i in m.taxa.len { var keep = true; for x in delete_taxa { if x == i { keep = false; } } tm.push(if keep { tn } else { -1 }); if keep { tn += 1; } }
    for i in nc { var keep = true; for x in exclude_characters { if x == i { keep = false; } } cm.push(if keep { cn } else { -1 }); if keep { cn += 1; } }
    if tn == 0 || cn == 0 { return NexusTransform { nm_empty(),[],[],"empty matrix result rejected" }; }
    var labels: u8[][>..] = []; for name,i in m.taxa { if tm[i] >= 0 { labels.push(copy(name)); } }
    var rows: NexusCell[][>..] = []; for row,i in m.rows { if tm[i] < 0 { continue; } var cells: NexusCell[>..] = []; for cell,j in row { if cm[j] >= 0 { cells.push(copy(cell)); } } rows.push(copy(cells)); }
    var sets: NexusSet[>..] = []; for s in m.sets { sets.push(nm_remap(copy(s),tm,cm)); }
    var parts: NexusPartition[>..] = []; for p in m.partitions { var members: NexusSet[>..] = []; for s in p.parts { members.push(nm_remap(copy(s),tm,cm)); } parts.push(NexusPartition { copy(p.name),p.taxa,copy(members) }); }
    return NexusTransform { NexusMatrix { copy(labels),copy(rows),copy(m.datatype),copy(m.symbols),m.respectcase,copy(m.missing),copy(m.gap),copy(m.matchchar),copy(sets),copy(parts) },copy(tm),copy(cm),"" };
}
fn nm_quote(s: u8[:]) -> u8[] { var out: u8[>..] = ['\'']; for b in s { out.push(b); if b == '\'' { out.push(b); } } out.push('\''); return copy(out); }
fn nm_write_indices(out: u8[>..]&, indices: i64[:]) { for x in indices { out.push(' '); out.append(str(x+1)); } }
/* Emits labeled sequential DATA and resolved SETS, quoting names and retaining settings/group kinds;
 * reparses output before success. Empty sets/members emit empty expressions.
 * Whitespace/comments/order/reference expressions/interleave layout normalize. */
/* Errors are atomic in memory. Public structs must meet parser/selection invariants. Tree codecs are
 * separate. */
fn write_nexus_matrix(m: NexusMatrix) -> NexusText {
    if m.taxa.len == 0 || m.rows.len != m.taxa.len { return NexusText { "","invalid matrix shape" }; }
    let nc = nm_row(copy(m.rows),0).len; if nc == 0 || m.taxa.len > 4096 || nc > 1000000/m.taxa.len { return NexusText { "","matrix bounds" }; }
    var out: u8[>..] = []; out.append("#NEXUS\nBEGIN DATA;\nDIMENSIONS NTAX="); out.append(str(m.taxa.len)); out.append(" NCHAR="); out.append(str(nc)); out.append(";\nFORMAT DATATYPE="); out.append(m.datatype);
    if m.respectcase { out.append(" RESPECTCASE"); } out.append(" SYMBOLS="); out.append(nm_quote(m.symbols)); out.append(" MISSING="); out.append(nm_quote(m.missing)); out.append(" GAP="); out.append(nm_quote(m.gap)); out.append(" MATCHCHAR="); out.append(nm_quote(m.matchchar)); out.append(";\nMATRIX\n");
    for row,i in m.rows { if row.len != nc { return NexusText { "","invalid row shape" }; } out.append(nm_quote(nm_label(copy(m.taxa),i))); out.push(' '); for cell in row { if cell.kind < 0 || cell.kind > 2 || cell.states.len == 0 || (cell.kind == 0 && cell.states.len != 1) { return NexusText { "","invalid cell" }; } if cell.kind == 1 { out.push('('); } if cell.kind == 2 { out.push('{'); } out.append(cell.states); if cell.kind == 1 { out.push(')'); } if cell.kind == 2 { out.push('}'); } } out.push('\n'); }
    out.append(";\nEND;\nBEGIN SETS;\n");
    for s in m.sets { out.append(if s.taxa { "TAXSET " } else { "CHARSET " }); out.append(nm_quote(s.name)); out.append(" ="); nm_write_indices(out,s.indices); out.append(";\n"); }
    for p in m.partitions { out.append(if p.taxa { "TAXPARTITION " } else { "CHARPARTITION " }); out.append(nm_quote(p.name)); out.append(" = "); for s,i in p.parts { if i > 0 { out.append(", "); } out.append(nm_quote(s.name)); out.push(':'); nm_write_indices(out,s.indices); } out.append(";\n"); }
    out.append("END;\n"); let parsed = parse_nexus_matrix(out); if parsed.error.len > 0 { return NexusText { "",copy(parsed.error) }; } return NexusText { copy(out),"" };
}
