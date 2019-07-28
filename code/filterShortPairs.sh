#!/usr/bin/env bash

zcat $1 | awk 'BEGIN {FS = "\t" ; OFS = "\n"} {header = $0 ; getline seq ; getline qheader ; getline qseq ; if (length(seq) >= 25) {print header, seq, qheader, qseq}}' > $2
