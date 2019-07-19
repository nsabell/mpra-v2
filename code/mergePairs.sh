#!/usr/bin/env bash

# Nathan Abell
# Montgomery Lab
# Stanford University

# Usage: 01_readPairProcessing.sh <R1.fastq.gz> <R2.fastq.gz> <out_pfx>

R1=$1
R2=$2
OUTPFX=$3

export FLASH=/users/nsabell/mpra/1KG/bin/FLASH-1.2.11/flash
$FLASH -t 20 -o $OUTPFX -z -r 150 -f 223 -s 10 $R1 $R2
