module Detector::StructuralAST

import Detector::SmithWaterman;

import IO;
import List;
import Map;
import Set;
import String;
import util::Math;
import lang::java::m3::Core;
import lang::java::m3::AST;

alias CloneClass = set[SerializedAST];
alias SerializedAST = tuple[Declaration ast, str serializedAST];

/**
Get ASTs for each method in a Maven Project.
*/
list[Declaration] getMethodASTsProject(loc projectLocation) {
    M3 model = createM3FromMavenProject(projectLocation);

    list[Declaration] methodASTs = [createAstFromFile(f, true)
        | f <- files(model.containment), isCompilationUnit(f)];

    // return methodASTs;
    return [ m | /Declaration m := methodASTs, m is method || m is constructor]; // Also returns methodCalls(), but I think that is ok.
}

/**
Adds metadata to AST that corresponds to the category of the node.
- c: Class
- b: Block & Statement
- e: Expression
- o: Operator
- k: Keyword
- l: Literal
*/
Declaration annotateMethodAST(Declaration method) {
    // TODO
}

SerializedAST serializeAST(Declaration methodAnnotated) {
    // TODO
}

/**
Calculates the Similarity score between two methods.
TODO: should be optimized: operands of divisor are calculated multiple times -> use dynamic programing approach
*/
real calculateSimilarity(str serializedMethod1, str serializedMethod2) {
    int divisor = smithWatermanWrapper(serializedMethod1, serializedMethod2) * smithWatermanWrapper(serializedMethod2, serializedMethod2);
    return (2.0 * smithWatermanWrapper(serializedMethod1, serializedMethod2)) / divisor;
}

/**
Wrapper method to fix the parameters in the call to Smith Waterman
*/
int smithWatermanWrapper(str a, str b) {
    int match = 2;
    int mismatch = -1;
    int gap = -1;
    return smithWaterman(a, b, match, mismatch, gap);
}

/**
Writes clone class to specified file
*/
void writeCloneClassToFile(set[SerializedAST] cloneClass, loc targetFile) {
    // TODO
}

/**
Writes clone classes to file in readable format.
*/
void printCloneClassesToFile(set[CloneClass] cloneClasses, loc outputFile) {
    // TODO: also implement the size of the class (requirement for report)
}

/**
Writes captured statistics of clone classes to file
*/
void reportResults(map[str, value] statistics, loc outputFile) {
    // TODO
}

void main(loc projectPath) {
    //// 1: Parse AST for project files through M3 model
    // Make AST for each method
    list[Declaration] methodASTs = getMethodASTsProject(projectPath);


    //// 2: Structure node categories (6 types)
    /** 
    * Based on 5 levels in AST:
    * Function, block, statement, expression and symbol
    * Block = multiple statements
    * Symbol = operators, keywords, literals
    */
    list[Declaration] annotatedASTs = [];
    for (m <- methodASTs) {
        annotatedASTs += annotateMethodAST(m);
    }

    //// 3: AST Transformations (into single characters)
    // Use visit node
    list[SerializedAST] serializedASTs = [];
    for (m <- annotatedASTs) {
        serializeASTs += serializeAST(m);
    }


    ////* Smith Waterman *////
    //// 7: Calculate Similarity Scores
    /** 
    * For each score_H(A*B):
    * Take score_H(A*A) and score_H(B*B)
    * sim = 2 * (score_H(A*B) / (score_H(A*A) + score_H(B*B))) 
    *
    * Save sim_scores in tuple[score, tuple[A,B]]   of     map[tuple[A,B], score]
    */

    // TODO: probably symmetric matrix -> no need to calculate both, lower and upper triangle
    map[tuple[SerializedAST, SerializedAST], real] similarityScore = ();
    for (m1 <- serializedASTs) {
        for (m2 <- serializedASTs) {
            real score = calculateSimilarity(m1.serializedAST, m2.serializedAST);
            similarityScore += (<m1, m2> : score);
        }
    }


    //// 8: Create clone classes
    /**
    * Loop over sim_scores and find all A's in keys
    * * If score > delta then add pair to new map clone_classes = map[ID, list[A, B, ...]]
    * * * Remove duplicate sequences from list (or use guard while adding)
    * 
    * OPTION: use tuple with [ID, list[A, B, ...], nr_of_clones_in_class]
    *
    */
    real delta = 0.9;
    loc outputFile = |path://whatever|;
    set[CloneClass] cloneClasses = {};
    for (m <- serializedASTs) {
        cloneClasses += {m | <m, other> <- similarityScore, similarityScore[<m, other>] > delta}; // TODO: not sure if that works
    }

    //// 9: Count clones
    /**
    * Loop over clone_classes and:
    * * Count nr of classes
    * * Count clones in each class (add to total_clones)
    * * Save biggest clone class (most nr of clones)
    *
    * Report results
    */
    map[str, value] statistics = ();
    statistics["numberClasses"] = size(cloneClasses);
    
    // TODO: fails to detect all classes if maximum is not unique
    int max = -1;
    CloneClass largestClass = {};
    for (c <- cloneClasses) {
        if (size(c) > max) {
            max = size(c);
            largestClass = c;
        }
    }
    statistics["largestClass"] = largestClass;
    
    loc reportFile1 = |path://whatever1|;
    loc reportFile2 = |path://whatever2|;
    printCloneClassesToFile(cloneClasses, reportFile1);
    reportResults(statistics, reportFile2);
    
}
