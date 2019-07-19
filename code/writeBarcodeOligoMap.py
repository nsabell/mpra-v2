#!/usr/bin/env python

# Nathan Abell
# Montgomery Lab
# Stanford University

import sys

mapping = {}
counter = 0

with open(sys.argv[1], 'r') as file:

	for line in file:

		counter += 1
		if counter % 1000000 == 0:
			print(str(counter) + " potential pairings processed.")
			sys.stdout.flush()

		line = line.strip().split()

		barcode = line[0]
		oligo = line[1]
		numAlign =int(line[2])
		alignScore = int(line[3])
		mismatches = int(line[4])

		if alignScore < 100:
			print("skipped for align score: " + str(alignScore) + " " + barcode)
			continue

		if mismatches > 5:
			print("skipped for mismatches: " + str(mismatches) + " " + barcode)
			continue

		if  mapping.has_key(barcode):

			mapping[barcode][2] += 1

			if oligo not in mapping[barcode][0]:
				mapping[barcode][0].append(oligo)
				mapping[barcode][1] += 1

		else:
			mapping[barcode] = [[oligo], 1, 1]

with open(sys.argv[2], 'w') as file:
	for key in mapping.keys():
		file.write(key + "\t" + ",".join(mapping[key][0]) + "\t" + str(mapping[key][1]) + "\t" + str(mapping[key][2]) + "\n")










