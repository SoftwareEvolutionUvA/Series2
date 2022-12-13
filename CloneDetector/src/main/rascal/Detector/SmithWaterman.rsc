module Detector::SmithWaterman

import String;
import List;
import Set;

int smithWaterman(str a, str b, int match, int mismatch, int gap) {
    list[list[int]] s = calculateSubstitutionMatrix(a, b, match, mismatch);    
    map[tuple[int, int], int] H = calculateScoringMatrix(s, a, b, gap);
    tuple[int, int] lastIdx = <size(a)-1, size(b)-1>;

    return lastIdx in H ? H[lastIdx] : 0;
}

list[list[int]] calculateSubstitutionMatrix(str a, str b, int match, int mismatch) {
    list[list[int]] s = [];

    for (int i <- [0 .. size(a)]) { // row
        list[int] row = [];
        for (int j <- [0 .. size(b)]) { // col
            int entryValue = charAt(a, i) == charAt(b, j) ? match : mismatch;
            row = concat([row, [entryValue]]);
        }
        s = concat([s, row]);
    }
    
    return s;
}

map[tuple[int, int], int] calculateScoringMatrix(list[list[int]] s, str a, str b, int gap) {
    map[tuple[int, int], int] H = ();
    for (int i <- [1 .. size(a)]) {
        for (int j <- [1 .. size(b)]) {
            int first = (<i-1, j-1> in H ? H[<i-1, j-1>] : 0) + elementAt(elementAt(s, i), j);
            int second = (<i-1, j-1> in H ? H[<i-1, j>] : 0) + gap;
            int third = (<i-1, j-1> in H ? H[<i, j-1>] : 0) + gap;
            H += (<i, j>: max({0, first, second, third}));
        }
    }
    return H;
}