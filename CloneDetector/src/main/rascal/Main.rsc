module Main

import IO;
import Detector::Detector1;
import Detector::Detector2;
import lang::java::m3::AST;
import Report;
import DateTime;

void main() {
    // To run stuff, pick one of the blocks below and uncomment them
    // also: this runs the detector for type 1. If you want type 2
    // change call "runDetector1" to "runDetector2" (same parameters)
    // AND: change the outputPaths, such that they end in "_type2.json" or "_type2.html".
    // IF YOU DON'T DO THAT, IT WILL OVERWRITE THE TYPE 1 REPORTS
    // loc projectPath = |project://Series2/Benchmark/CloneBenchmark|;
    // loc outputPathClones = |project://Series2/benchmark_type2.json|;
    // loc outputPathReport = |project://Series2/benchmark_type2.html|;

    // loc outputPathClones = |project://Series2/hsqldb-2.3.1_type1.json|;
    // loc outputPathReport = |project://Series2/hsqldb-2.3.1_type1.html|;
    // loc projectPath = |project://hsqldb-2.3.1|;
    
    loc projectPath = |project://smallsql0.21_src|;
    loc outputPathClones = |project://Series2/smallsql0.21_src_type2.json|;
    loc outputPathReport = |project://Series2/smallsql0.21_src_type2.html|;


    set[Declaration] asts = createAstsFromMavenProject(projectPath, true);
    runDetector2(asts, projectPath, outputPathClones, outputPathReport);
}

void runDetector1(set[Declaration] asts, loc projectPath, loc outputPath, loc outputPathReport) {
    datetime begin1 = now();
    map[loc, CloneClass] classes = detector(asts, <3, 100>);

    tuple[map[str, value], map[loc, int], map[str, str]] stuff = calculateMetaData(classes, projectPath);
    datetime end1 = now();
    dur = createDuration(begin1, end1);

    map[str, value] metaData = stuff[0];
    map[loc, int] locClones = stuff[1];


    map[str, str] reportData = stuff[2];
    todayDate = splitDateTime(begin1);
    reportData["DATE"] = "<todayDate[0]>";
    reportData["STARTTIME"] = "<todayDate[1]>";
    reportData["EXECUTION_TIME"] = "<dur>";

    writeClassesToFile(classes, metaData, locClones, outputPath);
    createReport(reportData, outputPathReport);
}

void runDetector2(set[Declaration] asts, loc projectPath, loc outputPath, loc outputPathReport) {
    asts = generalize(asts);
    runDetector1(asts, projectPath, outputPath, outputPathReport);
}