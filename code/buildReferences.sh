#!/usr/bin/env bash

cat reference/fasta/*1KG* reference/fasta/*sabeti* | \
    sed '/--/d' | \
    fastx_trimmer -f 16 | \
    fastx_trimmer -t 15 > reference/fasta/1KG_all.fa

../scripts/collapseReferenceFasta.py reference/fasta/1KG_all.fa
bwa index -p reference/bwa/1KG/1KG reference/fasta/1KG_all_collapsed.fa
