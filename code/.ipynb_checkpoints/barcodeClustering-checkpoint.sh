#!/usr/bin/env bash

## Run bartender-extract on trimmed nextseq and novaseq FASTQs
ls /users/nsabell/scratch/mpra-v2/data/rawdata/1KG/nextseq/* | cut -d . -f 1 | parallel "gunzip -c {}.fastq.gz | fastx_trimmer -l 20 -Q 33 | fastq_to_fasta -Q 33| grep -v '>' | awk '{ print \$1\",\"NR}' > bartender/nextseq/{/}.extractedBarcodes.txt"
ls /users/nsabell/scratch/mpra-v2/data/rawdata/1KG/novaseq/* | cut -d . -f 1 | parallel "gunzip -c {}.fastq.gz | fastx_trimmer -l 20 -Q 33 | fastq_to_fasta -Q 33| grep -v '>' | awk '{ print \$1\",\"NR}' > bartender/novaseq/{/}.extractedBarcodes.txt"

## Run bartender-cluster on extracted barcodes
ls bartender/nextseq/* | cut -d . -f 1 | parallel --dry-run "/users/nsabell/bartender-1.1/bartender_single_com -f {}.extractedBarcodes.txt -o {}.combinedBarcodes.txt -c 1 -t 4 > {}.combinedBarcodes.log 2>&1"
ls bartender/novaseq/*R1* | cut -d . -f 1 | parallel --dry-run "/users/nsabell/bartender-1.1/bartender_single_com -f {}.extractedBarcodes.txt -o {}.combinedBarcodes.txt -c 1 -t 4 > {}.combinedBarcodes.log 2>&1"

