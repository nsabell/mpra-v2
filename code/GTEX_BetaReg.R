#!/usr/bin/env Rscript
library(DESeq2)
library(ggplot2)
library(tidyverse)
library(betareg)
source("code/qqunif.plot.R")

data = read.table("output/GTEX_oligoCounts_byVar.txt", header = T)
ratios = data[,9:14] / (data[,9:14] + data[,15:20])
ratios = cbind(data[,1:8], ratios)
names(ratios) = c(names(data)[1:8], "cdna_1","cdna_2","cdna_3","plasmid_1","plasmid_2","plasmid_3")

ratios = ratios[which(rowSums(ratios[,9:14] == 0) == 0),]
ratios = ratios[which(rowSums(ratios[,9:14] == 1) == 0),]

betaTest = function(df){
  
  design = data.frame("ratios" = as.numeric(df), "sample" = as.numeric(c(1,1,1,0,0,0)))
  
  #design = na.omit(design)
  #n_obs = dim(design)[1]
  #design$ratios = ((design$ratios*(n_obs - 1)) + 0.5)/n_obs
  
  modelObject = betareg(formula = ratios ~ sample, data = design)
  modelSummary = summary(modelObject)
  modelSumStats = modelSummary$coefficients$mean[2,]
  
  return(modelSumStats)
}

betaRegResults = t(apply(ratios, 1, function (x) betaTest(x[9:14])))
betaRegResults = cbind(ratios[,1:8], betaRegResults)

betaRegResults$chr = sub("chrom=","", betaRegResults$chr)
betaRegResults$pos = sub("pos=","", betaRegResults$pos)

annotations = read.table("output/mpra.variants.txt", header= T)
betaRegResults_annotated = merge(betaRegResults, annotations, by.x = c("chr","pos"), by.y = c("Chrom","Stop"))

write.table(betaRegResults_annotated, "output/GTEX_BetaReg_results.txt", quote = F, sep = "\t")

pdf("plots/GTEX_BetaReg_QQ.pdf")
qqunif.plot(list("control" = betaRegResults_annotated[which(betaRegResults_annotated$Type == "Control"), "Pr(>|z|)" ], 
                 "outlier" = betaRegResults_annotated[which(betaRegResults_annotated$Type == "Outlier"), "Pr(>|z|)" ]),
            xlim = c(0,4), aspect = "fill", should.thin = F, auto.key=list(corner=c(.05,.95)))
dev.off()


