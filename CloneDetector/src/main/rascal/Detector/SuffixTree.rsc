module Detector::SuffixTree

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


/** AST Suffix Tree
- Statements will be the suffixes
- Thus, nodes are tokens
*/

////  1: Parse AST for project files through M3 model

// Function that returns the list of ASTs of each method in a given project
list[Declaration] getMethodASTsProject(loc projectLocation) {
    M3 model = createM3FromMavenProject(projectLocation);

    list[Declaration] methodASTs = [createAstFromFile(f, true)
        | f <- files(model.containment), isCompilationUnit(f)];

    // return methodASTs;
    return [ m | /Declaration m := methodASTs, m is method || m is constructor]; // Also returns methodCalls(), but I think that is ok.
}

// Function that obtains the AST-nodes to be compared
list[node] getNodes(Declaration AST) {
    list[node] subtrees = [];

    AST = unsetRec(AST);
    visit (AST) {
        case node st : subtrees += st;
    }

    return subtrees;
}


// Function to obtain a single node of a project (for research purposes)
list[node] getSingle(loc projectLocation) {
    list[Declaration] allX = getMethodASTsProject(projectLocation);
    return getNodes(allX[1]);
}


// Serialize AST-nodes:
/** Preorder traversal: for each AST node N
- we emit N as root, and 
- associate the number of arguments of N (= transitive nodes with root N)
*/

// list[Statement] getSubtrees(list[Declaration] ASTs) {
//     list[Statement] suffixes = [];

//     for (ast <- ASTs) {
//         visit (ast) {
//             case \for(_,_,_,_) one : suffixes += x;
//             case \for(_,_,_) two : suffixes += x;
//         }
//     }

//     return suffixes;
// }


// Token-based clone detection
/** 
- returns equivalence classes of type-1 and type-2 clones: 

getSingle(|project://TestCode|);
- produced a set of clone classes of maximally long equivalent AST node sequences.
*/