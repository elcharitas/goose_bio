// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import std;
import bio from "..";
import bio.io.nexus_matrix;
import bio.io.nexus_matrix_workflow;
fn wrap(body: u8[:], format: u8[:], sets: u8[:]) -> u8[] { var s: u8[>..] = []; s.append("#NEXUS\nBEGIN DATA; DIMENSIONS NTAX=2 NCHAR=4; FORMAT "); s.append(format); s.append("; MATRIX\n"); s.append(body); s.append("\n; END; BEGIN SETS;"); s.append(sets); s.append(" END;"); return copy(s); }
fn main() {
    let r = bio::parse_nexus_matrix(wrap("a ACGT\nb .C.T","DATATYPE=DNA MATCHCHAR=.","CHARSET odd=1-4\\2;")); assert(r.error.len == 0);
    for s in r.matrix.sets { assert(s.indices == [0,2]); }
    let t = bio::nexus_select(copy(r.matrix),[0],[0,2]); assert(t.error.len == 0); assert(t.taxon_map == [-1,0] && t.character_map == [-1,0,-1,1]);
    let text = bio::write_nexus_matrix(copy(t.matrix)); assert(text.error.len == 0); assert(bio::parse_nexus_matrix(text.text).error.len == 0);
    assert(bio::nexus_select(copy(r.matrix),[0,1],[]).error.len > 0); assert(bio::nexus_select(copy(r.matrix),[],[0,1,2,3]).error.len > 0);
    assert(bio::nexus_select(copy(r.matrix),[-1],[]).error.len > 0);
    let standard = bio::parse_nexus_matrix(wrap("'a''one' 0(01){01}1\n\"b\" 0..0","DATATYPE=STANDARD SYMBOLS=\"01\" RESPECTCASE","CHARSET last=other; CHARSET other=4; TAXSET first='a''one'; CHARPARTITION p=empty:,rest:last; TAXPARTITION tp=all:1-2;"));
    assert(standard.error.len == 0); assert(standard.matrix.respectcase);
    for row in standard.matrix.rows { assert(row.len == 4); for c,i in row { assert(c.kind == (if i == 1 { 1 } else if i == 2 { 2 } else { 0 })); } }
    let out = bio::write_nexus_matrix(copy(standard.matrix)); assert(out.error.len == 0);
    assert(bio::parse_nexus_matrix(wrap("a AC\nGT\nb GT\nAC","DATATYPE=DNA","")).error.len == 0);
    let inter = bio::parse_nexus_matrix(wrap("a AC\nb GT\n\na GT\nb AC","DATATYPE=DNA INTERLEAVE=YES","")); assert(inter.error.len == 0);
    for datatype in ["RNA","NUCLEOTIDE","PROTEIN"] { var fmt: u8[>..] = []; fmt.append("DATATYPE="); fmt.append(datatype); assert(bio::parse_nexus_matrix(wrap("a ACGN\nb ACGN",fmt,"")).error.len == 0); }
    for body in ["a ACGT\na ACGT","a ACG\nb ACGT","a ACGTT\nb ACGT","a .CGT\nb ACGT","a ACZT\nb ACGT","a ACGT\nb (AC)GT","'a ACGT\nb ACGT","a ACGT\nb ACGT [oops","a ACGT\nb ACGT ]","a AC\nb GT\nb AC\na GT"] {
        let bad = bio::parse_nexus_matrix(wrap(body,"DATATYPE=DNA", "")); assert(bad.error.len > 0 && bad.matrix.rows.len == 0);
    }
    for sets in ["CHARSET x=0;","CHARSET x=1-5;","CHARSET x=1-4\\0;","CHARSET x=y; CHARSET y=x;","CHARSET x=unknown;","CHARSET x=4-1;","CHARPARTITION x=a:unknown;","TAXSET x=3;","CHARSET x=1; CHARSET x=2;"] { assert(bio::parse_nexus_matrix(wrap("a ACGT\nb ACGT","DATATYPE=DNA",sets)).error.len > 0); }
    for fmt in ["DATATYPE=CONTINUOUS","DATATYPE=MIXED","DATATYPE=DNA TOKENS","DATATYPE=DNA TRANSPOSE","DATATYPE=DNA EQUATE='X=A'","DATATYPE=STANDARD SYMBOLS='00'","DATATYPE=DNA MISSING=A"] { assert(bio::parse_nexus_matrix(wrap("a ACGT\nb ACGT",fmt,"")).error.len > 0); }
    for body in ["a 0(01}01\nb 0000","a 0{01)01\nb 0000","a 0()01\nb 0000","a 0((01))1\nb 0000","a 0{02}01\nb 0000"] { assert(bio::parse_nexus_matrix(wrap(body,"DATATYPE=STANDARD","")).error.len > 0); }
    for section in ["TREES","ASSUMPTIONS","CODONS"] { var raw: u8[>..] = []; raw.append(text.text); raw.append("BEGIN "); raw.append(section); raw.append("; END;"); assert(bio::parse_nexus_matrix(raw).error.len > 0); }
    var deep: u8[>..] = []; deep.append("#NEXUS"); for i in 65 { deep.push('['); } for i in 65 { deep.push(']'); } assert(bio::parse_nexus_matrix(deep).error.len > 0);
    assert(bio::parse_nexus_matrix("#NEXUS BEGIN DATA; DIMENSIONS NTAX=1000001 NCHAR=1; END;").error.len > 0);
    let taxa = bio::parse_nexus_matrix("#NEXUS [one [two]]\nBEGIN TAXA; DIMENSIONS NTAX=2; TAXLABELS 'a one' b; END; BEGIN CHARACTERS; DIMENSIONS NCHAR=2; FORMAT DATATYPE=DNA; MATRIX\n'a one' AC\nb GT\n; END;"); assert(taxa.error.len == 0);
    for command in ["NTAX", "NTAX=", "NTAX=2 NCHAR", "NTAX=2 NCHAR="] {
        var raw: u8[>..] = []; raw.append("#NEXUS BEGIN DATA; DIMENSIONS "); raw.append(command); raw.append("; END;");
        let bad=bio::parse_nexus_matrix(raw); assert(bad.error.len > 0 && bad.matrix.rows.len == 0 && bad.matrix.taxa.len == 0);
    }
    for fmt in ["DATATYPE", "DATATYPE=", "INTERLEAVE=", "SYMBOLS=", "'DATATYPE'=DNA", "DATATYPE '=' DNA"] {
        let bad=bio::parse_nexus_matrix(wrap("a ACGT\nb ACGT",fmt,"")); assert(bad.error.len > 0 && bad.matrix.rows.len == 0);
    }
    for sets in ["TAXSET", "TAXSET x", "TAXSET x '=' a;", "TAXPARTITION p=a;", "TAXPARTITION p=a ':' b;", "CHARSET x=1-;", "CHARSET x=1\\;", "CHARSET x='-';", "CHARSET x=1 '-' 2;"] {
        let bad=bio::parse_nexus_matrix(wrap("a ACGT\nb ACGT","DATATYPE=DNA",sets)); assert(bad.error.len > 0 && bad.matrix.rows.len == 0);
    }
    for raw in ["#NEXUS 'BEGIN' DATA; END;", "#NEXUS BEGIN 'DATA'; END;", "'#NEXUS' BEGIN DATA; END;"] { assert(bio::parse_nexus_matrix(raw).error.len > 0); }
    let numeric=bio::parse_nexus_matrix(wrap("'2' ACGT\nb ACGT","DATATYPE=DNA","TAXSET literal='2'; TAXSET positional=2;"));
    assert(numeric.error.len == 0); for ss in numeric.matrix.sets { assert(ss.indices == (if ss.name == "literal" { [0] } else { [1] })); }
    let named=bio::parse_nexus_matrix(wrap("';' ACGT\n',' ACGT","DATATYPE='DNA' MISSING='?' GAP='-' MATCHCHAR='.'","CHARSET ','=1; CHARSET use=','; TAXSET ';'=';'; TAXSET alias=';'; TAXPARTITION '='=',' : ',', ';' : ';';"));
    assert(named.error.len == 0); for ss in named.matrix.sets { assert(ss.indices == [0]); }
    assert(bio::write_nexus_matrix(copy(named.matrix)).error.len == 0);

}
