import bio from "..";
import bio.io.affy_cel;
fn main() {
    let input = "[CEL]\nVersion=3\n[HEADER]\nRows=1\nCols=2\n[INTENSITY]\nNumberCells=2\nCellHeader=X Y MEAN STDV NPIXELS\n1 0 21.5 2.5 9\n0 0 10 1 8\n";
    let parsed = bio::parse_affy_cel(input);
    assert(parsed.error.len == 0);
    let y = 0; let x = 1;
    assert(parsed.record.intensities[y*parsed.record.ncols+x] == 21.5);
}
