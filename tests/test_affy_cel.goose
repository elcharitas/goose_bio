// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.io.affy_cel;
fn main() {
    let text = "[CEL]\nVersion=3\n[HEADER]\nRows=1\nCols=1\n[INTENSITY]\nNumberCells=1\nCellHeader=X Y MEAN STDV NPIXELS\n0 0 -2.5 0 -1\n";
    let good = bio::parse_affy_cel(text); assert(good.error.len == 0);
    assert(good.record.intensities[0] == -2.5 && good.record.pixels[0] == -1);
    assert(good.record.mask.len == 0);
    for suffix in ["[MASKS]\nNumberCells=0\nCellHeader=X Y\n", "[MODIFIED]\nNumberCells=0\nCellHeader=X Y ORIGMEAN\n"] {
        var input: u8[>..] = []; input.append(text); input.append(suffix);
        let parsed = bio::parse_affy_cel(input); assert(parsed.error.len == 0);
        assert(parsed.record.mask.len == 1 || parsed.record.modified.len == 1);
    }
    for value in ["nan","inf","1e309","1e","--1","1x",".","0x10"] { let v,ok = bio::cel_decimal(value); assert(!ok); }
    for value in ["0","-0.0",".5","1.","1e-300","+1E2"] { let v,ok = bio::cel_decimal(value); assert(ok); }
    for bad in ["", "[CEL]\nVersion=3", "[CEL]\nVersion=3\n[HEADER]\nRows=1000000\nCols=1000000\n[INTENSITY]\n", "[CEL]\n[HEADER]\nRows=1\nCols=1\n[INTENSITY]\n"] {
        let result = bio::parse_affy_cel(bad); assert(result.error.len > 0 && result.record.intensities.len == 0);
    }
    let corner = bio::cel_corner(copy(good.record),"GridCornerUL"); assert(!corner.present);
}
