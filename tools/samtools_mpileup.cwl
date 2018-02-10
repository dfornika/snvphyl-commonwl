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
        "package": "samtools",
        "version": ["1.2"],
        "specs": ["https://anaconda.org/bioconda/samtools"]
      }
    ]
  }
]

"label": "samtools_mpileup"
"doap:homepage": "http://www.htslib.org/"
"doap:license": "http://spdx.org/licenses/MIT"

baseCommand:
  - samtools
  - mpileup

inputs:
  generate_genotype_likelihoods_vcf:
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
  maximum_depth:
    type: int?
    inputBinding:
      position:
      prefix: --max-depth
    doc: |
      At a position, read maximally INT reads per input BAM. [250]
  minimum_base_quality:
    type: int?
    inputBinding:
      position:
      prefix: -Q
    doc: |
      Skip bases with baseQ/BAQ smaller than INT [13]
  minimum_mapping_quality:
    type: int?
    inputBinding:
      position:
      prefix: -q
    doc: |
      Skip alignments with mapQ smaller than INT [13]
  reference_file:
    type: File
    format: edam:format_1929
    inputBinding:
      position:
      prefix: -f
  alignment_files:
    type: File[]
    format: edam:format_2572
    inputBinding:
      position: 
    
outputs:
  variants:
    outputBinding:
    
doc: |
  Usage: samtools mpileup [options] in1.bam [in2.bam [...]]
  
  Input options:
    -6, --illumina1.3+      quality is in the Illumina-1.3+ encoding
    -A, --count-orphans     do not discard anomalous read pairs
    -b, --bam-list FILE     list of input BAM filenames, one per line
    -B, --no-BAQ            disable BAQ (per-Base Alignment Quality)
    -C, --adjust-MQ INT     adjust mapping quality; recommended:50, disable:0 [0]
    -d, --max-depth INT     max per-BAM depth; avoids excessive memory usage [250]
    -E, --redo-BAQ          recalculate BAQ on the fly, ignore existing BQs
    -f, --fasta-ref FILE    faidx indexed reference sequence file
    -G, --exclude-RG FILE   exclude read groups listed in FILE
    -l, --positions FILE    skip unlisted positions (chr pos) or regions (BED)
    -q, --min-MQ INT        skip alignments with mapQ smaller than INT [0]
    -Q, --min-BQ INT        skip bases with baseQ/BAQ smaller than INT [13]
    -r, --region REG        region in which pileup is generated
    -R, --ignore-RG         ignore RG tags (one BAM = one sample)
    --rf, --incl-flags STR|INT  required flags: skip reads with mask bits unset []
    --ff, --excl-flags STR|INT  filter flags: skip reads with mask bits set
                                              [UNMAP,SECONDARY,QCFAIL,DUP]
    -x, --ignore-overlaps   disable read-pair overlap detection
  
  Output options:
    -o, --output FILE       write output to FILE [standard output]
    -g, --BCF               generate genotype likelihoods in BCF format
    -v, --VCF               generate genotype likelihoods in VCF format
  
  Output options for mpileup format (without -g/-v):
    -O, --output-BP         output base positions on reads
    -s, --output-MQ         output mapping quality
  
  Output options for genotype likelihoods (when -g/-v is used):
    -t, --output-tags LIST  optional tags to output: DP,DPR,DV,DP4,INFO/DPR,SP []
    -u, --uncompressed      generate uncompressed VCF/BCF output
  
  SNP/INDEL genotype likelihoods options (effective with -g/-v):
    -e, --ext-prob INT      Phred-scaled gap extension seq error probability [20]
    -F, --gap-frac FLOAT    minimum fraction of gapped reads [0.002]
    -h, --tandem-qual INT   coefficient for homopolymer errors [100]
    -I, --skip-indels       do not perform indel calling
    -L, --max-idepth INT    maximum per-sample depth for INDEL calling [250]
    -m, --min-ireads INT    minimum number gapped reads for indel candidates [1]
    -o, --open-prob INT     Phred-scaled gap open seq error probability [40]
    -p, --per-sample-mF     apply -m and -F per-sample for increased sensitivity
    -P, --platforms STR     comma separated list of platforms for indels [all]
  
  Notes: Assuming diploid individuals.
