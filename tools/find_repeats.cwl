cwlVersion: v1.0
class: CommandLineTool
label: find_repeats
doc: Find repeats in a fasta file
#"doap:homepage": https://github.com/phac-nml/snvphyl-tools
#"doap:license": http://spdx.org/licenses/Apache-2.0

baseCommand:
  - find-repeats.pl

inputs:
  repeat_length:
    type: int?
    inputBinding:
      position: 1
      prefix: -l
    doc: |
      Minimum length of repeat region.
  percent_identity:
    type: int?
    inputBinding:
      position: 2
      prefix: -p
    doc: |
      Minimum percent identity of repeat region.
  input_fasta:
    type: File
    format: edam:format_1929
    streamable: true
    inputBinding:
      position: 3
    doc: |
      Input fasta file.
    
outputs:
  repeats_table:
    type: stdout
    
doc: |
  Usage: /home/dfornika/miniconda2/envs/snvphyl-commonwl/bin/find-repeats.pl [reference.fasta] --min-length [length] --min-pid [pid]
  Parameters:
        [reference.fasta]:  A fasta reference file to search for repeats.
  Options:
        -l|--min-length: Minimum length of repeat region (150).
        -p|--min-pid: Minimum PID of repeat region (90).
        -k|--keep-temp: Keep around temporary nucmer/coords files (no).

$namespaces:
  edam: http://edamontology.org/
  doap: http://usefulinc.com/ns/doap#
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
  - https://raw.githubusercontent.com/ewilderj/doap/master/schema/doap.rdf