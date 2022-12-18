module Metrics::UnitSize

import Metrics::Volume;

import List;
import util::Math;
import lang::java::m3::Core;
import lang::java::m3::AST;

// TODO: The getProjectASTs in UnitComplexity now returns an AST with only the methods. 
// This can be used below instead of making a new M3 model and looping over the method-locations!
/**
* Calculates the total LOC per risk-category of methods from the project location given by caller.
* @param projectLoc for the location to project location containing files
* @return list of risk categories (0-4) with total LOC per category
*/
list[int] calculateLOCofMethods(loc projectLocation) {
    M3 model = createM3FromMavenProject(projectLocation);
    list[int] linesOfCode = [0, 0, 0, 0]; // risk: without much risk to very high

    set[loc] methods = methods(model);

    for (m <- methods) {
        int locMethod = size(getLines(m));
        int idx = riskEvaluation(locMethod);
        linesOfCode[idx] += locMethod;
    }
    return linesOfCode;
}
