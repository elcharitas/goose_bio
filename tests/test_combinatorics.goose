import bio from "..";
import bio.stats.combinatorics;
import math;
fn main() {
{
let r = bio::combinations(0,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(0,1);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,2);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,3);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,4);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,6);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,7);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,8);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,9);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(0,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(1,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(1,2);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,3);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,4);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,6);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,7);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,8);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,9);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(1,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(2,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.00000000000000000e0);
}
{
let r = bio::combinations(2,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(2,3);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,4);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,6);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,7);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,8);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,9);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(2,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(3,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.00000000000000000e0);
}
{
let r = bio::combinations(3,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.00000000000000000e0);
}
{
let r = bio::combinations(3,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(3,4);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,6);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,7);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,8);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,9);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(3,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(4,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(4,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.00000000000000000e0);
}
{
let r = bio::combinations(4,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.00000000000000000e0);
}
{
let r = bio::combinations(4,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.00000000000000000e0);
}
{
let r = bio::combinations(4,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(4,5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(4,6);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(4,7);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(4,8);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(4,9);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(4,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(4,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(4,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(4,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(4,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(5,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(5,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.00000000000000000e0);
}
{
let r = bio::combinations(5,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::combinations(5,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::combinations(5,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.00000000000000000e0);
}
{
let r = bio::combinations(5,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(5,6);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(5,7);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(5,8);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(5,9);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(5,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(5,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(5,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(5,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(5,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(6,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(6,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.00000000000000000e0);
}
{
let r = bio::combinations(6,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.50000000000000000e1);
}
{
let r = bio::combinations(6,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.00000000000000000e1);
}
{
let r = bio::combinations(6,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.50000000000000000e1);
}
{
let r = bio::combinations(6,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.00000000000000000e0);
}
{
let r = bio::combinations(6,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(6,7);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(6,8);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(6,9);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(6,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(6,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(6,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(6,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(6,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(7,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(7,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.00000000000000000e0);
}
{
let r = bio::combinations(7,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e1);
}
{
let r = bio::combinations(7,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.50000000000000000e1);
}
{
let r = bio::combinations(7,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.50000000000000000e1);
}
{
let r = bio::combinations(7,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e1);
}
{
let r = bio::combinations(7,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.00000000000000000e0);
}
{
let r = bio::combinations(7,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(7,8);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(7,9);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(7,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(7,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(7,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(7,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(7,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(8,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(8,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.00000000000000000e0);
}
{
let r = bio::combinations(8,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.80000000000000000e1);
}
{
let r = bio::combinations(8,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.60000000000000000e1);
}
{
let r = bio::combinations(8,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.00000000000000000e1);
}
{
let r = bio::combinations(8,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.60000000000000000e1);
}
{
let r = bio::combinations(8,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.80000000000000000e1);
}
{
let r = bio::combinations(8,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.00000000000000000e0);
}
{
let r = bio::combinations(8,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(8,9);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(8,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(8,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(8,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(8,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(8,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(9,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(9,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.00000000000000000e0);
}
{
let r = bio::combinations(9,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.60000000000000000e1);
}
{
let r = bio::combinations(9,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.40000000000000000e1);
}
{
let r = bio::combinations(9,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.26000000000000000e2);
}
{
let r = bio::combinations(9,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.26000000000000000e2);
}
{
let r = bio::combinations(9,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.40000000000000000e1);
}
{
let r = bio::combinations(9,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.60000000000000000e1);
}
{
let r = bio::combinations(9,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.00000000000000000e0);
}
{
let r = bio::combinations(9,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(9,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(9,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(9,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(9,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(9,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(10,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(10,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::combinations(10,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.50000000000000000e1);
}
{
let r = bio::combinations(10,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e2);
}
{
let r = bio::combinations(10,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e2);
}
{
let r = bio::combinations(10,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.52000000000000000e2);
}
{
let r = bio::combinations(10,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e2);
}
{
let r = bio::combinations(10,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e2);
}
{
let r = bio::combinations(10,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.50000000000000000e1);
}
{
let r = bio::combinations(10,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::combinations(10,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(10,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(10,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(10,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(10,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(11,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(11,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.10000000000000000e1);
}
{
let r = bio::combinations(11,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.50000000000000000e1);
}
{
let r = bio::combinations(11,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.65000000000000000e2);
}
{
let r = bio::combinations(11,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.30000000000000000e2);
}
{
let r = bio::combinations(11,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.62000000000000000e2);
}
{
let r = bio::combinations(11,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.62000000000000000e2);
}
{
let r = bio::combinations(11,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.30000000000000000e2);
}
{
let r = bio::combinations(11,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.65000000000000000e2);
}
{
let r = bio::combinations(11,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.50000000000000000e1);
}
{
let r = bio::combinations(11,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.10000000000000000e1);
}
{
let r = bio::combinations(11,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(11,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(11,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(11,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(12,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(12,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e1);
}
{
let r = bio::combinations(12,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.60000000000000000e1);
}
{
let r = bio::combinations(12,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.20000000000000000e2);
}
{
let r = bio::combinations(12,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.95000000000000000e2);
}
{
let r = bio::combinations(12,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.92000000000000000e2);
}
{
let r = bio::combinations(12,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.24000000000000000e2);
}
{
let r = bio::combinations(12,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.92000000000000000e2);
}
{
let r = bio::combinations(12,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.95000000000000000e2);
}
{
let r = bio::combinations(12,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.20000000000000000e2);
}
{
let r = bio::combinations(12,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.60000000000000000e1);
}
{
let r = bio::combinations(12,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e1);
}
{
let r = bio::combinations(12,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(12,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(12,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,1);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,2);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,3);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,4);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,6);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,7);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,8);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,9);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,10);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,11);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,12);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,13);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(0,14);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(2,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(2,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(2,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(2,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(2,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(2,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(2,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(2,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(2,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(2,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::combinations_with_repl(2,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.10000000000000000e1);
}
{
let r = bio::combinations_with_repl(2,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e1);
}
{
let r = bio::combinations_with_repl(2,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.30000000000000000e1);
}
{
let r = bio::combinations_with_repl(2,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.40000000000000000e1);
}
{
let r = bio::combinations_with_repl(2,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.50000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(3,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(3,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(3,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.50000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.80000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.60000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.50000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.50000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.60000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.80000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.10000000000000000e1);
}
{
let r = bio::combinations_with_repl(3,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.05000000000000000e2);
}
{
let r = bio::combinations_with_repl(3,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e2);
}
{
let r = bio::combinations_with_repl(4,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(4,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(4,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::combinations_with_repl(4,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.00000000000000000e1);
}
{
let r = bio::combinations_with_repl(4,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.50000000000000000e1);
}
{
let r = bio::combinations_with_repl(4,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.60000000000000000e1);
}
{
let r = bio::combinations_with_repl(4,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.40000000000000000e1);
}
{
let r = bio::combinations_with_repl(4,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e2);
}
{
let r = bio::combinations_with_repl(4,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.65000000000000000e2);
}
{
let r = bio::combinations_with_repl(4,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.20000000000000000e2);
}
{
let r = bio::combinations_with_repl(4,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.86000000000000000e2);
}
{
let r = bio::combinations_with_repl(4,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.64000000000000000e2);
}
{
let r = bio::combinations_with_repl(4,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.55000000000000000e2);
}
{
let r = bio::combinations_with_repl(4,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.60000000000000000e2);
}
{
let r = bio::combinations_with_repl(4,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.80000000000000000e2);
}
{
let r = bio::combinations_with_repl(5,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(5,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(5,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.50000000000000000e1);
}
{
let r = bio::combinations_with_repl(5,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.50000000000000000e1);
}
{
let r = bio::combinations_with_repl(5,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.00000000000000000e1);
}
{
let r = bio::combinations_with_repl(5,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.26000000000000000e2);
}
{
let r = bio::combinations_with_repl(5,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e2);
}
{
let r = bio::combinations_with_repl(5,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.30000000000000000e2);
}
{
let r = bio::combinations_with_repl(5,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.95000000000000000e2);
}
{
let r = bio::combinations_with_repl(5,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.15000000000000000e2);
}
{
let r = bio::combinations_with_repl(5,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00100000000000000e3);
}
{
let r = bio::combinations_with_repl(5,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.36500000000000000e3);
}
{
let r = bio::combinations_with_repl(5,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.82000000000000000e3);
}
{
let r = bio::combinations_with_repl(5,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.38000000000000000e3);
}
{
let r = bio::combinations_with_repl(5,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.06000000000000000e3);
}
{
let r = bio::combinations_with_repl(6,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(6,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(6,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e1);
}
{
let r = bio::combinations_with_repl(6,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.60000000000000000e1);
}
{
let r = bio::combinations_with_repl(6,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.26000000000000000e2);
}
{
let r = bio::combinations_with_repl(6,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.52000000000000000e2);
}
{
let r = bio::combinations_with_repl(6,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.62000000000000000e2);
}
{
let r = bio::combinations_with_repl(6,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.92000000000000000e2);
}
{
let r = bio::combinations_with_repl(6,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.28700000000000000e3);
}
{
let r = bio::combinations_with_repl(6,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.00200000000000000e3);
}
{
let r = bio::combinations_with_repl(6,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.00300000000000000e3);
}
{
let r = bio::combinations_with_repl(6,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.36800000000000000e3);
}
{
let r = bio::combinations_with_repl(6,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.18800000000000000e3);
}
{
let r = bio::combinations_with_repl(6,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.56800000000000000e3);
}
{
let r = bio::combinations_with_repl(6,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.16280000000000000e4);
}
{
let r = bio::combinations_with_repl(7,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(7,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(7,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.80000000000000000e1);
}
{
let r = bio::combinations_with_repl(7,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.40000000000000000e1);
}
{
let r = bio::combinations_with_repl(7,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e2);
}
{
let r = bio::combinations_with_repl(7,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.62000000000000000e2);
}
{
let r = bio::combinations_with_repl(7,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.24000000000000000e2);
}
{
let r = bio::combinations_with_repl(7,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.71600000000000000e3);
}
{
let r = bio::combinations_with_repl(7,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.00300000000000000e3);
}
{
let r = bio::combinations_with_repl(7,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.00500000000000000e3);
}
{
let r = bio::combinations_with_repl(7,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.00800000000000000e3);
}
{
let r = bio::combinations_with_repl(7,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.23760000000000000e4);
}
{
let r = bio::combinations_with_repl(7,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.85640000000000000e4);
}
{
let r = bio::combinations_with_repl(7,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.71320000000000000e4);
}
{
let r = bio::combinations_with_repl(7,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.87600000000000000e4);
}
{
let r = bio::combinations_with_repl(8,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(8,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(8,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.60000000000000000e1);
}
{
let r = bio::combinations_with_repl(8,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e2);
}
{
let r = bio::combinations_with_repl(8,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.30000000000000000e2);
}
{
let r = bio::combinations_with_repl(8,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.92000000000000000e2);
}
{
let r = bio::combinations_with_repl(8,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.71600000000000000e3);
}
{
let r = bio::combinations_with_repl(8,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.43200000000000000e3);
}
{
let r = bio::combinations_with_repl(8,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.43500000000000000e3);
}
{
let r = bio::combinations_with_repl(8,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.14400000000000000e4);
}
{
let r = bio::combinations_with_repl(8,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.94480000000000000e4);
}
{
let r = bio::combinations_with_repl(8,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.18240000000000000e4);
}
{
let r = bio::combinations_with_repl(8,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.03880000000000000e4);
}
{
let r = bio::combinations_with_repl(8,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.75200000000000000e4);
}
{
let r = bio::combinations_with_repl(8,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.16280000000000000e5);
}
{
let r = bio::combinations_with_repl(9,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(9,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(9,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.50000000000000000e1);
}
{
let r = bio::combinations_with_repl(9,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.65000000000000000e2);
}
{
let r = bio::combinations_with_repl(9,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.95000000000000000e2);
}
{
let r = bio::combinations_with_repl(9,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.28700000000000000e3);
}
{
let r = bio::combinations_with_repl(9,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.00300000000000000e3);
}
{
let r = bio::combinations_with_repl(9,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.43500000000000000e3);
}
{
let r = bio::combinations_with_repl(9,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.28700000000000000e4);
}
{
let r = bio::combinations_with_repl(9,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.43100000000000000e4);
}
{
let r = bio::combinations_with_repl(9,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.37580000000000000e4);
}
{
let r = bio::combinations_with_repl(9,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.55820000000000000e4);
}
{
let r = bio::combinations_with_repl(9,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.25970000000000000e5);
}
{
let r = bio::combinations_with_repl(9,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.03490000000000000e5);
}
{
let r = bio::combinations_with_repl(9,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.19770000000000000e5);
}
{
let r = bio::combinations_with_repl(10,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(10,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::combinations_with_repl(10,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.50000000000000000e1);
}
{
let r = bio::combinations_with_repl(10,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.20000000000000000e2);
}
{
let r = bio::combinations_with_repl(10,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.15000000000000000e2);
}
{
let r = bio::combinations_with_repl(10,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.00200000000000000e3);
}
{
let r = bio::combinations_with_repl(10,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.00500000000000000e3);
}
{
let r = bio::combinations_with_repl(10,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.14400000000000000e4);
}
{
let r = bio::combinations_with_repl(10,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.43100000000000000e4);
}
{
let r = bio::combinations_with_repl(10,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.86200000000000000e4);
}
{
let r = bio::combinations_with_repl(10,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.23780000000000000e4);
}
{
let r = bio::combinations_with_repl(10,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.67960000000000000e5);
}
{
let r = bio::combinations_with_repl(10,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.93930000000000000e5);
}
{
let r = bio::combinations_with_repl(10,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.97420000000000000e5);
}
{
let r = bio::combinations_with_repl(10,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.17190000000000000e5);
}
{
let r = bio::combinations_with_repl(11,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(11,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.10000000000000000e1);
}
{
let r = bio::combinations_with_repl(11,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.60000000000000000e1);
}
{
let r = bio::combinations_with_repl(11,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.86000000000000000e2);
}
{
let r = bio::combinations_with_repl(11,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00100000000000000e3);
}
{
let r = bio::combinations_with_repl(11,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.00300000000000000e3);
}
{
let r = bio::combinations_with_repl(11,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.00800000000000000e3);
}
{
let r = bio::combinations_with_repl(11,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.94480000000000000e4);
}
{
let r = bio::combinations_with_repl(11,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.37580000000000000e4);
}
{
let r = bio::combinations_with_repl(11,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.23780000000000000e4);
}
{
let r = bio::combinations_with_repl(11,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.84756000000000000e5);
}
{
let r = bio::combinations_with_repl(11,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.52716000000000000e5);
}
{
let r = bio::combinations_with_repl(11,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.46646000000000000e5);
}
{
let r = bio::combinations_with_repl(11,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.14406600000000000e6);
}
{
let r = bio::combinations_with_repl(11,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.96125600000000000e6);
}
{
let r = bio::combinations_with_repl(12,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(12,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e1);
}
{
let r = bio::combinations_with_repl(12,2);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.80000000000000000e1);
}
{
let r = bio::combinations_with_repl(12,3);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.64000000000000000e2);
}
{
let r = bio::combinations_with_repl(12,4);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.36500000000000000e3);
}
{
let r = bio::combinations_with_repl(12,5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.36800000000000000e3);
}
{
let r = bio::combinations_with_repl(12,6);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.23760000000000000e4);
}
{
let r = bio::combinations_with_repl(12,7);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.18240000000000000e4);
}
{
let r = bio::combinations_with_repl(12,8);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.55820000000000000e4);
}
{
let r = bio::combinations_with_repl(12,9);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.67960000000000000e5);
}
{
let r = bio::combinations_with_repl(12,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.52716000000000000e5);
}
{
let r = bio::combinations_with_repl(12,11);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.05432000000000000e5);
}
{
let r = bio::combinations_with_repl(12,12);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.35207800000000000e6);
}
{
let r = bio::combinations_with_repl(12,13);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.49614400000000000e6);
}
{
let r = bio::combinations_with_repl(12,14);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.45740000000000000e6);
}
{
let r = bio::scaled_combinations(0,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(3,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(4,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::scaled_combinations(5,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::scaled_combinations(5,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.50000000000000000e1);
}
{
let r = bio::scaled_combinations(6,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.00000000000000000e1);
}
{
let r = bio::scaled_combinations(6,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.50000000000000000e1);
}
{
let r = bio::scaled_combinations(6,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(6,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e1);
}
{
let r = bio::scaled_combinations(7,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.50000000000000000e1);
}
{
let r = bio::scaled_combinations(7,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.50000000000000000e1);
}
{
let r = bio::scaled_combinations(7,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e1);
}
{
let r = bio::scaled_combinations(7,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(7,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(8,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(8,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.00000000000000000e0);
}
{
let r = bio::scaled_combinations(8,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.80000000000000000e1);
}
{
let r = bio::scaled_combinations(8,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.60000000000000000e1);
}
{
let r = bio::scaled_combinations(8,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.00000000000000000e1);
}
{
let r = bio::scaled_combinations(8,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.60000000000000000e1);
}
{
let r = bio::scaled_combinations(8,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.80000000000000000e1);
}
{
let r = bio::scaled_combinations(8,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.00000000000000000e0);
}
{
let r = bio::scaled_combinations(8,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(8,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(8,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(8,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(8,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(8,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(8,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(9,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(9,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.00000000000000000e0);
}
{
let r = bio::scaled_combinations(9,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.60000000000000000e1);
}
{
let r = bio::scaled_combinations(9,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.40000000000000000e1);
}
{
let r = bio::scaled_combinations(9,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.26000000000000000e2);
}
{
let r = bio::scaled_combinations(9,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.26000000000000000e2);
}
{
let r = bio::scaled_combinations(9,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.40000000000000000e1);
}
{
let r = bio::scaled_combinations(9,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.60000000000000000e1);
}
{
let r = bio::scaled_combinations(9,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.00000000000000000e0);
}
{
let r = bio::scaled_combinations(9,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(9,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(9,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(9,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(9,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(9,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(10,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(10,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::scaled_combinations(10,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.50000000000000000e1);
}
{
let r = bio::scaled_combinations(10,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e2);
}
{
let r = bio::scaled_combinations(10,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e2);
}
{
let r = bio::scaled_combinations(10,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.52000000000000000e2);
}
{
let r = bio::scaled_combinations(10,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.10000000000000000e2);
}
{
let r = bio::scaled_combinations(10,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e2);
}
{
let r = bio::scaled_combinations(10,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.50000000000000000e1);
}
{
let r = bio::scaled_combinations(10,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e1);
}
{
let r = bio::scaled_combinations(10,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(10,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(10,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(10,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(10,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(11,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(11,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.10000000000000000e1);
}
{
let r = bio::scaled_combinations(11,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.50000000000000000e1);
}
{
let r = bio::scaled_combinations(11,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.65000000000000000e2);
}
{
let r = bio::scaled_combinations(11,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.30000000000000000e2);
}
{
let r = bio::scaled_combinations(11,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.62000000000000000e2);
}
{
let r = bio::scaled_combinations(11,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.62000000000000000e2);
}
{
let r = bio::scaled_combinations(11,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.30000000000000000e2);
}
{
let r = bio::scaled_combinations(11,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.65000000000000000e2);
}
{
let r = bio::scaled_combinations(11,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 5.50000000000000000e1);
}
{
let r = bio::scaled_combinations(11,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.10000000000000000e1);
}
{
let r = bio::scaled_combinations(11,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(11,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(11,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(11,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(12,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(12,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e1);
}
{
let r = bio::scaled_combinations(12,2,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.60000000000000000e1);
}
{
let r = bio::scaled_combinations(12,3,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.20000000000000000e2);
}
{
let r = bio::scaled_combinations(12,4,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.95000000000000000e2);
}
{
let r = bio::scaled_combinations(12,5,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.92000000000000000e2);
}
{
let r = bio::scaled_combinations(12,6,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.24000000000000000e2);
}
{
let r = bio::scaled_combinations(12,7,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.92000000000000000e2);
}
{
let r = bio::scaled_combinations(12,8,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.95000000000000000e2);
}
{
let r = bio::scaled_combinations(12,9,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.20000000000000000e2);
}
{
let r = bio::scaled_combinations(12,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.60000000000000000e1);
}
{
let r = bio::scaled_combinations(12,11,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.20000000000000000e1);
}
{
let r = bio::scaled_combinations(12,12,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(12,13,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(12,14,1.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::combinations(200,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.24510043090132800e16);
}
{
let r = bio::combinations(1000,500);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.70288240945436365e299);
}
{
let r = bio::combinations(1100,550);
assert(r.classification == "overflow");
assert(r.error.len > 0);
}
{
let r = bio::combinations(9007199254740991,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.00719925474099100e15);
}
{
let r = bio::combinations(0,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations(1,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(200,10);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.52161311792633200e16);
}
{
let r = bio::combinations_with_repl(1000,500);
assert(r.classification == "overflow");
assert(r.error.len > 0);
}
{
let r = bio::combinations_with_repl(1100,550);
assert(r.classification == "overflow");
assert(r.error.len > 0);
}
{
let r = bio::combinations_with_repl(9007199254740991,1);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.00719925474099100e15);
}
{
let r = bio::combinations_with_repl(0,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::combinations_with_repl(1,0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(200,10,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.24510043090132800e16);
}
{
let r = bio::scaled_combinations(1000,500,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.70288240945436365e299);
}
{
let r = bio::scaled_combinations(1100,550,1.0);
assert(r.classification == "overflow");
assert(r.error.len > 0);
}
{
let r = bio::scaled_combinations(9007199254740991,1,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.00719925474099100e15);
}
{
let r = bio::scaled_combinations(0,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1,0,1.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,0,0.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,0,-0.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == -0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(0,0,-0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -5.00000000000000000e-1);
}
{
let r = bio::scaled_combinations(0,0,1e-300);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000003e-300);
}
{
let r = bio::scaled_combinations(0,0,1e+300);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000005e300);
}
{
let r = bio::scaled_combinations(0,0,5e-324);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.94065645841246544e-324);
}
{
let r = bio::scaled_combinations(5,2,0.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,2,-0.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == -0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,2,-0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -5.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,2,1e-300);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.99999999999999992e-300);
}
{
let r = bio::scaled_combinations(5,2,1e+300);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00000000000000005e301);
}
{
let r = bio::scaled_combinations(5,2,5e-324);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.95252516672997235e-323);
}
{
let r = bio::scaled_combinations(150,80,0.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(150,80,-0.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == -0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(150,80,-0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -3.33219690817396787e43);
}
{
let r = bio::scaled_combinations(150,80,1e-300);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.66439381634793999e-257);
}
{
let r = bio::scaled_combinations(150,80,1e+300);
assert(r.classification == "overflow");
assert(r.error.len > 0);
}
{
let r = bio::scaled_combinations(150,80,5e-324);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.29264803501435268e-280);
}
{
let r = bio::scaled_combinations(1100,550,0.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1100,550,-0.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == -0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(1100,550,-0.5);
assert(r.classification == "overflow");
assert(r.error.len > 0);
}
{
let r = bio::scaled_combinations(1100,550,1e-300);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.26693313677884767e29);
}
{
let r = bio::scaled_combinations(1100,550,1e+300);
assert(r.classification == "overflow");
assert(r.error.len > 0);
}
{
let r = bio::scaled_combinations(1100,550,5e-324);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.61407677446052199e6);
}
{
let r = bio::scaled_combinations(2000,1000,0.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2000,1000,-0.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == -0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(2000,1000,-0.5);
assert(r.classification == "overflow");
assert(r.error.len > 0);
}
{
let r = bio::scaled_combinations(2000,1000,1e-300);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.04815162698948697e300);
}
{
let r = bio::scaled_combinations(2000,1000,1e+300);
assert(r.classification == "overflow");
assert(r.error.len > 0);
}
{
let r = bio::scaled_combinations(2000,1000,5e-324);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.01192085167878248e277);
}
{
let r = bio::scaled_combinations(68,53,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -8.87286814330752000e14);
}
{
let r = bio::scaled_combinations(48,37,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.12976001840000000e10);
}
{
let r = bio::scaled_combinations(92,90,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.18600000000000014e-2);
}
{
let r = bio::scaled_combinations(86,35,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.55776974510264861e23);
}
{
let r = bio::scaled_combinations(5,31,-2.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(97,53,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -1.69296808447109904e28);
}
{
let r = bio::scaled_combinations(66,40,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.65428409609979629e13);
}
{
let r = bio::scaled_combinations(89,92,-2.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(19,70,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(19,25,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(92,68,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.08353707585061120e16);
}
{
let r = bio::scaled_combinations(89,26,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -4.12921338142587523e22);
}
{
let r = bio::scaled_combinations(71,15,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 9.14734449370023918e9);
}
{
let r = bio::scaled_combinations(83,8,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -7.88864539320000000e10);
}
{
let r = bio::scaled_combinations(54,10,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.39307131699999882e5);
}
{
let r = bio::scaled_combinations(62,81,1e-05);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(20,87,-2.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(66,43,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.74262160678205568e17);
}
{
let r = bio::scaled_combinations(57,47,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.31830198799999896e5);
}
{
let r = bio::scaled_combinations(8,96,1e-05);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(47,6,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -2.14751460000000000e7);
}
{
let r = bio::scaled_combinations(49,74,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(53,30,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.11702124795880000e14);
}
{
let r = bio::scaled_combinations(73,27,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.73023559147042243e19);
}
{
let r = bio::scaled_combinations(69,46,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 6.01468487916594432e17);
}
{
let r = bio::scaled_combinations(36,8,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -6.05206800000000000e7);
}
{
let r = bio::scaled_combinations(26,95,1e-05);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(73,68,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.50203340000000026e2);
}
{
let r = bio::scaled_combinations(18,32,1e-05);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(41,44,-2.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(23,42,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(75,74,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -1.50000000000000000e2);
}
{
let r = bio::scaled_combinations(44,1,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.20000000000000000e1);
}
{
let r = bio::scaled_combinations(98,44,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.68105890176702599e27);
}
{
let r = bio::scaled_combinations(61,95,-2.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(62,81,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(95,25,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -1.11193320184234738e23);
}
{
let r = bio::scaled_combinations(35,9,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 7.06074600000000032e2);
}
{
let r = bio::scaled_combinations(93,62,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.23511472603216198e24);
}
{
let r = bio::scaled_combinations(81,72,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.60887834350000042e6);
}
{
let r = bio::scaled_combinations(89,17,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -1.51585925708343936e18);
}
{
let r = bio::scaled_combinations(64,93,1e-05);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(52,23,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.76435164978800000e14);
}
{
let r = bio::scaled_combinations(34,19,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.85596752000000051e4);
}
{
let r = bio::scaled_combinations(16,27,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(70,39,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -1.42832877569402618e20);
}
{
let r = bio::scaled_combinations(42,6,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.62289300000000000e6);
}
{
let r = bio::scaled_combinations(55,11,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.19653565849999990e6);
}
{
let r = bio::scaled_combinations(41,32,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.50343564999999990e3);
}
{
let r = bio::scaled_combinations(53,61,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(71,10,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.61738052775999997e6);
}
{
let r = bio::scaled_combinations(83,30,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.73976405513889634e22);
}
{
let r = bio::scaled_combinations(70,33,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.00226479430802400e15);
}
{
let r = bio::scaled_combinations(22,37,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(94,62,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 1.31312990154389455e20);
}
{
let r = bio::scaled_combinations(52,62,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(72,52,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.12049055023947021e12);
}
{
let r = bio::scaled_combinations(82,56,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 8.28912775449528762e20);
}
{
let r = bio::scaled_combinations(60,96,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(31,61,-2.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(26,46,1e-05);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(5,95,1e-05);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(74,66,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -3.01429493220000000e10);
}
{
let r = bio::scaled_combinations(8,42,1e-05);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(23,71,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(80,40,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -2.15014417466672370e23);
}
{
let r = bio::scaled_combinations(24,96,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(40,55,-2.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(59,75,0.5);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(68,13,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 3.13687257591679931e8);
}
{
let r = bio::scaled_combinations(3,24,1e-05);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(92,70,0.5);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 4.61916404334320681e20);
}
{
let r = bio::scaled_combinations(59,59,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -2.00000000000000000e0);
}
{
let r = bio::scaled_combinations(66,17,1e-05);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == 2.51594304930539970e10);
}
{
let r = bio::scaled_combinations(72,60,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -3.07265686029120000e13);
}
{
let r = bio::scaled_combinations(3,37,-2.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(25,1,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -5.00000000000000000e1);
}
{
let r = bio::scaled_combinations(45,96,-2.0);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
{
let r = bio::scaled_combinations(29,6,-2.0);
assert(r.error.len == 0);
assert(r.classification == "finite");
assert(r.value == -9.50040000000000233e5);
}
{
let r = bio::scaled_combinations(14,66,1e-05);
assert(r.error.len == 0);
assert(r.classification == "zero");
assert(r.value == 0.00000000000000000e0);
}
assert(bio::combinations(-1,0).error.len > 0);
assert(bio::combinations(9007199254740992,1).error.len > 0);
assert(bio::combinations(2000002,1000001).error.len > 0);
assert(bio::combinations_with_repl(9007199254740991,2).error.len > 0);
assert(bio::scaled_combinations(5,2,0.0/0.0).error.len > 0);
assert(bio::scaled_combinations(5,2,1.0/0.0).error.len > 0);
}
