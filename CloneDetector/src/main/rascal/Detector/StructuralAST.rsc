module Detector::StructureAST

import Node;
import IO;
import List;
import Map;
import Set;
import String;
import util::Math;
import lang::java::m3::Core;
import lang::java::m3::AST;
import Exception;




//// 1: Parse AST for project files through M3 model
// Make AST for each method


//// 2: Structure node categories (6 types)
/** 
* Based on 5 levels in AST:
* Function, block, statement, expression and symbol
* Block = multiple statements
* Symbol = operators, keywords, literals
*/



//// 3: AST Transformations (into single characters)
// Use visit node


////* Smith Waterman *////

//// 4: Set parameters
/**
* Match = 2
* Mismatch = -1
* Gap = -1
* Delta = 0.9 
*/



//// 5: Create score-matrix H
/** 
* Matrix H for each pair A*B
*
* Take length node (sequence A and B) as size H = (n + 1) x (m + 1)
* Initialize H(0,-) and H(-,0) with 0's
* Initialize H(1,1) = A[1]*B[1] etc.
* 
* Now, iteratively calculate scores for: i > 1, j > 1
* H(i,j) = match/mismatch for A[i]-B[j] where: 
* Take max of...
*
* * H (i-1, j) + A[i]*B[j]
* * H (i-1, j) + gap
* * H (i, j-1) + gap
* * 0
*
* Use ... for the H.
*/

//// 6: Take the score from each H(A*B) 
// From H((n + 1), (m + 1))


//// 7: Calculate Similarity Scores
/** 
* For each score_H(A*B):
* Take score_H(A*A) and score_H(B*B)
* sim = 2 * (score_H(A*B) / (score_H(A*A) + score_H(B*B))) 
*
* Save sim_scores in tuple[score, tuple[A,B]]   of     map[tuple[A,B], score]
*/


//// 8: Create clone classes
/**
* Loop over sim_scores and find all A's in keys
* * If score > delta then add pair to new map clone_classes = map[ID, list[A, B, ...]]
* * * Remove duplicate sequences from list (or use guard while adding)
* 
* OPTION: use tuple with [ID, list[A, B, ...], nr_of_clones_in_class]
*
*/

//// 9: Count clones
/**
* Loop over clone_classes and:
* * Count nr of classes
* * Count clones in each class (add to total_clones)
* * Save biggest clone class (most nr of clones)
*
* Report results
*/


