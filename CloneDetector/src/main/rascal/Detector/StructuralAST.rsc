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
import Node;
import Type;

alias CloneClass = set[SerializedAST];
alias SerializedAST = tuple[Declaration ast, map[node, str] labels, str serializedAST];

str CLASS_CONSTANT = "c";
str BLOCK_STATEMENT_CONSTANT = "b";
str EXPRESSION_CONSTANT = "e";
str OPERATOR_CONSTANT = "o";
str KEYWORD_CONSTANT = "k";
str LITERAL_CONSTANT = "l";
str KEY_CATEGORY = "categoryCloneDetection";

// Test area cats
str DECLARATION_CONSTANT = "d";
// expression exists
str STATEMENT_CONSTANT = "s";
str TYPE_CONSTANT = "t";
str MODIFIER_CONSTANT = "m";


// End area

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
!!! there are CONSTANTS defined at the beginning of this file !!!
- c: Class
- b: Block & Statement
- e: Expression
- o: Operator
- k: Keyword
- l: Literal
*/
SerializedAST annotateMethodAST(Declaration method) {
    // TODO

    // start from lowest level and work up

    map[node, str] labels = ();
    visit (method) {
        // Modifier
        case node n: \private() : labels += (n : MODIFIER_CONSTANT);
        case node n: \public() : labels += (n : MODIFIER_CONSTANT);
        case node n: \protected() : labels += (n : MODIFIER_CONSTANT);
        case node n: \friendly() : labels += (n : MODIFIER_CONSTANT);
        case node n: \static() : labels += (n : MODIFIER_CONSTANT);
        case node n: \final() : labels += (n : MODIFIER_CONSTANT);
        case node n: \synchronized() : labels += (n : MODIFIER_CONSTANT);
        case node n: \transient() : labels += (n : MODIFIER_CONSTANT);
        case node n: \abstract() : labels += (n : MODIFIER_CONSTANT);
        case node n: \native() : labels += (n : MODIFIER_CONSTANT);
        case node n: \volatile() : labels += (n : MODIFIER_CONSTANT);
        case node n: \strictfp() : labels += (n : MODIFIER_CONSTANT);
        case node n: \annotation(_) : labels += (n : MODIFIER_CONSTANT);
        case node n: \onDemand() : labels += (n : MODIFIER_CONSTANT);
        case node n: \default() : labels += (n : MODIFIER_CONSTANT);

        // Type
        case node n: arrayType(_): labels += (n : TYPE_CONSTANT);
        case node n: parameterizedType(_): labels += (n : TYPE_CONSTANT);
        case node n: qualifiedType(_, _): labels += (n : TYPE_CONSTANT);
        case node n: simpleType(_): labels += (n : TYPE_CONSTANT);
        case node n: unionType(_): labels += (n : TYPE_CONSTANT);
        case node n: wildcard(): labels += (n : TYPE_CONSTANT);
        case node n: upperbound(_): labels += (n : TYPE_CONSTANT);
        case node n: lowerbound(_): labels += (n : TYPE_CONSTANT);
        case node n: \int(): labels += (n : TYPE_CONSTANT);
        case node n: short(): labels += (n : TYPE_CONSTANT);
        case node n: long(): labels += (n : TYPE_CONSTANT);
        case node n: float(): labels += (n : TYPE_CONSTANT);
        case node n: double(): labels += (n : TYPE_CONSTANT);
        case node n: char(): labels += (n : TYPE_CONSTANT);
        case node n: string(): labels += (n : TYPE_CONSTANT);
        case node n: byte(): labels += (n : TYPE_CONSTANT);
        case node n: \void(): labels += (n : TYPE_CONSTANT);
        case node n: \boolean(): labels += (n : TYPE_CONSTANT);

        // Statement
        case node n: \assert(_) : labels += (n : STATEMENT_CONSTANT);
        case node n: \assert(_, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \block(_) : labels += (n : STATEMENT_CONSTANT);
        case node n: \break() : labels += (n : STATEMENT_CONSTANT);
        case node n: \break(_) : labels += (n : STATEMENT_CONSTANT);
        case node n: \continue() : labels += (n : STATEMENT_CONSTANT);
        case node n: \continue(_) : labels += (n : STATEMENT_CONSTANT);
        case node n: \do(_, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \empty() : labels += (n : STATEMENT_CONSTANT);
        case node n: \foreach(_, _, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \for(_, _, _, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \for(_, _, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \if(_, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \if(_, _, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \label(_, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \return(_) : labels += (n : STATEMENT_CONSTANT);
        case node n: \return() : labels += (n : STATEMENT_CONSTANT);
        case node n: \switch(_, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \case(_) : labels += (n : STATEMENT_CONSTANT);
        case node n: \defaultCase() : labels += (n : STATEMENT_CONSTANT);
        case node n: \synchronizedStatement(_, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \throw(_) : labels += (n : STATEMENT_CONSTANT);
        case node n: \try(_, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \try(_, _, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \catch(_, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \declarationStatement(_) : labels += (n : STATEMENT_CONSTANT);
        case node n: \while(_, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \expressionStatement(_) : labels += (n : STATEMENT_CONSTANT);
        case node n: \constructorCall(_, _) : labels += (n : STATEMENT_CONSTANT);
        case node n: \constructorCall(_, _, _) : labels += (n : STATEMENT_CONSTANT);

        // Expression
        case node n: \arrayAccess(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \newArray(_, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \newArray(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \arrayInitializer(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \assignment(_, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \cast(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \characterLiteral(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \newObject(_, _, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \newObject(_, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \newObject(_, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \newObject(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \qualifiedName(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \conditional(_, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \fieldAccess(_, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \fieldAccess(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \instanceof(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \methodCall(_, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \methodCall(_, _, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \null(): labels += (n : EXPRESSION_CONSTANT);
        case node n: \number(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \booleanLiteral(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \stringLiteral(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \type(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \variable(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \variable(_, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \bracket(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \this(): labels += (n : EXPRESSION_CONSTANT);
        case node n: \this(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \super(): labels += (n : EXPRESSION_CONSTANT);
        case node n: \declarationExpression(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \infix(_, _, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \postfix(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \prefix(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \simpleName(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \markerAnnotation(_): labels += (n : EXPRESSION_CONSTANT);
        case node n: \normalAnnotation(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \memberValuePair(_, _): labels += (n : EXPRESSION_CONSTANT);
        case node n: \singleMemberAnnotation(_, _): labels += (n : EXPRESSION_CONSTANT);

        // Declaration
        case node n: \compilationUnit(_, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \compilationUnit(_, _, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \enum(_, _, _, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \enumConstant(_, _, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \enumConstant(_, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \class(_, _, _, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \class(_): labels += (n : DECLARATION_CONSTANT);
        case node n: \class(_, _): labels += (n : DECLARATION_CONSTANT); // added, I think it's missing in documentation
        case node n: \interface(_, _, _, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \field(_, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \initializer(_): labels += (n : DECLARATION_CONSTANT);
        case node n: \method(_, _, _, _, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \method(_, _, _, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \constructor(_, _, _, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \import(_): labels += (n : DECLARATION_CONSTANT);
        case node n: \package(_): labels += (n : DECLARATION_CONSTANT);
        case node n: \package(_, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \variables(_, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \typeParameter(_, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \annotationType(_, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \annotationTypeMember(_, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \annotationTypeMember(_, _, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \parameter(_, _, _): labels += (n : DECLARATION_CONSTANT);
        case node n: \vararg(_, _): labels += (n : DECLARATION_CONSTANT);

        case node n: println(n);
    }
    return <method, labels, "">; // TODO: can this be?
}

/**
Convert the AST to a string with the characters from keywords
*/
SerializedAST serializeAST(SerializedAST methodAnnotated) {
    str ret = "";
    map[node, str] labels = methodAnnotated.labels;
    visit (methodAnnotated) {
        case node n : ret += n in labels ? labels[n] : "_"; // TODO: weird that it doesn't match
    }
    methodAnnotated.serializedAST = ret;
    println(ret);
    return methodAnnotated;
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

/* REMOVED ARG PROJ PATH FOR TESTING ! */
void main() {
    loc projectPath = |project://TestCode|;
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
    list[SerializedAST] annotatedASTs = [];
    for (m <- methodASTs) {
        annotatedASTs += annotateMethodAST(m);
    }

    //// 3: AST Transformations (into single characters)
    // Use visit node
    list[SerializedAST] serializedASTs = [];
    for (m <- annotatedASTs) {
        serializedASTs += serializeAST(m);
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
