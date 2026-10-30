import bio from "..";
import bio.io.genomic_formats;
fn main() {
    {
        let b = bio::parse_typed_bed("chr1\t91571\t91639\tn\t0\t+\t91571\t91639\t12,34,56\t3\t4,30,26,\t0,10,42,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 91571 && r.end == 91639); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 91639\nchr1\t.\tgene\t91572\t91639\t-1.25e-3\t?\t.\tID=g0;Note=a%2C0%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 91571 && r.end == 91639); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,0;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t81543\t81623\tn\t1\t+\t81543\t81623\t12,34,56\t3\t20,27,25,\t0,25,55,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 81543 && r.end == 81623); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 81623\nchr1\t.\tgene\t81544\t81623\t-1.25e-3\t?\t.\tID=g1;Note=a%2C1%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 81543 && r.end == 81623); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,1;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t53592\t53621\tn\t2\t+\t53592\t53621\t12,34,56\t3\t11,1,6,\t0,17,23,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 53592 && r.end == 53621); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 53621\nchr1\t.\tgene\t53593\t53621\t-1.25e-3\t?\t.\tID=g2;Note=a%2C2%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 53592 && r.end == 53621); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,2;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t90913\t90989\tn\t3\t+\t90913\t90989\t12,34,56\t3\t30,32,1,\t0,37,75,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 90913 && r.end == 90989); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 90989\nchr1\t.\tgene\t90914\t90989\t-1.25e-3\t?\t.\tID=g3;Note=a%2C3%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 90913 && r.end == 90989); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,3;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t9880\t9973\tn\t4\t+\t9880\t9973\t12,34,56\t3\t32,33,23,\t0,35,70,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 9880 && r.end == 9973); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 9973\nchr1\t.\tgene\t9881\t9973\t-1.25e-3\t?\t.\tID=g4;Note=a%2C4%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 9880 && r.end == 9973); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,4;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t9533\t9590\tn\t5\t+\t9533\t9590\t12,34,56\t3\t15,23,16,\t0,18,41,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 9533 && r.end == 9590); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 9590\nchr1\t.\tgene\t9534\t9590\t-1.25e-3\t?\t.\tID=g5;Note=a%2C5%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 9533 && r.end == 9590); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,5;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t71727\t71758\tn\t6\t+\t71727\t71758\t12,34,56\t3\t5,6,10,\t0,10,21,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 71727 && r.end == 71758); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 71758\nchr1\t.\tgene\t71728\t71758\t-1.25e-3\t?\t.\tID=g6;Note=a%2C6%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 71727 && r.end == 71758); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,6;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t11392\t11454\tn\t7\t+\t11392\t11454\t12,34,56\t3\t28,8,16,\t0,33,46,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 11392 && r.end == 11454); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 11454\nchr1\t.\tgene\t11393\t11454\t-1.25e-3\t?\t.\tID=g7;Note=a%2C7%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 11392 && r.end == 11454); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,7;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t51525\t51611\tn\t8\t+\t51525\t51611\t12,34,56\t3\t8,39,35,\t0,12,51,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 51525 && r.end == 51611); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 51611\nchr1\t.\tgene\t51526\t51611\t-1.25e-3\t?\t.\tID=g8;Note=a%2C8%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 51525 && r.end == 51611); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,8;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t68877\t68934\tn\t9\t+\t68877\t68934\t12,34,56\t3\t19,5,24,\t0,20,33,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 68877 && r.end == 68934); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 68934\nchr1\t.\tgene\t68878\t68934\t-1.25e-3\t?\t.\tID=g9;Note=a%2C9%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 68877 && r.end == 68934); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,9;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t99201\t99276\tn\t10\t+\t99201\t99276\t12,34,56\t3\t26,11,28,\t0,33,47,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 99201 && r.end == 99276); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 99276\nchr1\t.\tgene\t99202\t99276\t-1.25e-3\t?\t.\tID=g10;Note=a%2C10%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 99201 && r.end == 99276); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,10;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t85875\t85939\tn\t11\t+\t85875\t85939\t12,34,56\t3\t3,25,34,\t0,4,30,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 85875 && r.end == 85939); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 85939\nchr1\t.\tgene\t85876\t85939\t-1.25e-3\t?\t.\tID=g11;Note=a%2C11%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 85875 && r.end == 85939); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,11;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t62679\t62774\tn\t12\t+\t62679\t62774\t12,34,56\t3\t32,17,33,\t0,41,62,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 62679 && r.end == 62774); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 62774\nchr1\t.\tgene\t62680\t62774\t-1.25e-3\t?\t.\tID=g12;Note=a%2C12%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 62679 && r.end == 62774); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,12;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t65525\t65570\tn\t13\t+\t65525\t65570\t12,34,56\t3\t11,4,18,\t0,19,27,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 65525 && r.end == 65570); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 65570\nchr1\t.\tgene\t65526\t65570\t-1.25e-3\t?\t.\tID=g13;Note=a%2C13%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 65525 && r.end == 65570); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,13;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t36047\t36080\tn\t14\t+\t36047\t36080\t12,34,56\t3\t14,3,7,\t0,23,26,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 36047 && r.end == 36080); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 36080\nchr1\t.\tgene\t36048\t36080\t-1.25e-3\t?\t.\tID=g14;Note=a%2C14%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 36047 && r.end == 36080); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,14;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t47850\t47925\tn\t15\t+\t47850\t47925\t12,34,56\t3\t31,39,1,\t0,35,74,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 47850 && r.end == 47925); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 47925\nchr1\t.\tgene\t47851\t47925\t-1.25e-3\t?\t.\tID=g15;Note=a%2C15%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 47850 && r.end == 47925); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,15;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t98687\t98737\tn\t16\t+\t98687\t98737\t12,34,56\t3\t18,24,3,\t0,23,47,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 98687 && r.end == 98737); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 98737\nchr1\t.\tgene\t98688\t98737\t-1.25e-3\t?\t.\tID=g16;Note=a%2C16%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 98687 && r.end == 98737); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,16;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t45571\t45628\tn\t17\t+\t45571\t45628\t12,34,56\t3\t29,9,13,\t0,35,44,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 45571 && r.end == 45628); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 45628\nchr1\t.\tgene\t45572\t45628\t-1.25e-3\t?\t.\tID=g17;Note=a%2C17%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 45571 && r.end == 45628); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,17;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t17099\t17144\tn\t18\t+\t17099\t17144\t12,34,56\t3\t28,8,4,\t0,33,41,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 17099 && r.end == 17144); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 17144\nchr1\t.\tgene\t17100\t17144\t-1.25e-3\t?\t.\tID=g18;Note=a%2C18%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 17099 && r.end == 17144); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,18;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t92557\t92654\tn\t19\t+\t92557\t92654\t12,34,56\t3\t24,30,32,\t0,30,65,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 92557 && r.end == 92654); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 92654\nchr1\t.\tgene\t92558\t92654\t-1.25e-3\t?\t.\tID=g19;Note=a%2C19%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 92557 && r.end == 92654); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,19;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t29530\t29570\tn\t20\t+\t29530\t29570\t12,34,56\t3\t6,4,20,\t0,15,20,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 29530 && r.end == 29570); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 29570\nchr1\t.\tgene\t29531\t29570\t-1.25e-3\t?\t.\tID=g20;Note=a%2C20%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 29530 && r.end == 29570); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,20;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t17841\t17893\tn\t21\t+\t17841\t17893\t12,34,56\t3\t17,14,15,\t0,23,37,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 17841 && r.end == 17893); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 17893\nchr1\t.\tgene\t17842\t17893\t-1.25e-3\t?\t.\tID=g21;Note=a%2C21%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 17841 && r.end == 17893); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,21;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t60476\t60546\tn\t22\t+\t60476\t60546\t12,34,56\t3\t16,8,35,\t0,22,35,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 60476 && r.end == 60546); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 60546\nchr1\t.\tgene\t60477\t60546\t-1.25e-3\t?\t.\tID=g22;Note=a%2C22%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 60476 && r.end == 60546); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,22;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t4812\t4887\tn\t23\t+\t4812\t4887\t12,34,56\t3\t21,35,5,\t0,28,70,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 4812 && r.end == 4887); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 4887\nchr1\t.\tgene\t4813\t4887\t-1.25e-3\t?\t.\tID=g23;Note=a%2C23%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 4812 && r.end == 4887); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,23;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t92813\t92900\tn\t24\t+\t92813\t92900\t12,34,56\t3\t27,34,16,\t0,35,71,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 92813 && r.end == 92900); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 92900\nchr1\t.\tgene\t92814\t92900\t-1.25e-3\t?\t.\tID=g24;Note=a%2C24%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 92813 && r.end == 92900); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,24;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t19966\t20050\tn\t25\t+\t19966\t20050\t12,34,56\t3\t16,37,14,\t0,25,70,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 19966 && r.end == 20050); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 20050\nchr1\t.\tgene\t19967\t20050\t-1.25e-3\t?\t.\tID=g25;Note=a%2C25%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 19966 && r.end == 20050); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,25;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t45354\t45457\tn\t26\t+\t45354\t45457\t12,34,56\t3\t28,33,28,\t0,34,75,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 45354 && r.end == 45457); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 45457\nchr1\t.\tgene\t45355\t45457\t-1.25e-3\t?\t.\tID=g26;Note=a%2C26%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 45354 && r.end == 45457); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,26;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t93369\t93429\tn\t27\t+\t93369\t93429\t12,34,56\t3\t31,19,3,\t0,32,57,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 93369 && r.end == 93429); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 93429\nchr1\t.\tgene\t93370\t93429\t-1.25e-3\t?\t.\tID=g27;Note=a%2C27%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 93369 && r.end == 93429); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,27;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t2254\t2326\tn\t28\t+\t2254\t2326\t12,34,56\t3\t19,25,16,\t0,22,56,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 2254 && r.end == 2326); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 2326\nchr1\t.\tgene\t2255\t2326\t-1.25e-3\t?\t.\tID=g28;Note=a%2C28%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 2254 && r.end == 2326); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,28;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t31618\t31722\tn\t29\t+\t31618\t31722\t12,34,56\t3\t32,27,28,\t0,41,76,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 31618 && r.end == 31722); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 31722\nchr1\t.\tgene\t31619\t31722\t-1.25e-3\t?\t.\tID=g29;Note=a%2C29%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 31618 && r.end == 31722); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,29;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t82507\t82552\tn\t30\t+\t82507\t82552\t12,34,56\t3\t15,1,17,\t0,23,28,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 82507 && r.end == 82552); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 82552\nchr1\t.\tgene\t82508\t82552\t-1.25e-3\t?\t.\tID=g30;Note=a%2C30%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 82507 && r.end == 82552); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,30;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t49389\t49467\tn\t31\t+\t49389\t49467\t12,34,56\t3\t39,18,21,\t0,39,57,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 49389 && r.end == 49467); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 49467\nchr1\t.\tgene\t49390\t49467\t-1.25e-3\t?\t.\tID=g31;Note=a%2C31%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 49389 && r.end == 49467); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,31;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t4834\t4897\tn\t32\t+\t4834\t4897\t12,34,56\t3\t32,7,9,\t0,39,54,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 4834 && r.end == 4897); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 4897\nchr1\t.\tgene\t4835\t4897\t-1.25e-3\t?\t.\tID=g32;Note=a%2C32%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 4834 && r.end == 4897); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,32;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t79751\t79818\tn\t33\t+\t79751\t79818\t12,34,56\t3\t32,20,12,\t0,34,55,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 79751 && r.end == 79818); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 79818\nchr1\t.\tgene\t79752\t79818\t-1.25e-3\t?\t.\tID=g33;Note=a%2C33%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 79751 && r.end == 79818); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,33;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t37478\t37554\tn\t34\t+\t37478\t37554\t12,34,56\t3\t14,21,35,\t0,14,41,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 37478 && r.end == 37554); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 37554\nchr1\t.\tgene\t37479\t37554\t-1.25e-3\t?\t.\tID=g34;Note=a%2C34%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 37478 && r.end == 37554); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,34;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t16669\t16754\tn\t35\t+\t16669\t16754\t12,34,56\t3\t39,10,34,\t0,39,51,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 16669 && r.end == 16754); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 16754\nchr1\t.\tgene\t16670\t16754\t-1.25e-3\t?\t.\tID=g35;Note=a%2C35%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 16669 && r.end == 16754); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,35;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t18147\t18240\tn\t36\t+\t18147\t18240\t12,34,56\t3\t39,6,35,\t0,46,58,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 18147 && r.end == 18240); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 18240\nchr1\t.\tgene\t18148\t18240\t-1.25e-3\t?\t.\tID=g36;Note=a%2C36%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 18147 && r.end == 18240); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,36;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t1409\t1493\tn\t37\t+\t1409\t1493\t12,34,56\t3\t24,31,20,\t0,28,64,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 1409 && r.end == 1493); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 1493\nchr1\t.\tgene\t1410\t1493\t-1.25e-3\t?\t.\tID=g37;Note=a%2C37%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 1409 && r.end == 1493); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,37;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t1485\t1534\tn\t38\t+\t1485\t1534\t12,34,56\t3\t12,1,23,\t0,18,26,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 1485 && r.end == 1534); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 1534\nchr1\t.\tgene\t1486\t1534\t-1.25e-3\t?\t.\tID=g38;Note=a%2C38%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 1485 && r.end == 1534); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,38;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t68531\t68615\tn\t39\t+\t68531\t68615\t12,34,56\t3\t24,30,21,\t0,31,63,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 68531 && r.end == 68615); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 68615\nchr1\t.\tgene\t68532\t68615\t-1.25e-3\t?\t.\tID=g39;Note=a%2C39%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 68531 && r.end == 68615); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,39;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t92387\t92477\tn\t40\t+\t92387\t92477\t12,34,56\t3\t35,14,27,\t0,41,63,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 92387 && r.end == 92477); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 92477\nchr1\t.\tgene\t92388\t92477\t-1.25e-3\t?\t.\tID=g40;Note=a%2C40%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 92387 && r.end == 92477); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,40;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t19468\t19545\tn\t41\t+\t19468\t19545\t12,34,56\t3\t19,33,19,\t0,19,58,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 19468 && r.end == 19545); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 19545\nchr1\t.\tgene\t19469\t19545\t-1.25e-3\t?\t.\tID=g41;Note=a%2C41%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 19468 && r.end == 19545); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,41;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t16111\t16163\tn\t42\t+\t16111\t16163\t12,34,56\t3\t31,5,6,\t0,35,46,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 16111 && r.end == 16163); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 16163\nchr1\t.\tgene\t16112\t16163\t-1.25e-3\t?\t.\tID=g42;Note=a%2C42%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 16111 && r.end == 16163); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,42;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t54794\t54896\tn\t43\t+\t54794\t54896\t12,34,56\t3\t21,33,38,\t0,24,64,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 54794 && r.end == 54896); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 54896\nchr1\t.\tgene\t54795\t54896\t-1.25e-3\t?\t.\tID=g43;Note=a%2C43%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 54794 && r.end == 54896); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,43;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t34790\t34850\tn\t44\t+\t34790\t34850\t12,34,56\t3\t16,28,10,\t0,19,50,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 34790 && r.end == 34850); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 34850\nchr1\t.\tgene\t34791\t34850\t-1.25e-3\t?\t.\tID=g44;Note=a%2C44%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 34790 && r.end == 34850); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,44;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t78549\t78635\tn\t45\t+\t78549\t78635\t12,34,56\t3\t32,24,23,\t0,38,63,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 78549 && r.end == 78635); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 78635\nchr1\t.\tgene\t78550\t78635\t-1.25e-3\t?\t.\tID=g45;Note=a%2C45%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 78549 && r.end == 78635); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,45;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t4949\t4991\tn\t46\t+\t4949\t4991\t12,34,56\t3\t14,14,10,\t0,18,32,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 4949 && r.end == 4991); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 4991\nchr1\t.\tgene\t4950\t4991\t-1.25e-3\t?\t.\tID=g46;Note=a%2C46%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 4949 && r.end == 4991); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,46;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t18530\t18578\tn\t47\t+\t18530\t18578\t12,34,56\t3\t12,10,22,\t0,16,26,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 18530 && r.end == 18578); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 18578\nchr1\t.\tgene\t18531\t18578\t-1.25e-3\t?\t.\tID=g47;Note=a%2C47%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 18530 && r.end == 18578); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,47;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t60618\t60701\tn\t48\t+\t60618\t60701\t12,34,56\t3\t39,13,22,\t0,41,61,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 60618 && r.end == 60701); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 60701\nchr1\t.\tgene\t60619\t60701\t-1.25e-3\t?\t.\tID=g48;Note=a%2C48%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 60618 && r.end == 60701); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,48;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t51028\t51080\tn\t49\t+\t51028\t51080\t12,34,56\t3\t22,16,4,\t0,31,48,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 51028 && r.end == 51080); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 51080\nchr1\t.\tgene\t51029\t51080\t-1.25e-3\t?\t.\tID=g49;Note=a%2C49%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 51028 && r.end == 51080); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,49;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t50995\t51067\tn\t50\t+\t50995\t51067\t12,34,56\t3\t29,35,4,\t0,33,68,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 50995 && r.end == 51067); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 51067\nchr1\t.\tgene\t50996\t51067\t-1.25e-3\t?\t.\tID=g50;Note=a%2C50%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 50995 && r.end == 51067); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,50;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t38615\t38663\tn\t51\t+\t38615\t38663\t12,34,56\t3\t25,1,10,\t0,28,38,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 38615 && r.end == 38663); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 38663\nchr1\t.\tgene\t38616\t38663\t-1.25e-3\t?\t.\tID=g51;Note=a%2C51%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 38615 && r.end == 38663); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,51;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t67948\t68014\tn\t52\t+\t67948\t68014\t12,34,56\t3\t21,13,26,\t0,21,40,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 67948 && r.end == 68014); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 68014\nchr1\t.\tgene\t67949\t68014\t-1.25e-3\t?\t.\tID=g52;Note=a%2C52%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 67948 && r.end == 68014); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,52;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t24228\t24299\tn\t53\t+\t24228\t24299\t12,34,56\t3\t11,22,26,\t0,17,45,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 24228 && r.end == 24299); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 24299\nchr1\t.\tgene\t24229\t24299\t-1.25e-3\t?\t.\tID=g53;Note=a%2C53%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 24228 && r.end == 24299); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,53;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t98202\t98296\tn\t54\t+\t98202\t98296\t12,34,56\t3\t21,27,28,\t0,30,66,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 98202 && r.end == 98296); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 98296\nchr1\t.\tgene\t98203\t98296\t-1.25e-3\t?\t.\tID=g54;Note=a%2C54%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 98202 && r.end == 98296); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,54;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t73126\t73154\tn\t55\t+\t73126\t73154\t12,34,56\t3\t2,9,7,\t0,3,21,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 73126 && r.end == 73154); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 73154\nchr1\t.\tgene\t73127\t73154\t-1.25e-3\t?\t.\tID=g55;Note=a%2C55%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 73126 && r.end == 73154); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,55;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t16533\t16638\tn\t56\t+\t16533\t16638\t12,34,56\t3\t30,37,37,\t0,31,68,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 16533 && r.end == 16638); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 16638\nchr1\t.\tgene\t16534\t16638\t-1.25e-3\t?\t.\tID=g56;Note=a%2C56%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 16533 && r.end == 16638); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,56;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t52654\t52738\tn\t57\t+\t52654\t52738\t12,34,56\t3\t29,20,22,\t0,38,62,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 52654 && r.end == 52738); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 52738\nchr1\t.\tgene\t52655\t52738\t-1.25e-3\t?\t.\tID=g57;Note=a%2C57%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 52654 && r.end == 52738); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,57;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t66668\t66737\tn\t58\t+\t66668\t66737\t12,34,56\t3\t38,2,18,\t0,43,51,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 66668 && r.end == 66737); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 66737\nchr1\t.\tgene\t66669\t66737\t-1.25e-3\t?\t.\tID=g58;Note=a%2C58%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 66668 && r.end == 66737); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,58;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    {
        let b = bio::parse_typed_bed("chr1\t62031\t62106\tn\t59\t+\t62031\t62106\t12,34,56\t3\t19,14,30,\t0,28,45,\tcustom");
        assert(b.error.len == 0);
        for r in b.records { assert(r.start == 62031 && r.end == 62106); assert(r.block_sizes.len == 3); }
        let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
        assert(bio::write_typed_bed(bio::parse_typed_bed(w.text).records).text == w.text);
        let g = bio::parse_gff3("##gff-version 3\n##sequence-region chr1 1 62106\nchr1\t.\tgene\t62032\t62106\t-1.25e-3\t?\t.\tID=g59;Note=a%2C59%3B%3D%20%25%09");
        assert(g.error.len == 0);
        for r in g.features { assert(r.start == 62031 && r.end == 62106); assert(r.score_known && r.score == -0.00125); for v in bio::gff3_values(copy(r),"Note") { assert(v == "a,59;= %\t"); } }
        let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
        assert(bio::write_gff3(bio::parse_gff3(gw.text)).text == gw.text);
    }
    print("60 independent genomic model cases passed");
}
