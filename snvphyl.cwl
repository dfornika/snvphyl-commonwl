cwlVersion: v1.0
class: Workflow
requirements:
  - class: StepInputExpressionRequirement
  - class: InlineJavascriptRequirement

inputs:
- id: reference
  type: File
  doc: Reference file in fasta format
- id: find_repeats::repeat_length
  type: int?
  doc: Minimum length of repeat region.
- id: find_repeats::percent_identity
  type: int?
  doc: Minimum percent identity of repeat region.
- id: smalt_index::word_length
  type: int?
- id: smalt_index::step_size
  type: int?
- id: smalt_index::index_name
  type: string
- id: smalt_map::output_format
  type: string?
- id: smalt_map::output_filename
  type: string
- id: smalt_map::R1_reads
  type: File[]
  doc: list of files containing the first end of paired end reads in fasta or fastq
- id: smalt_map::R2_reads
  type: File[]
  doc: list of files containing the second end of paired end reads in fasta or fastq
  

outputs:
- id: alignment
  type: File
  outputSource: 'smalt_map/alignment'
- id: repeats_table
  type: File
  outputSource: 'find_repeats/repeats_table'

steps:
- id: find_repeats
  run: tools/find_repeats.cwl
  in:
    - { id: repeat_length, source: '#find_repeats::repeat_length', default: 150 }
    - { id: percent_identity, source: '#find_repeats::percent_identity', default: 90 }
    - { id: input_fasta, source: '#reference' }
  out:
    - { id: repeats_table }
- id: smalt_index
  run: tools/smalt_index.cwl
  in:
    - { id: word_length, source: '#smalt_index::word_length', default: 13 }
    - { id: step_size, source: '#smalt_index::step_size', default: 6 }
    - { id: reference, source: '#reference' }
    - { id: index_name, source: '#smalt_index::index_name' }
  out:
    - { id: smalt_index }
    - { id: smalt_array }
- id: smalt_map
  run: tools/smalt_map.cwl
  in:
    index_name:
      source: '#smalt_index/smalt_index'
      valueFrom: $(self.location.replace("file://", "").replace(/\.[^/.]+$/, ""))
    query_files:
      source: '#smalt_map::R1_reads'
    mate_files:
      source: '#smalt_map::R2_reads'
    output_format:
      source: '#smalt_map::output_format'
      default: "bam"
    output_filename:
      source: '#smalt_map::output_filename'
  out:
    - { id: alignment }
- id: freebayes
  run: tools/freebayes.cwl
  in:
    alignment_file:
      source: '#smalt_map/alignment'
    ploidy:
      default: 1
  out:
    - { id: freebayes::vcf }
-id: samtools_mplieup
  run: tools/samtools_mpileup.cwl
  in:
    alignment_files:
      source: '#smalt_map/alignment'
    generate_genotype_likelihoods_vcf:
      default: true
  out:
    - {id: samtools_mpileup::vcf }