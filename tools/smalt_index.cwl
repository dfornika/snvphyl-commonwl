"cwlVersion": "v1.0"
"class": "CommandLineTool"

$namespaces:
  edam: http://edamontology.org/
  doap: http://usefulinc.com/ns/doap#
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
  - https://raw.githubusercontent.com/ewilderj/doap/master/schema/doap.rdf

"label": "smalt_index"
"doc": "Generate an index file for smalt alignment."
"doap:homepage": "http://www.sanger.ac.uk/science/tools/smalt-0"
"doap:license": "http://spdx.org/licenses/GPL-3.0"

baseCommand:
  - smalt
  - index

inputs:
  word_length:
    type: int?
    inputBinding:
      position: 1
      prefix: -k
    doc: |
      -k INT Length of the k-mer words indexed. (min=2, max=20, default=13)
  step_size:
    type: int?
    inputBinding:
      position: 2
      prefix: -s
    doc: |
      -s INT Specifies how many bases are skipped between words (default=word_length)
  index_name:
    type: string
    inputBinding:
      position: 3
    doc: |
      Base filename for output index files.
  reference:
    type: File
    format: edam:format_1929
    streamable: true
    inputBinding:
      position: 4
    doc: |
      FASTA or FASTQ file to index.

outputs:
  smalt_index:
    type: File
    outputBinding:
      glob: $(inputs.index_name).smi
  smalt_array:
    type: File
    outputBinding:
      glob: $(inputs.index_name).sma

doc: |
  SYNOPSIS:
    smalt index [-k <wordlen>] [-s <stepsiz>]  <index_name> <reference_file>
  
  
  OPTIONS:
    -H       Print more extensive help on options.
    -k [INT] Length of the k-mer words indexed.
    -s [INT] Sample every <stepsiz>-th k-mer word (stride).
