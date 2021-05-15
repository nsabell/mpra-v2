#!/usr/bin/env Rscript

library(data.table)

args = commandArgs(trailingOnly=TRUE)

data1 = fread(args[1],header = F)
data2 = fread(args[2],header = F)

names(data1) = c("barcode","oligo","nHits","barcodeCount")
names(data2) = c("barcode","oligo","nHits","barcodeCount")

newData = merge(data1, data2, by= c("barcode","oligo"), all = T)
newData = newData[!duplicated(newData$barcode),]
names(newData) = c("barcode","oligo","nHits.1","barcodeCount.1","nHits.2","barcodeCount.2")

newData[is.na(newData)] = 1

newData = newData[which(newData$nHits.1 == 1 & newData$nHits.2 == 1),c(1,2,3)]
write.table(newData, args[3], quote = F, sep = "\t", row.names = F, col.names = F)

# WHY ARE THERE MORE BARCODES IN THE NEXTSEQ DATA WHY  WHY WHY WHY EWHY