"cwlVersion": "v1.0"
"class": "CommandLineTool"

$namespaces:
  edam: http://edamontology.org/
  doap: http://usefulinc.com/ns/doap#
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
  - https://raw.githubusercontent.com/ewilderj/doap/master/schema/doap.rdf

"hints": [
  {
    "class": "SoftwareRequirement",
    "packages": [
      {
        "package": "smalt",
        "version": ["0.7.6"],
        "specs": ["https://anaconda.org/bioconda/smalt"]
      }
    ]
  }
]

"label": "smalt_map"
"doap:homepage": "http://www.sanger.ac.uk/science/tools/smalt-0"
"doap:license": "http://spdx.org/licenses/GPL-3.0"

baseCommand:
  - smalt
  - map

inputs:
  coverage:
    type: int?
    inputBinding:
      position: 1
      prefix: -c
    doc: |
      Threshold of the number of bases covered by k-mer seeds. [INT]
  sw_score:
    type: int?
    inputBinding:
      position: 2
      prefix: -d
    doc: |
      Threshold of the Smith-Waterman score relative to best. [INT]
  output_format:
    type: string?
    inputBinding:
      position: 3
      prefix: -f
    doc: |
      Output format [sam(default)|bam|cigar|gff|ssaha].
  input_format:
    type: string?
    inputBinding:
      position: 4
      prefix: -F
    doc: |
      Input format [fastq (default)|sam|bam]. [STR]
  output_filename:
    type: string
    inputBinding:
      position: 5
      prefix: -o
    doc: |
  reads_insert_size_distribution_file:
    type: File?
    inputBinding:
      position: 6
      prefix: -g
    doc: |
      Reads insert size distribution from file. [STR]
  max_insert_size:
    type: int?
    inputBinding:
      position: 7
      prefix: -i
    doc: |
      Maximum insert size for paired reads (default: 500). [INT]
  min_insert_size:
    type: int?
    inputBinding:
      position: 8
      prefix: -j
    doc: |
      Minimum insert size for paired reads (default: 0). [INT]
  library_type:
    type: string?
    inputBinding:
      position: 9
      prefix: -l
    doc: |
      Type of paired read library [pe|mp|pp] (default: pe). [STR]
  alignment_score_threshold:
    type: int?
    inputBinding:
      position: 10
      prefix: -m
    doc: |
      Threshold of alignment score. [INT]
  threads:
    type: int?
    inputBinding:
      position: 11
      prefix: -n
    doc: |
      Number of threads. [INT]
  preserve_order:
    type: boolean?
    inputBinding:
      position: 12
      prefix: -O
    doc: |
      Preserve the order of the reads in the output (with '-n').
  report_split_alignments:
    type: boolean?
    inputBinding:
      position: 13
      prefix: -p
    doc: |
      Report split alignments.
  base_quality_threshold:
    type: int?
    inputBinding:
      position: 14
      prefix: -q
    doc: |
      Base quality threshold <= 10 (default 0).
  random_assignment_degenerate_mappings:
    type: int?
    inputBinding:
      position:
      prefix: -r
    doc: |
      Random assignment of degen. mappings (mark 'unmapped' if < 0). [INT]
  set_alignment_penalties:
    type: string?
    inputBinding:
      position: 15
      prefix: -S
    doc: |
      Set alignment penalties, e.g 'match=1,mismatch=-2,gapopen=-4,gapext=-3' (default). [STR]
  temp_dir:
    type: string?
    inputBinding:
      position: 16
      prefix: -T
    doc: |
      Write temporary files to specified directory.
  use_complexity_weighted_sw_scores:
    type: boolean?
    inputBinding:
      position: 17
      prefix: -w
    doc: |
      Use complexity weighted Smith-Waterman scores.
  exhaustive_search:
    type: boolean?
    inputBinding:
      position: 18
      prefix: -x
    doc: |
      Exhaustive search for alignments (at the cost of speed).
  identity_threshold:
    type: float?
    inputBinding:
      position: 19
      prefix: -y
    doc: |
      Identity threshold (default: 0).
  index_name:
    type: string
    inputBinding:
      position: 20
    doc: |
      Index basename
  query_files:
    type:
      type: array
      items: File
    inputBinding:
      position: 21
    doc: |
      Input sequence reads (R1)
  mate_files:
    type:
      type: array
      items: File
    inputBinding:
      position: 22
    doc: |
      Input sequence reads (R2)
outputs:
  alignment:
    type: File
    outputBinding:
      glob: $(inputs.output_filename)

doc: |
  
  # SYNOPSIS:
    smalt map [OPTIONS] <index_name> <query_file> [<mate_file>]
  
  # OPTIONS:
    -a       Add explicit alignments to output.
    
    -c [INT] Threshold of the number of bases covered by k-mer seeds.
    
    -d [INT] Threshold of the Smith-Waterman score relative to best.
    
    -f [STR] Output format [sam(default)|bam|cigar|gff|ssaha].
             Ext: [sam|bam]:nohead,x,clip.
       
    -F [STR] Input format [fastq (default)|sam|bam].
    
    -g [STR] Reads insert size distribution from file (see 'sample' task).
    
    -H       Print more extensive help on options.
    
    -i [INT] Maximum insert size for paired reads (default: 500).
    
    -j [INT] Minimum insert size for paired reads (default: 0).
    
    -l [STR] Type of paired read library [pe|mp|pp] (default: pe).
    
    -m [INT] Threshold of alignment score.
    
    -n [INT] Number of threads.
    
    -o [STR] Write aligments to specified file (default: stdout).
    
    -O       Preserve the order of the reads in the output (with '-n').
    
    -p       Report split alignments.
    
    -q [INT] Base quality threshold <= 10 (default 0).
    
    -r [INT] Random assignment of degen. mappings (mark 'unmapped' if < 0).
    
    -S [STR] Set alignment penalties,
             e.g 'match=1,mismatch=-2,gapopen=-4,gapext=-3' (default).
    
    -T [STR] Write temporary files to specified directory.
    
    -w       Use complexity weighted Smith-Waterman scores.
    
    -x       Exhaustive search for alignments (at the cost of speed).
    
    -y [FLT] Identity threshold (default: 0).

