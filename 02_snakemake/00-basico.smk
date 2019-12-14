rule all:
  input: "outputs/2.3.0/lca_search/k21/HSMA33OT.fastq.gz.log"

rule baixa_exemplo:
  output: "inputs/HMP/HSMA33OT.fastq.gz"
  shell: "wget -O inputs/HMP/HSMA33OT.fastq.gz https://ibdmdb.org/tunnel/static/HMP2/WGS/1750/HSMA33OT.fastq.gz"

rule baixa_base_de_dados:
  output: "inputs/lca/genbank-k21.lca.json.gz"
  shell: "wget -O inputs/lca/genbank-k21.lca.json.gz https://osf.io/d7rv8/download"

rule calcula_assinatura:
  output: "outputs/2.3.0/HSMA33OT.fastq.gz.sig"
  input: "inputs/HMP/HSMA33OT.fastq.gz"
  shell: """
    sourmash compute -k 21,31,51 \
      --scaled 2000 \
      --track-abundance \
      --name-from-first \
      -o outputs/2.3.0/HSMA33OT.fastq.gz.sig \
      inputs/HMP/HSMA33OT.fastq.gz
  """

rule classifica_assinatura:
  output: "outputs/2.3.0/lca_search/k21/HSMA33OT.fastq.gz.log"
  input:
    "inputs/lca/genbank-k21.lca.json.gz",
    "outputs/2.3.0/HSMA33OT.fastq.gz.sig"
  shell: """
    sourmash search -o outputs/2.3.0/lca_search/k21/HSMA33OT.fastq.gz.log \
      --scaled 2000  \
      -k 21 \
      outputs/2.3.0/HSMA33OT.fastq.gz.sig \
      inputs/lca/genbank-k21.lca.json.gz
  """
