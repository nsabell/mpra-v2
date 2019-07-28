#!/usr/bin/env bash

cat data/reference/1KG/fasta/*1KG* data/reference/1KG/fasta/*sabeti* | \
    sed '/--/d' | \
    fastx_trimmer -f 16 | \
    fastx_trimmer -t 15 > data/reference/1KG/fasta/1KG_all.fa

code/collapseReferenceFasta.py data/reference/1KG/fasta/1KG_all.fa

STAR --runThreadN 20 \
     --runMode genomeGenerate \
     --genomeDir data/reference/1KG/STAR \
     --genomeFastaFiles data/reference/1KG/fasta/1KG_all_collapsed.fa \
     --outSAMattributes All \
     --alignIntronMax 0 \
     --outSAMtype BAM SortedByCoordinate \
     --genomeChrBinNbits 10 > data/reference/1KG/STAR/STAR_generate.log 2>&1
