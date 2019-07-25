## mpra-v2: analysis of eQTL-derived massively paralell reporter assay data

### Prepare oligo-barcode read pairs
`bash code/mergePairs.sh <R1_FASTQ> <R2_FASTQ> <output_prefix>`
`python code/preprocessPairs.py <merged_fastq> <output_prefix>`

### Build oligo-barcode maps
`bash buildReferences.sh` (this step is only required once per oligo library)
`bash alignOligoBarcodeMaps.sh <merged_fastq> <output_prefix> <STAR_reference>`
`python writeBarcodeOligoMapNonUnique.py`
`python writeBarcodeOligoMap.py`


### Extract barcode counts and oligo sums from FASTQ
`bash code/countBarcodes.sh`
`python code/writeOligoSums.py`
`Rscript code/mergeOligoSums.R`

### 

