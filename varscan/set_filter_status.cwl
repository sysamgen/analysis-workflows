#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: "create filtered VCF"
baseCommand: ["/usr/bin/java", "-jar", "/opt/GenomeAnalysisTK.jar", "-T", "VariantFiltration"]
arguments:
    ["--maskName", "processSomatic",
    "--filterNotInMask",
    "-o", { valueFrom: $(runtime.outdir)/output.vcf.gz }]
inputs:
    vcf:
        type: File
        inputBinding:
            prefix: "--variant"
            position: 2
        secondaryFiles: [.tbi]
    filtered_vcf:
        type: File
        inputBinding:
            prefix: "--mask"
            position: 3
        secondaryFiles: [.tbi]
    reference:
        type: File
        inputBinding:
            prefix: "-R"
            position: 1
        secondaryFiles: [".fai", "^.dict"]
outputs:
    merged_vcf:
        type: File
        outputBinding:
            glob: "output.vcf.gz"
