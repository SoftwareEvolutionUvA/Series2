module Detector::Baxter

import lang::java::m3::AST;
import List;
import String;
import Map;
import Set;
import IO;

node REMOVED = "nothing"();

// global because Rascal doesn't use references
map[int, tuple[node, node]] clones = ();
map[node, list[int]] lookupClone = ();


// TODO: can be optimized: store count in map
int mass(node n) {
    int nodeCount = 0;
    visit (n) {
        case node n: nodeCount += 1;
    }
    return nodeCount;
}

real compareTree(node n1, node n2) {
    // set[node] lefts = {};
    // set[node] rights = {};

    // visit (n1) { case node n : lefts += n; }
    // visit (n2) { case node n : rights += n; }

    // int sharedNodes = size(lefts & rights);
    // int n1Count = size(lefts) - sharedNodes;
    // int n2Count = size(rights) - sharedNodes;

    // real score = 2.0 * sharedNodes / (2.0 * sharedNodes + n1Count + n2Count);
    // if (score != 1.0) {
    //     println(score);
    // }
    
    // return score;
    list[node] xNodes = [];
	list[node] yNodes = [];

	visit(n1) {
		case node n: xNodes += n;
	}
	visit(n2) {
		case node n: yNodes += n;
	}

	s = size(xNodes & yNodes);
	l = size(xNodes - yNodes);
	r = size(yNodes - xNodes);
	
    real score = (2.0 * s) / (2 * s + l + r);
    if (score != 1.0) {
        println(score);
    }
	return score;

}

void removeClonePairs(node n) {
    for (int idx <- lookupClone[n]) {
        clones[idx] = <REMOVED, REMOVED>;
        println(clones[idx]);
    }
    lookupClone = delete(lookupClone, n);
}

// asts from createAstsFromMavenProject()
void detector(set[Declaration] asts, int massThreshold, real similarityThreshold) {
    // 1
    // see globals

    // 2
    map[node, list[node]] bucket = ();
    visit(asts) {
        case node n: {
            if (mass(n) >= massThreshold) {
                bucket[n] = n in bucket ? bucket[n] + n : [n];
            }
        }
    }

    // 3
    for (node b <- bucket) {
        list[node] bs = bucket[b];
        if (size(bs) <= 1) continue;
        
        println(size(bs));
        for (int i <- [0 .. size(bs)]) {
            node n1 = elementAt(bs, i);
            for (int j <- [i+1 .. size(bs)]) {
                node n2 = elementAt(bs, j);
                if (compareTree(n1, n2) > similarityThreshold) {
                    visit(n1) {
                        case node n : removeClonePairs(n);
                    }
                    visit(n2) {
                        case node n : removeClonePairs(n);
                    }
                    // add
                    int a = size(clones);
                    addClone(<n1, n2>);
                    if (size(clones) == a) {
                        print("Was ");
                        print(a);
                        print(" is ");
                        println(size(clones));
                    }
                }
            }
        }
    }
}

void addClone(tuple[node n1, node n2] toInsert) {
    int idx = size(clones);
    clones += (idx : toInsert);
    lookupClone = n1 in lookupClone ? lookupClone[n1] + idx : [idx];
    lookupClone = n2 in lookupClone ? lookupClone[n2] + idx : [idx];
}

void main() {
    loc projectPath = |project://Series2/Benchmark/CloneBenchmark|;
    set[Declaration] asts = createAstsFromMavenProject(projectPath, true);
    detector(asts, 7, 7.0);
    println("--------------");
    println(size(clones));
}