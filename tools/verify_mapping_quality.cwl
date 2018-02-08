"cwlVersion": "v1.0"
"class": "CommandLineTool"

$namespaces:
  edam: http://edamontology.org/
  doap: http://usefulinc.com/ns/doap#
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
  - https://raw.githubusercontent.com/ewilderj/doap/master/schema/doap.rdf

"label": "verify_mapping_quality"
"doap:homepage": "https://github.com/phac-nml/snvphyl-tools"
"doap:license": "http://spdx.org/licenses/Apache-2.0"

baseCommand:
  - verify_mapping_quality.pl

inputs:
  bam:
    type: File
    inputBinding:
      position: 1
      prefix: --bam
    doc: |
      The location for a specific BAM file in the dataset. Multiple BAM
          files can be input. Example with 3 BAM files: --bam
          bam1=/path/bam1.bam --bam bam2=/path/bam2.bam --bam
          bam3=/path/bam3.bam
  minimum_depth:
    type: int?
    inputBinding:
      position: 2
      prefix: --min-depth
    doc: |
      The minimum depth of coverage required at each genome position to be
      considered mapped. Default value is 15x.
  minimum_percentage_mapped:
    type: int?
    inputBinding:
      position: 3
      prefix: --min-map
    doc: |
      The minimum percent mapped to reference for each strain, pipeline
      will log all strains that do not meet this minimum percentage.
      Default value is 80%.
  cores:
    type: int?
    inputBinding:
      position: 4
      prefix: --cores
    doc: |
      The number of CPU cores that should be used for the calculations.
  output_report_path:
    type: string
    inputBinding:
      position: 5
      prefix: --output
    doc: |
      Path to write human readable report.
  output_strains_path:
    type: string
    inputBinding:
      position: 6
      prefix: --out_strains
    doc: |
      Path to write list of strain(s) one per line for filter File
      collection tool or vcf2snvalignment itself
      
outputs:
  mapping_quality_report:
    type: File
    outputBinding:
      glob: $(output_report_path)
  strains_list:
    type: File
    outputBinding:
      glob: $(output_strains_path)

doc: |
  Usage:
      verify_mapping_quality.pl --bam bamX=/inputDirrectory/bamfile.bam
      --min-depth minimum-depth --min-map minimum-percent-mapping -h help
  
  Options:
      --bam [REQUIRED]
          The location for a specific BAM file in the dataset. Multiple BAM
          files can be input. Example with 3 BAM files: --bam
          bam1=/path/bam1.bam --bam bam2=/path/bam2.bam --bam
          bam3=/path/bam3.bam
  
      --min-depth [optional]
          The minimum depth of coverage required at each genome position to be
          considered mapped. Default value is 15x.
  
      --min-map [optional]
          The minimum percent mapped to reference for each strain, pipeline
          will log all strains that do not meet this minimum percentage.
          Default value is 80%.
  
      -c, --cores [optional]
          The number of CPU cores that should be used for the calculations.
  
      -o, --output
          Path to write human readable report
  
      --out_strains
          Path to write list of strain(s) one per line for filter File
          collection tool or vcf2snvalignment itself
  
      -h, --help
          To displays help screen.
