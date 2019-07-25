## mpra-v2: analysis of eQTL-derived massively paralell reporter assay data

### Prepare oligo-barcode read pairs
`bash code/mergePairs.sh <R1.fastq.gz> <R2.fastq.gz> <output_prefix>`
`python code/preprocessPairs.py <merged.fastq.gz> <output_prefix>`

### Build oligo-barcode maps
`bash buildReferences.sh` (this step is only required once per oligo library)
`bash alignOligoBarcodeMaps.sh`
`python writeBarcodeOligoMapNonUnique.py`
`python writeBarcodeOligoMap.py`


### Extract barcode counts and oligo sums from FASTQ
`bash code/countBarcodes.sh`
`python code/writeOligoSums.py`
`Rscript code/mergeOligoSums.R`

### 

