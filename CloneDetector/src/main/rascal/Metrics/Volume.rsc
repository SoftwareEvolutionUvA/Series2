module Metrics::Volume

import IO;
import List;
import Map;
import Set;
import String;
import util::Math;
import lang::java::m3::Core;
import lang::java::m3::AST;

/**
* Calculates the LOC from the project location given by caller.
* Reducer is used to transform map to tuple to sum amount of lines. 
* @param projectLoc location to project location containing files
* @return LOC for the project location
*/
public int calculateProjectLOC(loc projectLoc) {
    map[loc, list[str]] linesOfCode = locsCompilationUnits(projectLoc);
    int count = 0;
    for (k <- linesOfCode) {
        count += size(linesOfCode[k]);
    }
    return count;
}

/**
* Obtains the lines from the file location given by caller.
* Whitespaces and comments are ignored
* @param fileLoc location to file
* @return lines for fileLoc
*/
list[str] getLines(loc fileLoc) {
    // remove comments
    str fileContent = readFile(fileLoc);
    commentsRemoved = visit(fileContent) {
        case /(?s)\/\*.*?\*\// => "" // this needs to come first. Only god knows why
    }

    commentsRemoved = visit(commentsRemoved) {
        case /\/\/.*/ => ""
    }

    list[str] whitespaceRemoved = [trim(s) |s <- split("\n", commentsRemoved), !(/^\s*$/ := s)];
    return whitespaceRemoved;
}

/**
* Return the lines of all compilation units in a Maven project.
* Provide path to Maven project.
* Returns map where key is location of compilation unit and value is a list with all lines from that unit
* without lines with whitespace or comments.
*/
public map[loc, list[str]] locsCompilationUnits(loc projectLocation) {
    M3 model = createM3FromMavenProject(projectLocation);
    list[loc] compilationUnits = [f | f <- files(model.containment), isCompilationUnit(f)];

    map[loc, list[str]] compilationUnitsLocs = ();
    for (unit <- compilationUnits) {
        compilationUnitsLocs[unit] = getLines(unit);
    }
    return compilationUnitsLocs;
}