## mpra-v2: analysis of eQTL-derived massively paralell reporter assay data

### Build oligo-barcode maps
`code/mergePairs.sh data/rawdata/gtex/GTEX_R1.fastq.gz data/rawdata/gtex/GTEX_R2.fastq.gz data/processed/gtex/fastq/GTEX`
`code/preprocessPairs.py data/processed/gtex/GTEX.extendedFrags.fastq.gz data/processed/gtex/`

GTEX_R1/2.fastq.gz -> GTEX.extendedFrags.fastq.gz FLASH
GTEX.extendedFrags.fastq.gz -> GTEX_pairMerged_processed.fq PREPROCESS-BARCODES
	GTEX_pairMerged_processed.fq -> GTEX_pairMerged_sorted.bam BWA+REFERENCE
	GTEX_pairMerged_processed.fq -> GTEXAligned.sortedByCoord.out.bam STAR+REFERENCE
GTEXAligned.sortedByCoord.out.bam -> 


### Extract barcode counts and oligo sums from FASTQ
`code/extractBarcodeCounts.sh`
`code/computeOligoSums.sh`

### 

