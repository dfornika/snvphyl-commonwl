"cwlVersion": "v1.0"
"class": "CommandLineTool"

$namespaces:
  edam: http://edamontology.org/
  doap: http://usefulinc.com/ns/doap#
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
  - https://raw.githubusercontent.com/ewilderj/doap/master/schema/doap.rdf

"label": "bcftools_call"
"doc": "SNP/indel variant calling from VCF/BCF."
"doap:homepage": "https://samtools.github.io/bcftools/"
"doap:license": "https://spdx.org/licenses/MIT"

baseCommand:
  - bcftools
  - call

inputs:
  output_type:
    type: string?
    inputBinding:
      position:
    doc: |
      Output type: 'b' compressed BCF; 'u' uncompressed BCF; 'z' compressed VCF; 'v' uncompressed VCF [v]
  consensus_caller:
    type: boolean
    inputBinding:
      position:
      prefix: --consensus-caller
    doc: |
      The original calling method (conflicts with -m, --multiallelic-caller)
  constrain:
    type: string?
    inputBinding:
      position:
      prefix: --constrain
    doc: |
      One of: alleles, trio (see manual)
  
outputs:
  
doc: |
  About:   SNP/indel variant calling from VCF/BCF. To be used in conjunction with samtools mpileup.
           This command replaces the former "bcftools view" caller. Some of the original
           functionality has been temporarily lost in the process of transition to htslib,
           but will be added back on popular demand. The original calling model can be
           invoked with the -c option.
  Usage:   bcftools call [options] <in.vcf.gz>
  
  File format options:
         --no-version                do not append version and command line to the header
     -o, --output <file>             write output to a file [standard output]
     -O, --output-type <b|u|z|v>     output type: 'b' compressed BCF; 'u' uncompressed BCF; 'z' compressed VCF; 'v' uncompressed VCF [v]
         --ploidy <assembly>[?]      predefined ploidy, 'list' to print available settings, append '?' for details
         --ploidy-file <file>        space/tab-delimited list of CHROM,FROM,TO,SEX,PLOIDY
     -r, --regions <region>          restrict to comma-separated list of regions
     -R, --regions-file <file>       restrict to regions listed in a file
     -s, --samples <list>            list of samples to include [all samples]
     -S, --samples-file <file>       PED file or a file with an optional column with sex (see man page for details) [all samples]
     -t, --targets <region>          similar to -r but streams rather than index-jumps
     -T, --targets-file <file>       similar to -R but streams rather than index-jumps
         --threads <int>             number of extra output compression threads [0]
  
  Input/output options:
     -A, --keep-alts                 keep all possible alternate alleles at variant sites
     -f, --format-fields <list>      output format fields: GQ,GP (lowercase allowed) []
     -F, --prior-freqs <AN,AC>       use prior allele frequencies
     -g, --gvcf <int>,[...]          group non-variant sites into gVCF blocks by minimum per-sample DP
     -i, --insert-missed             output also sites missed by mpileup but present in -T
     -M, --keep-masked-ref           keep sites with masked reference allele (REF=N)
     -V, --skip-variants <type>      skip indels/snps
     -v, --variants-only             output variant sites only
  
  Consensus/variant calling options:
     -c, --consensus-caller          the original calling method (conflicts with -m)
     -C, --constrain <str>           one of: alleles, trio (see manual)
     -m, --multiallelic-caller       alternative model for multiallelic and rare-variant calling (conflicts with -c)
     -n, --novel-rate <float>,[...]  likelihood of novel mutation for constrained trio calling, see man page for details [1e-8,1e-9,1e-9]
     -p, --pval-threshold <float>    variant if P(ref|D)<FLOAT with -c [0.5]
     -P, --prior <float>             mutation rate (use bigger for greater sensitivity), use with -m [1.1e-3]
  

