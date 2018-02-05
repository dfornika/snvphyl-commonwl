cwlVersion: v1.0
class: CommandLineTool
label: smalt_map
#"doap:homepage": http://www.sanger.ac.uk/science/tools/smalt-0
#"doap:license": http://spdx.org/licenses/GPL-3.0

baseCommand:
  - smalt
  - map

inputs:
  threads:
    type: int?
    inputBinding:
      position: 1
      prefix: -t
  output_filename:
    type: string
    inputBinding:
      position: 2
      prefix: -o
  output_format:
    type: string
    inputBinding:
      position: 3
      prefix: -f
  index_name:
    type: string
    inputBinding:
      position: 4
    doc: |
      Index basename
  query_file:
    type: File
    inputBinding:
      position: 5
  mate_file:
    type: File?
    inputBinding:
      position: 6

outputs:
  alignment:
    type: File
    outputBinding:
      glob: $(inputs.output_filename)

doc: |
  
  SYNOPSIS:
    smalt map [OPTIONS] <index_name> <query_file> [<mate_file>]
  
  OPTIONS:
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
    -T [STR] Write temporary files do specified directory.
    -w       Use complexity weighted Smith-Waterman scores.
    -x       Exhaustive search for alignments (at the cost of speed).
    -y [FLT] Identity threshold (default: 0).

