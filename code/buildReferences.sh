#!/usr/bin/env bash

cat variants/*1KG* variants/*sabeti* | \
    sed '/--/d' | \
    fastx_trimmer -f 16 | \
    fastx_trimmer -t 15 > variants/1KG_all.fa

code/collapseReferenceFasta.py variants/1KG_all.fa

./bin/STAR \
     --runMode genomeGenerate \
     --genomeDir rawdata/reference \
     --genomeFastaFiles variants/1KG_all_collapsed.fa \
     --outSAMattributes All \
     --alignIntronMax 0 \
     --outSAMtype BAM SortedByCoordinate \
     --genomeChrBinNbits 10 > rawdata/reference/STAR_generate.log 2>&1
