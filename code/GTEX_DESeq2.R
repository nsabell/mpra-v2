#!/usr/bin/env Rscript
library(DESeq2)
library(ggplot2)
source("code/qqunif.plot.R")

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
write.table(results_DESeq2, "output/GTEX_DESeq2_results.txt", quote = F, sep = "\t", row.names = F, col.names = T)

results_DESeq2$chr = sub("chrom=","", results_DESeq2$chr)
results_DESeq2$pos = sub("pos=","", results_DESeq2$pos)

annotations = read.table("output/mpra.variants.txt", header= T)
results_annotated = merge(results_DESeq2, annotations, by.x = c("chr","pos"), by.y = c("Chrom","Stop"))

pdf("plots/GTEX_DESeq2_QQ.pdf")
qqunif.plot(list("control" = results_annotated[which(results_annotated$Type == "Control"), "pvalue_expr"], 
                 "outlier" = results_annotated[which(results_annotated$Type == "Outlier"), "pvalue_expr"]),
            xlim = c(0,4), aspect = "fill", should.thin = F, auto.key=list(corner=c(.05,.95)), main = "Expression Effects")
qqunif.plot(list("control" = results_annotated[which(results_annotated$Type == "Control"), "pvalue_allele"], 
                 "outlier" = results_annotated[which(results_annotated$Type == "Outlier"), "pvalue_allele"]),
            xlim = c(0,4), aspect = "fill", should.thin = F, auto.key=list(corner=c(.05,.95)),main = "Allelic Effects")
dev.off()
