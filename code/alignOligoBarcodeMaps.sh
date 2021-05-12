#!/usr/bin/env bash

samtools=./bin/samtools
STAR=./bin/STAR

FASTQ=$1
OUTPFX=$2
REF=$3

STAR --runThreadN 14 \
     --genomeDir $REF \
     --readFilesIn $FASTQ \
     --outFilterMismatchNoverLmax 0.05 \
     --alignIntronMax 1 \
     --outSAMtype BAM SortedByCoordinate \
     --outSAMattributes All \
     --outFileNamePrefix $OUTPFX \
     --limitBAMsortRAM 20000000000 > ${OUTPFX}_STAR.log 2>&1

samtools index -@ 14 ${OUTPFX}Aligned.sortedByCoord.out.bam

samtools view -@ 10 ${OUTPFX}Aligned.sortedByCoord.out.bam | \
    awk '{ if ($5 == 255) print $0 }' | \
    cut -f 1,3,12,14,16 | \
    cut -d : -f 8- | \
    sed 's/NH:i://' | \
    sed 's/AS:i://' | \
    sed 's/NM:i://' > ${OUTPFX}_STAR_rawOligoBarcodeMap_uniqueMaps.txt

samtools view -@ 10 ${OUTPFX}Aligned.sortedByCoord.out.bam  | \
    awk '{ if ($5 != 255) print $0 }' | \
    cut -f 1,2,3,12,14,16 | \
    sed 's/NH:i://' | \
    sed 's/AS:i://' | \
    sed 's/NM:i://' | \
    sort -k 1 >  ${OUTPFX}_STAR_rawOligoBarcodeMap_nonUniqueMaps.txt
