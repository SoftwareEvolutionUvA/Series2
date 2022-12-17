module Detector::SmithWaterman

import String;
import List;
import Set;

import IO; // DEBUG
import Type; // DEBUG

int smithWaterman(str a, str b, int match, int mismatch, int gap) {
    map[tuple[int, int], int] s = calculateSubstitutionMatrix(a, b, match, mismatch);    
    map[tuple[int, int], int] H = calculateScoringMatrix(s, a, b, gap);
    tuple[int, int] lastIdx = <size(a)-1, size(b)-1>;

    return lastIdx in H ? H[lastIdx] : 0;
}

private map[tuple[int, int], int] calculateSubstitutionMatrix(str a, str b, int match, int mismatch) {
    map[tuple[int, int], int] s = ();

    for (int i <- [0 .. size(a)]) { // row
        for (int j <- [0 .. size(b)]) { // col
            int entryValue = charAt(a, i) == charAt(b, j) ? match : mismatch;
            s[<i,j>] = entryValue;
        }
    }
    
    return s;
}

private map[tuple[int, int], int] calculateScoringMatrix(map[tuple[int, int], int] s, str a, str b, int gap) {
    map[tuple[int, int], int] H = ();
    for (int i <- [1 .. size(a)]) {
        for (int j <- [1 .. size(b)]) {
            int first = (<i-1, j-1> in H ? H[<i-1, j-1>] : 0) + s[<i,j>];
            int second = (<i-1, j-1> in H ? H[<i-1, j>] : 0) + gap;
            int third = (<i-1, j-1> in H ? H[<i, j-1>] : 0) + gap;
            H += (<i, j>: max({0, first, second, third}));
        }
    }
    return H;
}