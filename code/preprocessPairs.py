#!/usr/bin/env python3

# preprocess_merged_pairs.py <input_fastq_from_flash>

import sys
import gzip
import io

outname = sys.argv[2]

with io.BufferedWriter(gzip.open(outname, 'wb'), buffer_size=2000000000) as outfile, io.BufferedReader(gzip.open(sys.argv[1], 'rb'), buffer_size=8000000000) as file:

	while True:

		header = file.readline().decode('UTF-8')
		if not header:
			break
		header = header.strip().split(' ')[0]
		
		sequence = file.readline().decode('UTF-8').strip()
		filter = file.readline().decode('UTF-8')
		phred = file.readline().decode('UTF-8').strip()
        
		if len(sequence[58:-16]) >= 25: 
			toWrite = header + ":" + sequence[0:20] + '\n' + sequence[58:-16] + '\n' + filter + phred[58:-16] + '\n'
			outfile.write(str.encode(toWrite))