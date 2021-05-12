#!/usr/bin/env python3

# preprocess_merged_pairs.py <input_fastq_from_flash> <out_name>

import sys
import gzip

outname = sys.argv[2]

with open(outname, 'w') as outfile, open(sys.argv[1], 'r')as file:

	while True:

		header = file.readline()
		if not header:
			break
		header = header.strip().split(' ')[0]
		
		sequence = file.readline().strip()
		filter = file.readline()
		phred = file.readline().strip()
        
		if len(sequence[58:-16]) >= 25: 
			
			toWrite = header + ":" + sequence[0:20] + '\n' + sequence[58:-16] + '\n' + filter + phred[58:-16] + '\n'
			outfile.write(toWrite)