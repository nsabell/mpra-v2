#!/usr/bin/env bash

ls /users/nsabell/scratch/mpra-v2/data/rawdata/1KG/novaseq/* | cut -d . -f 1 | parallel "gunzip -c {}.fastq.gz | fastx_trimmer -l 20 -Q 33 | fastq_to_fasta -Q 33| grep -v '>' | awk '{ print \$1\",\"NR}' > bartender/novaseq/{/}.extractedBarcodes.txt"

ls bartender/novaseq/*R1* | cut -d . -f 1 | parallel --dry-run "/users/nsabell/bartender-1.1/bartender_single_com -f {}.extractedBarcodes.txt -o {}.combinedBarcodes.txt -c 1 -t 4 > {}.combinedBarcodes.log 2>&1"

