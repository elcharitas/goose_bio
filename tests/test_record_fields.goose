import bio from "..";
import bio.io.record_fields;
fn main() {
    let gt: i32[6] = [2, 5, 0, 1, 4, -2147483647];
    let result = bio::genotype_strings(gt, 3);
    assert(result.error.len == 0 && result.samples.len == 3);
    for sample, i in result.samples {
        if i == 0 { assert(sample == "0|1"); }
        if i == 1 { assert(sample == ".|."); }
        if i == 2 { assert(sample == "1"); }
    }
    for allele in [-1, 0, 1, 17, 1073741822] {
        for phase in [false, true] {
            let value, ok = bio::encode_genotype(allele, phase);
            let decoded = bio::decode_genotype(value);
            assert(ok && decoded.valid && decoded.allele == allele && decoded.phased == phase);
        }
    }
    let value, ok = bio::encode_genotype(1073741823);
    assert(!ok);
    assert(!bio::decode_genotype(-2147483648).valid);
    assert(bio::genotype_strings([-2147483647, 2], 1).error.len > 0);
    assert(bio::genotype_strings([-2147483647], 1).error.len > 0);
    assert(bio::genotype_strings([2], 0).error.len > 0);
    assert(bio::genotype_strings([], 0).error.len == 0);
    let cigar = bio::parse_cigar("2H3S4M1I2D5N2=1X1P");
    assert(cigar.error.len == 0 && cigar.operations.len == 9);
    assert(bio::cigar_span(cigar.operations, true) == 14);
    assert(bio::cigar_span(cigar.operations, false) == 11);
    assert(bio::parse_cigar("*").operations.len == 0);
    assert(bio::parse_cigar("268435455M").error.len == 0);
    for text in ["", "M", "0M", "3", "2B", "-2M", "268435456M", "9999999999999999999999999M"] {
        assert(bio::parse_cigar(text).error.len > 0);
    }
    assert(bio::decode_bcf_float(2139095041).kind == 1);
    assert(bio::decode_bcf_float(2139095042).kind == 2);
    assert(bio::decode_bcf_float(2143289344).kind == 3);
    assert(bio::decode_bcf_float(-1).kind == -1);
    assert(bio::decode_bcf_float(4294967296).kind == -1);
    assert(1.0 / bio::decode_bcf_float(2147483648).value < 0.0);
    assert(bio::decode_bcf_float(0).kind == 0 && bio::decode_bcf_float(0).value == 0.0);
    assert(bio::decode_bcf_float(1).kind == 0 && bio::decode_bcf_float(1).value == 1.401298464324817e-45);
    assert(bio::decode_bcf_float(8388607).kind == 0 && bio::decode_bcf_float(8388607).value == 1.1754942106924411e-38);
    assert(bio::decode_bcf_float(8388608).kind == 0 && bio::decode_bcf_float(8388608).value == 1.1754943508222875e-38);
    assert(bio::decode_bcf_float(1065353216).kind == 0 && bio::decode_bcf_float(1065353216).value == 1.0);
    assert(bio::decode_bcf_float(3223322624).kind == 0 && bio::decode_bcf_float(3223322624).value == -2.5);
    assert(bio::decode_bcf_float(2139095039).kind == 0 && bio::decode_bcf_float(2139095039).value == 3.4028234663852886e+38);
    assert(bio::decode_bcf_float(836725847).kind == 0 && bio::decode_bcf_float(836725847).value == 6.502471006086807e-09);
    assert(bio::decode_bcf_float(3195337641).kind == 0 && bio::decode_bcf_float(3195337641).value == -0.23924125730991364);
    assert(bio::decode_bcf_float(2972172166).kind == 0 && bio::decode_bcf_float(2972172166).value == -2.4410566901167385e-09);
    assert(bio::decode_bcf_float(1514292242).kind == 0 && bio::decode_bcf_float(1514292242).value == 1.367024739549184e+16);
    assert(bio::decode_bcf_float(2057698642).kind == 0 && bio::decode_bcf_float(2057698642).value == 4.309334639986483e+35);
    assert(bio::decode_bcf_float(3045886002).kind == 0 && bio::decode_bcf_float(3045886002).value == -1.0470450888533378e-06);
    assert(bio::decode_bcf_float(798185642).kind == 0 && bio::decode_bcf_float(798185642).value == 2.6802143837656445e-10);
    assert(bio::decode_bcf_float(2855592359).kind == 0 && bio::decode_bcf_float(2855592359).value == -1.6065500438224717e-13);
    assert(bio::decode_bcf_float(590342770).kind == 0 && bio::decode_bcf_float(590342770).value == 9.536414735252371e-18);
    assert(bio::decode_bcf_float(153112611).kind == 0 && bio::decode_bcf_float(153112611).value == 1.9296979547945982e-33);
    assert(bio::decode_bcf_float(291242537).kind == 0 && bio::decode_bcf_float(291242537).value == 1.7355605564399289e-28);
    assert(bio::decode_bcf_float(1729957490).kind == 0 && bio::decode_bcf_float(1729957490).value == 7.416780067932866e+23);
    assert(bio::decode_bcf_float(1730789735).kind == 0 && bio::decode_bcf_float(1730789735).value == 8.016475791433819e+23);
    assert(bio::decode_bcf_float(925404798).kind == 0 && bio::decode_bcf_float(925404798).value == 1.0046756869996898e-05);
    assert(bio::decode_bcf_float(780411324).kind == 0 && bio::decode_bcf_float(780411324).value == 6.008657460476741e-11);
    assert(bio::decode_bcf_float(4023004873).kind == 0 && bio::decode_bcf_float(4023004873).value == -1.2514506353455407e+29);
    assert(bio::decode_bcf_float(3101860759).kind == 0 && bio::decode_bcf_float(3101860759).value == -0.00010806990758283064);
    assert(bio::decode_bcf_float(1808231019).kind == 0 && bio::decode_bcf_float(1808231019).value == 4.8215756550422255e+26);
    assert(bio::decode_bcf_float(4025154413).kind == 0 && bio::decode_bcf_float(4025154413).value == -1.454468948337293e+29);
    assert(bio::decode_bcf_float(3600864719).kind == 0 && bio::decode_bcf_float(3600864719).value == -88420080680960.0);
    assert(bio::decode_bcf_float(3227716678).kind == 0 && bio::decode_bcf_float(3227716678).value == -3.547624111175537);
    assert(bio::decode_bcf_float(2731274119).kind == 0 && bio::decode_bcf_float(2731274119).value == -5.5276869693545046e-18);
    assert(bio::decode_bcf_float(2319752433).kind == 0 && bio::decode_bcf_float(2319752433).value == -9.466574125330573e-33);
    assert(bio::decode_bcf_float(2623419287).kind == 0 && bio::decode_bcf_float(2623419287).value == -7.352031670495048e-22);
    assert(bio::decode_bcf_float(1393062885).kind == 0 && bio::decode_bcf_float(1393062885).value == 586059939840.0);
    assert(bio::decode_bcf_float(1465558034).kind == 0 && bio::decode_bcf_float(1465558034).value == 240398211481600.0);
    assert(bio::decode_bcf_float(1219045318).kind == 0 && bio::decode_bcf_float(1219045318).value == 346430.1875);
    assert(bio::decode_bcf_float(2518425264).kind == 0 && bio::decode_bcf_float(2518425264).value == -1.261126291197412e-25);
    assert(bio::decode_bcf_float(418205741).kind == 0 && bio::decode_bcf_float(418205741).value == 6.134402096760692e-24);
    assert(bio::decode_bcf_float(2837202033).kind == 0 && bio::decode_bcf_float(2837202033).value == -3.4698321825380254e-14);
    assert(bio::decode_bcf_float(3073839570).kind == 0 && bio::decode_bcf_float(3073839570).value == -1.0911799108725972e-05);
    assert(bio::decode_bcf_float(3993459448).kind == 0 && bio::decode_bcf_float(3993459448).value == -1.0472612699133663e+28);
    assert(bio::decode_bcf_float(3497116335).kind == 0 && bio::decode_bcf_float(3497116335).value == -16224271360.0);
    assert(bio::decode_bcf_float(2933352140).kind == 0 && bio::decode_bcf_float(2933352140).value == -9.795328437256501e-11);
    assert(bio::decode_bcf_float(3769360029).kind == 0 && bio::decode_bcf_float(3769360029).value == -9.907606918912803e+19);
    assert(bio::decode_bcf_float(3306407898).kind == 0 && bio::decode_bcf_float(3306407898).value == -2364.49072265625);
    assert(bio::decode_bcf_float(2427637819).kind == 0 && bio::decode_bcf_float(2427637819).value == -7.052945040074958e-29);
    assert(bio::decode_bcf_float(3924774660).kind == 0 && bio::decode_bcf_float(3924774660).value == -3.616330145337742e+25);
    assert(bio::decode_bcf_float(2921686877).kind == 0 && bio::decode_bcf_float(2921686877).value == -3.7608461483928934e-11);
    assert(bio::decode_bcf_float(2459995887).kind == 0 && bio::decode_bcf_float(2459995887).value == -1.0132655438126488e-27);
    assert(bio::decode_bcf_float(3607711196).kind == 0 && bio::decode_bcf_float(3607711196).value == -150967496474624.0);
    assert(bio::decode_bcf_float(3712841952).kind == 0 && bio::decode_bcf_float(3712841952).value == -9.253643790990705e+17);
    assert(bio::decode_bcf_float(33121031).kind == 0 && bio::decode_bcf_float(33121031).value == 9.161025144283564e-38);
    assert(bio::decode_bcf_float(1387972617).kind == 0 && bio::decode_bcf_float(1387972617).value == 401109975040.0);
    assert(bio::decode_bcf_float(1744050628).kind == 0 && bio::decode_bcf_float(1744050628).value == 2.3054654274209352e+24);
    assert(bio::decode_bcf_float(3395048569).kind == 0 && bio::decode_bcf_float(3395048569).value == -3609886.25);
    assert(bio::decode_bcf_float(1492688566).kind == 0 && bio::decode_bcf_float(1492688566).value == 2186884335796224.0);
    assert(bio::decode_bcf_float(1874242845).kind == 0 && bio::decode_bcf_float(1874242845).value == 1.1307110580581227e+29);
    assert(bio::decode_bcf_float(154750190).kind == 0 && bio::decode_bcf_float(154750190).value == 2.2304737147204124e-33);
    assert(bio::decode_bcf_float(1444753022).kind == 0 && bio::decode_bcf_float(1444753022).value == 43205751996416.0);
    assert(bio::decode_bcf_float(2293934216).kind == 0 && bio::decode_bcf_float(2293934216).value == -1.1234089308213212e-33);
    assert(bio::decode_bcf_float(3006590399).kind == 0 && bio::decode_bcf_float(3006590399).value == -4.212574467032937e-08);
    assert(bio::decode_bcf_float(39144680).kind == 0 && bio::decode_bcf_float(39144680).value == 1.5670839556654204e-37);
    assert(bio::decode_bcf_float(1863689671).kind == 0 && bio::decode_bcf_float(1863689671).value == 4.631367897454692e+28);
    assert(bio::decode_bcf_float(1052871227).kind == 0 && bio::decode_bcf_float(1052871227).value == 0.3780077397823334);
    assert(bio::decode_bcf_float(1499500425).kind == 0 && bio::decode_bcf_float(1499500425).value == 3950513334779904.0);
    assert(bio::decode_bcf_float(3066161820).kind == 0 && bio::decode_bcf_float(3066161820).value == -5.779160346719436e-06);
    assert(bio::decode_bcf_float(1454650168).kind == 0 && bio::decode_bcf_float(1454650168).value == 99066037927936.0);
    assert(bio::decode_bcf_float(723799953).kind == 0 && bio::decode_bcf_float(723799953).value == 5.8374924902585e-13);
    assert(bio::decode_bcf_float(3637675788).kind == 0 && bio::decode_bcf_float(3637675788).value == -1851819709956096.0);
    assert(bio::decode_bcf_float(2934503306).kind == 0 && bio::decode_bcf_float(2934503306).value == -1.0594110311235028e-10);
    assert(bio::decode_bcf_float(2470432821).kind == 0 && bio::decode_bcf_float(2470432821).value == -2.4210243255519905e-27);
    assert(bio::decode_bcf_float(2887300425).kind == 0 && bio::decode_bcf_float(2887300425).value == -2.1701132644352805e-12);
    assert(bio::decode_bcf_float(3095773065).kind == 0 && bio::decode_bcf_float(3095773065).value == -6.377610407071188e-05);
    print("record field assertions passed");
}
