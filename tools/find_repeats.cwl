cwlVersion: v1.0
class: CommandLineTool
label: find_repeats

baseCommand:
  - find-repeats.pl

inputs:
  length:
    type: int
    inputBinding:
      position: 1
      prefix: -l
    doc: |
      Repeat length.
  process_id:
    type: int?
    inputBinding:
      position: 2
      prefix: -p
    doc: |
      Unix process ID
  input_fasta:
    type: File
    format: edam:format_1929
    inputBinding:
      position: 3
    doc: |
      Input fasta file.
    
outputs:
  
doc: |


$namespaces:
  edam: http://edamontology.org/
  doap: http://usefulinc.com/ns/doap#
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
  - https://raw.githubusercontent.com/ewilderj/doap/master/schema/doap.rdf