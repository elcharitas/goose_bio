import bio from "..";
import bio.analysis.graphics;
fn main() {
    var p = bio::GraphicPage {10,110,600,240,1,false,false};
    let f = bio::GraphicFeature {[bio::GraphicPart {20,40}],1,"#aB0012","<&\"'>","BOX",true};
    let tracks = [bio::GraphicTrack {[copy(f)]}, bio::GraphicTrack {[]}];
    let a = bio::genome_diagram_svg(p,tracks);
    assert(a.error.len == 0 && a.svg.len > 0);
    assert(a.svg == bio::genome_diagram_svg(p,tracks).svg);
    assert(bio::graphic_escape(f.label) == "&lt;&amp;&quot;&apos;&gt;");
    for color in ["red","#fff","#12345g","#000000\" onload=\"x","url(x)",""] {
        let bad = bio::GraphicFeature {copy(f.parts),1,color,copy(f.label),"BOX",true};
        let invalid = [bio::GraphicTrack {[copy(bad)]}];
        assert(bio::genome_diagram_svg(p,invalid).error.len > 0);
    }
    for label in ["line\n", "nul\0", "\x01"] {
        let bad = bio::GraphicFeature {copy(f.parts),1,copy(f.color),label,"BOX",true};
        let invalid = [bio::GraphicTrack {[copy(bad)]}];
        assert(bio::genome_diagram_svg(p,invalid).error.len > 0);
    }
    let bad_features = [
        bio::GraphicFeature {copy(f.parts),1,copy(f.color),copy(f.label),"BOX",false},
        bio::GraphicFeature {copy(f.parts),1,copy(f.color),copy(f.label),"ARROW",true},
        bio::GraphicFeature {[],1,copy(f.color),copy(f.label),"BOX",true},
        bio::GraphicFeature {[bio::GraphicPart {40,20}],1,copy(f.color),copy(f.label),"BOX",true},
        bio::GraphicFeature {copy(f.parts),2,copy(f.color),copy(f.label),"BOX",true}
    ];
    for bad in bad_features {
        let invalid = [bio::GraphicTrack {[copy(bad)]}];
        assert(bio::genome_diagram_svg(p,invalid).error.len > 0);
    }
    let none: bio::GraphicTrack[] = [];
    assert(bio::genome_diagram_svg(p,none).error.len > 0);
    p.circular = true; assert(bio::genome_diagram_svg(p,tracks).error.len > 0);
    p.circular = false; p.cross_links = true;
    assert(bio::genome_diagram_svg(p,tracks).error.len > 0);
    p.cross_links = false; p.fragments = 2;
    assert(bio::genome_diagram_svg(p,tracks).error.len > 0);
    p.fragments = 1; p.end = 10;
    assert(bio::genome_diagram_svg(p,tracks).error.len > 0);
    p.end = 110; p.width = 0;
    assert(bio::genome_diagram_svg(p,tracks).error.len > 0);
    print("graphics validation passed");
}
