#!/usr/bin/env bash

# Nathan Abell
# Montgomery Lab
# Stanford University

FASTQ=$1
OUTFILE=$2

gunzip -c $FASTQ | fastx_trimmer -l 20 -Q 33 | fastq_to_fasta -Q 33 | grep -v ">" | sort | uniq -c | sed 's/^ *//' | tr " " "\t" >  $OUTFILE

