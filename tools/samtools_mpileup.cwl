"cwlVersion": "v1.0"
"class": "CommandLineTool"

$namespaces:
  edam: http://edamontology.org/
  doap: http://usefulinc.com/ns/doap#
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
  - https://raw.githubusercontent.com/ewilderj/doap/master/schema/doap.rdf

"label": "samtools_mpileup"
"doap:homepage": "http://www.htslib.org/"
"doap:license": "http://spdx.org/licenses/MIT"

baseCommand:
  - samtools
  - mpileup

inputs:
  compute_genotype_likelihoods:
    type: boolean?
    inputBinding:
      position:
      prefix: --VCF
    doc: |
      Compute genotype likelihoods and output them in the variant call format (VCF). Output is bgzip-compressed VCF unless -u option is set.
  uncompressed:
    type: boolean?
    inputBinding:
      position:
      prefix: --uncompressed
    doc: |
      Generate uncompressed VCF/BCF output, which is preferred for piping.
  max_depth:
    type: int?
    inputBinding:
      position:
      prefix: --max-depth
    doc: |
      At a position, read maximally INT reads per input BAM. [250]
  alignment:
    type: File
    format: edam:format_2572
    inputBinding:
      position: 1
  
outputs:
  
doc: |
  Usage: samtools mpileup [options] in1.bam [in2.bam [...]]

  Input options:
  
       -6           assume the quality is in the Illumina-1.3+ encoding
       -A           count anomalous read pairs
       -B           disable BAQ computation
       -b FILE      list of input BAM files [null]
       -C INT       parameter for adjusting mapQ; 0 to disable [0]
       -d INT       max per-BAM depth to avoid excessive memory usage [250]
       -E           extended BAQ for higher sensitivity but lower specificity
       -f FILE      faidx indexed reference sequence file [null]
       -G FILE      exclude read groups listed in FILE [null]
       -l FILE      list of positions (chr pos) or regions (BED) [null]
       -M INT       cap mapping quality at INT [60]
       -r STR       region in which pileup is generated [null]
       -R           ignore RG tags
       -q INT       skip alignments with mapQ smaller than INT [0]
       -Q INT       skip bases with baseQ/BAQ smaller than INT [13]
  
  Output options:

       -D           output per-sample DP in BCF (require -g/-u)
       -g           generate BCF output (genotype likelihoods)
       -O           output base positions on reads (disabled by -g/-u)
       -s           output mapping quality (disabled by -g/-u)
       -S           output per-sample strand bias P-value in BCF (require -g/-u)
       -u           generate uncompress BCF output

  SNP/INDEL genotype likelihoods options (effective with `-g' or `-u'):
  
       -e INT       Phred-scaled gap extension seq error probability [20]
       -F FLOAT     minimum fraction of gapped reads for candidates [0.002]
       -h INT       coefficient for homopolymer errors [100]
       -I           do not perform indel calling
       -L INT       max per-sample depth for INDEL calling [250]
       -m INT       minimum gapped reads for indel candidates [1]
       -o INT       Phred-scaled gap open sequencing error probability [40]
       -P STR       comma separated list of platforms for indels [all]
  
  Notes: Assuming diploid individuals.
