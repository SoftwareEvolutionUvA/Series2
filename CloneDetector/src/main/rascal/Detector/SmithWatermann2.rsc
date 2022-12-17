module Detector::SmithWaterman2

import Map;
import String;
import util::Math;

int STOP = 0;
int LEFT = 1;
int UP = 2;
int DIAGONAL = 3;

int sm(str seq1, str seq2, int match, int mismatch, int gap) {
    map[tuple[int, int], int] matrix = ();
    map[tuple[int, int], int] tracingMatrix = ();

    int maxScore = -1;
    tuple[int, int] maxIndex = <-1, -1>;

    for (int i <- [1 .. size(seq1)+1]) {
        for (int j <- [1 .. size(seq2)+1]) {
            int matchValue = charAt(seq1, i-1) == charAt(seq2, j-1) ? match : mismatch;
            int diagonalScore = matrix[<i-1, j-1>] + gap;
            int vertialScore = matrix[<i-1, j>] + gap;
            int horizontalScore = matrix[<i, j-1>] + gap;

            // set highest
            matrix[<i,j>] = max(0, max(diagonalScore, max(vertialScore, max(horizontalScore))));

            // trace where the cell's value is coming from
            int elem = matrix[<i,j>];
            if (elem == 0) {
                tracingMatrix[<i,j>] = STOP;
            }
            else if (elem == horizontalScore) {
                tracingMatrix[<i,j>] = LEFT;
            }
            else if (elem == vertialScore) {
                tracingMatrix[<i,j>] = UP;
            }
            else if (elem == diagonalScore) {
                tracingMatrix[<i,j>] = DIAGONAL;
            }

            // tracking maximum score
            if (elem >= maxScore) {
                maxIndex = <i,j>;
                maxScore = matrix[<i,j>];
            }
        }
    }

    return -1;
}