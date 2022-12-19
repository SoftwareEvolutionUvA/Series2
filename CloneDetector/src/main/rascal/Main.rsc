module Main

import IO;
import Detector::Detector1;
import Detector::Detector2;
import lang::java::m3::AST;

void main() {
    loc projectPath = |project://Series2/Benchmark/CloneBenchmark|;
    loc outputPath = |project://Series2/benchmark.json|;

    //loc projectPath = |project://hsqldb-2.3.1|;
    //loc outputPath = |project://Series2/hsqldb-2.3.1.json|;
    
    //loc projectPath = |project://hsqldb-2.3.1|;
    //loc outputPath = |project://Series2/hsqldb-2.3.1.json|;
    set[Declaration] asts = createAstsFromMavenProject(projectPath, true);
    
    runDetector2(asts, projectPath, outputPath);
    //runDetector2();
}

void runDetector1(set[Declaration] asts, loc projectPath, loc outputPath) {
    map[loc, CloneClass] classes = detector(asts, <3, 100>);

    tuple[map[str, value], map[loc, int]] stuff = calculateMetaData(classes, projectPath);
    map[str, value] metaData = stuff[0];
    map[loc, int] locClones = stuff[1];
    writeClassesToFile(classes, metaData, locClones, outputPath);
}

void runDetector2(set[Declaration] asts, loc projectPath, loc outputPath) {
    asts = generalize(asts);
    runDetector1(asts, projectPath, outputPath);
}
