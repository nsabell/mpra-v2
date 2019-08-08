## mpra-v2: analysis of eQTL-derived massively paralell reporter assay data

### Prepare oligo-barcode read pairs
`bash code/mergePairs.sh <R1_FASTQ> <R2_FASTQ> <output_prefix>`  
`python code/preprocessPairs.py <merged_fastq> <output_prefix>`
`bash code/filterShortPairs.sh <merged_fastq> <output_file>`  

### Build oligo-barcode maps
`bash code/buildReferences.sh` (this step is only required once per oligo library)  
`bash alignOligoBarcodeMaps.sh <merged_fastq> <output_prefix> <STAR_reference>`  
`python writeBarcodeOligoMapNonUnique.py <nonunique_maps> <output_file>`  
`python writeBarcodeOligoMap.py <combined_maps> <output_file>`  

### Extract barcode counts and oligo sums from FASTQ
`bash code/countBarcodes.sh <input_fastq> <output_file>`  
`python code/writeOligoSums.py <barcode_map> <barcode_counts> <output_file>`  
`Rscript code/mergeOligoSums.R`  

### 

