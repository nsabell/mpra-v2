#!/usr/bin/env python

# Nathan Abell
# Montgomery Lab
# Stanford University

import sys

oligoMap = {}
barcodeCounts = {}
oligoSums = {}

with open(sys.argv[1], 'r') as file:

	for line in file:

		line = line.strip().split()

		if int(line[2]) == 1:
			barcode = line[0]
			oligo = line[1]
			oligoMap[barcode] = oligo

with open(sys.argv[2], 'r') as file:

	for line in file:
		
		line = line.strip().split()
		count = int(line[0])
		barcode = line[1]
		barcodeCounts[barcode] = count

for key in barcodeCounts:

	if oligoMap.has_key(key):
		
		oligo = oligoMap[key]

		if oligoSums.has_key(oligo):
			oligoSums[oligo][0] += barcodeCounts[key]
			oligoSums[oligo][1] += 1
		else:
			oligoSums[oligo] = [barcodeCounts[key], 1]

with open(sys.argv[3], 'w') as file:
	for key in oligoSums:
		toWrite = key + "\t" + str(oligoSums[key][0]) + "\t" + str(oligoSums[key][1]) + "\n"
		file.write(toWrite)


