#!/bin/bash

# Nathan Abell
# Montgomery Lab
# Stanford University
# SCG4

module load bwa/0.7.15
module load samtools/0.1.19

cd /home/nsabell/scratch/mpra
mkdir bam

bwa mem -L 100 -k 8 -O 5 -t 6 reference/bwa/1KG/1KG fastq_pairMerged/1KG_pairMerged_processed.fastq.gz > bam/1KG_pairMerged.sam &

bwa mem -L 100 -k 8 -O 5 -t 6 reference/bwa/GTEX/GTEX fastq_pairMerged/run1/GTEX.extendedFrags.fastq.gz > bam/GTEX_pairMerged.sam 2> bam/GTEX_pairMerged.log &

wait

samtools view -bS bam/1KG_pairMerged.sam > bam/1KG_pairMerged.bam &
samtools view -bS bam/GTEX_pairMerged.sam > bam/GTEX_pairMerged.bam &

wait

samtools sort -@ 4 bam/GTEX_pairMerged.bam bam/GTEX_pairMerged_sorted &
samtools sort -@ 4 bam/1KG_pairMerged.bam bam/1KG_pairMerged_sorted &

wait

samtools index bam/1KG_pairMerged_sorted.bam &
samtools index bam/GTEX_pairMerged_sorted.bam &

wait

rm bam/1KG_pairMerged.sam bam/GTEX_pairMerged.sam bam/1KG_pairMerged.bam bam/GTEX_pairMerged.bam

