module Detector::Test

import List;
import Map;
import Set;
import lang::java::m3::Core;
import lang::java::m3::AST;
import IO;

map[int, str] hi;
void asdf() {
    hi = delete(hi, 1);
    hi[3] = "added";
}

void main() {
    hi = (1 : "test", 2 : "blub");
    println(hi);
    asdf();
    println(hi);
}