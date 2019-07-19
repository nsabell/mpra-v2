#!/usr/bin/env Rscript
library(DESeq2)

data = read.table("output/GTEX_oligoCounts_byVar.txt", header = T)

design = data.frame("material" = rep(c(rep("RNA",3),rep("DNA",3)),2), "allele" = c(rep("ref",6),rep("alt",6)))
rownames(design) = colnames(data[,9:20])
data[is.na(data)] = 0

deseq_object = DESeqDataSetFromMatrix(countData=data[,9:20], colData = design, design = ~material + allele + material:allele)
deseq_object = DESeq(deseq_object)

results_material = results(deseq_object, contrast = c("material","RNA","DNA"))
results_oligo = results(deseq_object, contrast = c("allele","ref","alt"))
results_allele = results(deseq_object)

names(results_material) = paste0(names(results_material),"_", "expr")
names(results_oligo) = paste0(names(results_oligo),"_", "oligo")
names(results_allele) = paste0(names(results_allele),"_", "allele")

results_DESeq2 = cbind(data, as.data.frame(results_material), as.data.frame(results_oligo), as.data.frame(results_allele))
write.table(results_DESeq2, "1KG_DESeq2_results.txt", quote = F, sep = "\t", row.names = F, col.names = T)

