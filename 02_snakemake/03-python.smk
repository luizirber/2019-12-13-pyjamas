rule all:
  input:
    expand("outputs/2.3.0/lca_search/k{ksize}/HSMA33OT.fastq.gz.log",
           ksize=[21,31,51])

rule baixa_exemplo:
  output: "inputs/HMP/HSMA33OT.fastq.gz"
  shell: "wget -O {output} https://ibdmdb.org/tunnel/static/HMP2/WGS/1750/HSMA33OT.fastq.gz"

rule baixa_base_de_dados_k21:
  output: "inputs/lca/genbank-k21.lca.json.gz"
  shell: "wget -O {output} https://osf.io/d7rv8/download"

rule baixa_base_de_dados_k31:
  output: "inputs/lca/genbank-k31.lca.json.gz"
  shell: "wget -O {output} https://osf.io/4f8n3/download"

rule baixa_base_de_dados_k51:
  output: "inputs/lca/genbank-k51.lca.json.gz"
  shell: "wget -O {output} https://osf.io/nemkw/download"

rule calcula_assinatura:
  output: "outputs/2.3.0/HSMA33OT.fastq.gz.sig"
  input: "inputs/HMP/HSMA33OT.fastq.gz"
  shell: """
    sourmash compute -k 21,31,51 \
      --scaled 2000 \
      --track-abundance \
      --name-from-first \
      -o {output} \
      {input}
  """

rule classifica_assinatura:
  output: "outputs/2.3.0/lca_search/k{ksize}/HSMA33OT.fastq.gz.log"
  input:
    db = "inputs/lca/genbank-k{ksize}.lca.json.gz",
    query = "outputs/2.3.0/HSMA33OT.fastq.gz.sig"
  shell: """
    sourmash search -o {output} \
      --scaled 2000  \
      -k {wildcards.ksize} \
      {input.query} \
      {input.db}
  """

rule resultados:
  input:
    expand("outputs/2.3.0/lca_search/k{ksize}/HSMA33OT.fastq.gz.log",
           ksize=[21,31,51])
  run:
      from collections import Counter
      from pprint import pprint

      import pandas

      encontrados = Counter()
      for f in input:
          resultado = pandas.read_csv(f)
          encontrados.update(resultado['name'])
      pprint(encontrados.most_common(), width=140)

