module Detector::Detector1

import lang::java::m3::AST;
import List;
import String;
import Map;
import Set;
import IO;
import Node;
import Metrics::Volume;
import Type;

// a clone class a representant (key) and a set of all equal clones
alias CloneClass = set[loc];
alias ClonePair = tuple[loc, loc];

set[ClonePair] subsumeClone(Statement s1, Statement s2, set[ClonePair] clonePairs) {
    // no need to compare clone against itself or something that is not like it
    if (unsetRec(s1) != unsetRec(s2) || s1.src == s2.src) {
        return clonePairs;
    }

    // remove smaller parts of clone
    list[loc] smallerParts = \block(ss) := s1 ? [b.src | /b : \block(_) := ss] : [];

    for (loc s <- smallerParts) {
        clonePairs = {<c1, c2> | <c1, c2> <- clonePairs, c1 != s && c2 != s};
    }
    clonePairs += <s1.src, s2.src>;

    return clonePairs;
}

set[ClonePair] subsumeClones(map[int, list[Statement]] hashMap) {
    set[ClonePair] clonePairs = {};

    list[int] filteredBlockSizes = [i | i <- domain(hashMap), size(hashMap[i]) > 1];
    list[int] sortedBlockSizes = sort(filteredBlockSizes);
    // if there is no collision, there's no need to care
    
    for (int noStatements <- sortedBlockSizes) {
        list[Statement] statements = hashMap[noStatements];
        for (Statement s1 <- statements) {
            for (Statement s2 <- statements) {
                clonePairs = subsumeClone(s1, s2, clonePairs);
            }
        }
    }

    return clonePairs;
}

int calculateNumberStatementsSubtree(Statement s) {
    int sCount = 0;
    // blocks are irrelevant -> visit sees the nested stuff anyway
    visit(s) {
        case Statement _ : sCount += 1;
    }
    return sCount;
}

map[int, list[Statement]] addStatement(map[int, list[Statement]] hashMap, Statement s, tuple[int lower, int upper] limits) {
    int numberStatements = calculateNumberStatementsSubtree(s);

    if (numberStatements < limits.lower || numberStatements > limits.upper) {
        return hashMap;
    }

    hashMap[numberStatements] = numberStatements in hashMap ? hashMap[numberStatements] + s : [s];

    return hashMap;
}

map[int, list[Statement]] hashBlocks(set[Declaration] asts, tuple[int lower, int upper] limits) {
    map[int, list[Statement]] ret = ();

    visit(asts) {
        case blck : \block(_) : {
            ret = addStatement(ret, blck, limits);
        }
    }
    return ret;
}

map[loc, CloneClass] formCloneClasses(set[ClonePair] pairs) {
    map[loc, loc] lookup = ();
    map[loc, CloneClass] ret = ();

    for (<p, q> <- pairs) {
        // three cases
        // none is in lookup -> create new list in ret
        if (p notin lookup && q notin lookup) {
            ret[p] = {p, q};
            lookup[p] = p;
            lookup[q] = p;
        }
        // one of them is in lookup, the other not -> place in class of lookup
        else if (p notin lookup && q in lookup) {
            ret[lookup[q]] += p;
            lookup[p] = lookup[q];
        }
        else if (p in lookup && q notin lookup) {
            ret[lookup[p]] += q;
            lookup[q] = lookup[p];
        }
        // both are in different classes -> merge class
        else {
            CloneClass l1 = ret[lookup[p]];
            CloneClass l2 = ret[lookup[q]];
            // put all of l2 in l1
            /// copy elements from l2 in l1
            loc newIdx = lookup[p];
            for (elem <- l2) {
                l1 += elem;
                lookup[elem] = newIdx;
            }
            ret[newIdx] = l1;
        }
    }
    return ret;
}

map[loc, CloneClass] detector(set[Declaration] asts, tuple[int lower, int upper] limits) {
    map[int, list[Statement]] hashedBlocks = hashBlocks(asts, limits);
    set[ClonePair] clonePairs = subsumeClones(hashedBlocks);

    map[loc, CloneClass] classes = formCloneClasses(clonePairs);
    for (idx <- classes) {
        println(size(classes[idx]));
        println(classes[idx]);
        println();
        println();
    }

    return classes;
}

void writeClassesToFile(map[loc, CloneClass] classes, map[str, value] metaData, map[loc, int] locClones,loc outputFile) {
    str ret = "{\n\"metaData\": {\n";
    bool firstElem = true;
    for (key <- metaData) {
        if (!firstElem) {
            ret += ",\n";
        }
        if (firstElem) firstElem = false;
        ret += "\"<key>\": ";
        if (typeOf(metaData[key]) == \loc()) {
            ret += "\"<metaData[key]>\"";
        }
        else {
            ret += "<metaData[key]>";
        }
    }
    ret += "},\n"; // end meta data

    // start classes
    ret += "\"cloneClasses\":[\n";
    // add root node
    ret += "{\n\"id\": 1,\n\"name\": \"root\"\n},\n";

    bool firstClass = true;
    int classCount = 2;
    int numClone = 2;
    int numClasses = size(classes);
    for (key <- classes) {
        
        if (!firstClass) {
            ret += ",\n"; // I hate JSON
        }
        if (firstClass) firstClass = false;
        ret += "{\n";
        ret += "\"id\": <classCount>,\n";
        ret += "\"parent\": 1,\n";
        ret += "\"name\": \"cloneClass<classCount>\"\n";
        ret += "},\n";
        classCount += 1;

        bool firstElem = true;
        for (clone <- classes[key]) {
            if(!firstElem) {
                ret += ",\n"; // I hate JSON
            }
            if (firstElem) firstElem = false;
            // create clone object
            // name
            str rawName = "<clone>";
            list[str] splitted = split("|", rawName);
            str locat = splitted[2];
            list[str] pathSplit = split("/", splitted[1]);
            str className = elementAt(pathSplit, size(pathSplit)-1);


            ret += "{\n";
            ret += "\"id\": <numClasses + numClone>,\n";
            ret += "\"parent\": <classCount-1>,\n";
            ret += "\"name\": \"<className><locat>\",\n";
            ret += "\"location\": \"<clone>\",\n";
            ret += "\"size\": <locClones[clone]>\n}";
            numClone += 1;
        }       
    }
    ret += "\n]\n"; // end classes
    ret += "}";

    writeFile(outputFile, ret);
}

tuple[map[str, value], map[loc, int], map[str, str]] calculateMetaData(map[loc, CloneClass] classes, loc projectPath) {
    map[str, value] ret = ();
            
    map[loc, int] cloneLength = ();
    int totalLinesClones = 0;
    int numClones = 0;
    tuple[int len, loc representant] biggestCloneLOC = <-1, |project://invalid|>;
    tuple[int len, loc representant] biggestCloneClassMembers = <-1, |project://invalid|>;
    for (key <- classes) {
        set[loc] cloneClass = classes[key];
        numClones += size(cloneClass); // number of clones

        // biggest clone class in members
        if (size(cloneClass) > biggestCloneClassMembers.len) {
            biggestCloneClassMembers = <size(cloneClass), key>;
        }

        int locCloneClass = 0;
        for (clone <- cloneClass) {
            int cloneSize = size(getLines(clone));
            cloneLength[clone] = cloneSize;
            locCloneClass += cloneSize;

            // biggest Clone in LOC
            if (cloneSize > biggestCloneLOC.len) {
                biggestCloneLOC = <cloneSize, clone>;
            }
        }
        totalLinesClones += locCloneClass;
    }

    ret["biggestCloneLOC"] = biggestCloneLOC.len;
    ret["biggestCloneClassMembers"] = biggestCloneClassMembers.len;
    ret["numberClones"] = numClones;


    // duplicate lines (relative)
    int totalLoc = calculateProjectLOC(projectPath);
    ret["relativeDuplicateLines"] = (1.0 * totalLinesClones) / totalLoc;
    ret["projectLoc"] = totalLoc;


    // number of cloneClasses
    ret["numberCloneClasses"] = size(classes);

    // create report data
    map[str, str] reportData = ();
    reportData["APPLICATION"] = "<projectPath>";
    reportData["REL_DUPLICATES"] = "<((1.0 * totalLinesClones) / totalLoc) * 100>%";
    reportData["NUM_CLONES"] = "<ret["numberClones"]>";
    reportData["NUM_CLASSES"] = "<ret["numberCloneClasses"]>";
    reportData["BIGGEST_CLONE_LOC"] = "<biggestCloneLOC.len>";
    reportData["BIGGEST_CLONE_CLASS"] = "<biggestCloneClassMembers.len>";

    // build examples
    // TODO: example clones
    exampleClones = "";
    for (clone <- classes[biggestCloneClassMembers.representant]) {
        exampleClones += "Clone at location <clone> looks like:\<br\>\<br\>\<div style=\"background-color:#d6d6d6\"\><readFile(clone)>\</div\>\<br\>\<br\>";
    }
    reportData["CLONE_EXAMPLES"] = exampleClones;


    return <ret, cloneLength, reportData>;
}

void reportvalues(map[str, value] vals) {

}
