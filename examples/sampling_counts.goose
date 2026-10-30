import bio from "..";

fn main() {
    let distinct = bio::combinations(10, 4);
    assert(distinct.error.len == 0 && distinct.value == 210.0);
    print("four distinct markers from ten: ", distinct.value);
    let repeated = bio::combinations_with_repl(4, 3);
    assert(repeated.error.len == 0 && repeated.value == 20.0);
    print("three selections from four types with repetition: ", repeated.value);
    let scaled = bio::scaled_combinations(10, 4, 0.5);
    assert(scaled.error.len == 0 && scaled.value == 105.0);
    print("scaled count: ", scaled.value);
}
