#!/usr/bin/env Rscript

# Nathan Abell
# Montgomery Lab
# Stanford University

library(dplyr)
library(purrr)
library(stringr)

header = c("oligo","count","barcodes")

cdna1 = read.table("output/MPRApool_2_S2_R1_001.oligoCount.txt", col.names = header)
cdna2 = read.table("output/MPRApool_4_S4_R1_001.oligoCount.txt", col.names = header)
cdna3 = read.table("output/MPRApool_6_S6_R1_001.oligoCount.txt", col.names = header)

plasmid1 = read.table("output/MPRApool_3_S3_R1_001.oligoCount.txt", col.names = header)
plasmid2 = read.table("output/MPRApool_5_S5_R1_001.oligoCount.txt", col.names = header)
plasmid3 = read.table("output/MPRApool_7_S7_R1_001.oligoCount.txt", col.names = header)

data = list(cdna1[,-3], cdna2[,-3], cdna3[,-3], plasmid1[,-3], plasmid2[,-3], plasmid3[,-3]) %>% reduce(full_join, by ="oligo")
data[is.na(data)] = 0

names(data) = c("oligo","cdna_1","cdna_2","cdna_3","plasmid_1","plasmid_2","plasmid_3")

write.table(x = data, file = "output/1KG_oligoCounts.txt", sep = "\t", quote = F, row.names = F)

dataBarcodeCount = list(cdna1[,-2], cdna2[,-2], cdna3[,-2], plasmid1[,-2], plasmid2[,-2], plasmid3[,-2]) %>% reduce(full_join, by ="oligo")
dataBarcodeCount[is.na(dataBarcodeCount)] = 0

names(dataBarcodeCount) = c("oligo","cdna_1","cdna_2","cdna_3","plasmid_1","plasmid_2","plasmid_3")

write.table(x = dataBarcodeCount, file = "output/1KG_barcodesPerOligo.txt", sep = "\t", quote = F, row.names = F)

metadata = as.data.frame(str_split_fixed(data$oligo, "_", 13))
names(metadata) = c("pool","varID","geneID","chr","pos","strand","ref","alt","allele","haploFlag","restrictionFlag","length","numOtherVars")
data = cbind(data, metadata)

dataRef = data[which(data$allele == "allele=ref"),]
dataAlt = data[which(data$allele != "allele=ref"),]
dataMerged = merge(dataRef, dataAlt, all = T, by = c("pool","varID","geneID","chr","pos","strand","ref","alt","haploFlag"))
dataMerged = dataMerged[,c(1:9,11:16,22:27)]
names(dataMerged) = c("pool","varID","geneID","chr","pos","strand","ref","alt","haploFlag","cdna1_ref","cdna2_ref","cdna3_ref","plasmid1_ref","plasmid2_ref","plasmid3_ref","cdna1_alt","cdna2_alt","cdna3_alt","plasmid1_alt","plasmid2_alt","plasmid3_alt")

write.table(x = dataMerged, file = "output/1KG_oligoCounts_byVar.txt", sep = "\t", quote = F, row.names = F)

