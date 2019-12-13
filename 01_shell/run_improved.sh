#! /bin/bash

# Baixa arquivo para classificação
mkdir -p inputs/HMP
wget -c -O inputs/HMP/HSMA33OT.fastq.gz https://ibdmdb.org/tunnel/static/HMP2/WGS/1750/HSMA33OT.fastq.gz

# Baixa base de dados para comparação
mkdir -p inputs/lca
wget -c -O inputs/lca/genbank-k21.lca.json.gz https://osf.io/d7rv8/download

# Calcula uma assinatura para o arquivo a ser classificado
mkdir -p outputs/2.3.0
sourmash compute -k 21,31,51 \
  --scaled 2000 \
  --track-abundance \
  --name-from-first \
  -o outputs/2.3.0/HSMA33OT.fastq.gz.sig \
  inputs/HMP/HSMA33OT.fastq.gz

# Classifica a assinatura contra a base de dados
mkdir -p outputs/2.3.0/lca_search/k21
sourmash search -o outputs/2.3.0/lca_search/k21/HSMA33OT.fastq.gz.log \
  --scaled 2000  \
  -k 21 \
  outputs/2.3.0/HSMA33OT.fastq.gz.sig \
  inputs/lca/genbank-k21.lca.json.gz
