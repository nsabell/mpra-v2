## FineMapMPRA - Public Repository

### MPRA Data Bioinformatics

`bash code/mergePairs.sh <R1_FASTQ> <R2_FASTQ> <output_prefix>`  
`python code/preprocessPairs.py <merged_fastq> <output_prefix>`

`bash code/buildReferences.sh` (this step is only required once per oligo library)  
`bash alignOligoBarcodeMaps.sh <merged_fastq> <output_prefix> <STAR_reference>`  
`python writeBarcodeOligoMapNonUnique.py <nonunique_maps> <output_file>`  
`python writeBarcodeOligoMap.py <combined_maps> <output_file>`  

`bash code/barcodeClustering.sh`
`Rscript code/computeOligoCounts.R`

Executed commands on real data are shown in `README.cmds` for data not included here due to size.

### Manuscript Analysis Notebooks

1. [Overview and Replicate Correlations](notebooks/section1-descriptive-statistics.ipynb)
2. [MPRA Statistical Inference](notebooks/section2-model-inference.ipynb)
3. [Summary Statistics](notebooks/section2a-model-eval.ipynb)
4. [Functional Characterization](notebooks/section3-functional-annotation.ipynb)
5. [eQTL Integration](notebooks/section4-eqtl.ipynb)
6. Haplotype Decomposition
7. GWAS Integration and Colocalization
8. Supplementary Tables and Data
