module Report

import IO;
import String;

void createReport(map[str, str] vars, loc fileName) {
    str reportTemplate = readFile(|project://Series2/CloneDetector/report_template.html|);
    for (var <- vars) {
        reportTemplate = replaceAll(reportTemplate, "{{ <var> }}", vars[var]);
    }

    writeFile(fileName, reportTemplate);
}
