#!/usr/bin/env Rscript

library(tidyverse)
library(data.table)

# Set up directory and file paths
args = commandArgs(trailingOnly=TRUE)
bartenderPath = args[1]
bartenderFiles = list.files(path = bartenderPath, pattern = "_barcode.csv", full.names = T)
#bartenderPath = "./bartender/nextseq"
#bartenderFiles = list.files(path = bartenderPath, pattern = "test_barcode.csv", full.names = T)

# Aggregate bartender files and concatenate
bartenderAggregate = data_frame(filename = bartenderFiles) %>% mutate(file_contents = map(bartenderFiles, ~ read_csv(.)))
bartenderAggregate = unnest(bartenderAggregate)

# Count per-cluster unique sequences within each file
bartenderClusterCounts = bartenderAggregate %>% group_by(filename, Cluster.ID) %>% summarize(uniqueSeqs = n())

# Write summary file and plot unique sequence count densities
fwrite(bartenderClusterCounts, paste0(bartenderPath, "/", args[2], ".txt"), quote = F, sep = "\t", row.names = F, col.names = T, nThread = 10)

# Summarize and plot unique sequence count densities per barcode sample
bartenderClusterSummary = bartenderClusterCounts %>% group_by(filename, uniqueSeqs) %>% summarize(nBarcodes = n())

pdf("plots/1KG_NovaSeq_seqsPerBarcodeCluster.pdf")
#pdf("plots/1KG_NextSeq_seqsPerBarcodeCluster.pdf")
ggplot(bartenderClusterSummary) + 
	geom_bar(aes(x = uniqueSeqs, y = nBarcodes, fill = filename), position="dodge", stat="identity") + 
	xlim(c(0,15)) + 
	theme_bw() + 
	scale_fill_discrete(name = "Sample", labels = c("cDNA_1","Plasmid_1","cDNA_2","Plasmid_2","cDNA_3","Plasmid_3")) +
	ggtitle("NovaSeq Sequences Per Barcode Cluster")
	#scale_fill_discrete(name = "Sample", labels = c("cDNA_1","cDNA_2","cDNA_3","Plasmid_1","Plasmid_2","Plasmid_3")) + 
	#ggtitle("NextSeq Sequences Per Barcode Cluster")
dev.off()


