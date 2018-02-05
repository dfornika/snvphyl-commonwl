cwlVersion: v1.0
class: Workflow

inputs:
- id: smalt_index::word_length
  type: int
- id: smalt_index::step_size
  type: int
- id: smalt_map::index_name
  type: string
- id: smalt_map::output_format
  type: string
- id: smalt_map::output_filename
  type: string
- id: smalt_map::R1_reads
  type:
  - type: array
    items: File
  doc: list of files containing the first end of paired end reads in fasta or fastq
- id: smalt_map::R2_reads
  type:
  - type: array
    items: File
  doc: list of files containing the second end of paired end reads in fasta or fastq  
- id: reference
  type: File
  doc: Reference file in fasta format

outputs:
- id: alignment
  type: File
  outputSource: '#smalt_map/alignment'

steps:
- id: smalt_index
  run: tools/smalt-index.cwl
  in:
    - {id: word_length, source: '#smalt_index::word_length'}
    - {id: step_size, source: '#smalt_index::step_size'}
    - {id: reference, source: '#reference'}
    - {id: index_name, source: '#smalt_map::index_name'}
  out:
    - {id: smalt_index}
    - {id: smalt_array}
- id: smalt_map
  run: tools/smalt-map.cwl
  in:
    index_name: $(smalt_index/smalt_index.out.basename)
    query_file: '#smalt_map::R1_reads'
    mate_file: '#smalt_map::R2_reads'
    output_format: '#smalt_map::output_format'
    output_filename: '#smalt_map::output_filename'
  out:
    - {id: alignment}

