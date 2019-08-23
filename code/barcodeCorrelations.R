#!/usr/bin/env Rscript

library(data.table)
library(dplyr)
library(ggcorrplot)

args = commandArgs(trailingOnly=TRUE)

data = lapply(args, function(x) fread(x, header = F))
nextData = lapply(nextArgs, function(x) fread(x, header = F))

merged = data %>% reduce(left_join, by = "V2")
nextMerged = nextData %>% reduce(left_join, by = "V2")

pdf("../output/1KG_corrplot_Next.pdf")
nextCorrelations = cor(nextMerged[,-2], use = "pairwise.complete.obs")
ggcorrplot(nextCorrelations, lab = T)
dev.off()

pdf("../output/1KG_corrplot_Nova.pdf")
novaCorrelations = cor(merged[,-2], use = "pairwise.complete.obs")
ggcorrplot(novaCorrelations, lab = T)
dev.off()

allMerged = merge(nextMerged, merged, by = "")
correlations = cor(allMerged[,-1])
names(correlations) = c("Nova_cDNA_1","Nova_cDNA_2","Nova_cDNA_3","Nova_Plasmid_1","Nova_Plasmid_2","Nova_Plasmid_3","Next_cDNA_1","Next_cDNA_2","Next_cDNA_3","Next_Plasmid_1","Next_Plasmid_2","Next_Plasmid_3")

pdf("../output/1KG_corrplot.pdf")
ggcorrplot(correlations, lab = T)
dev.off()