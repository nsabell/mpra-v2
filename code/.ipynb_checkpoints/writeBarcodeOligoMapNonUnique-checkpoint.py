#!/usr/bin/env python3

import sys

mapping = {}
counter = 0

# Open nonunique file and stream through it
with sys.stdin as file, open(sys.argv[1],'w') as outfile:

	while True:

		index = -1

		line = file.readline()
		if not line: break

		line = line.strip().split()
		readName = line[0]
		
		flags = [int(line[1])]
		oligos = [line[2]]
		alignCounts = [int(line[3])]
		alignScores = [int(line[4])]
		mismatchCounts = [int(line[5])]

		for i in range(0,alignCounts[0] - 1):

			newLine = file.readline()
			newLine = newLine.strip().split()

			flags.append(int(newLine[1]))
			oligos.append(newLine[2])
			alignCounts.append(int(newLine[3]))
			alignScores.append(int(newLine[4]))
			mismatchCounts.append(int(newLine[5]))

		# Salvage cases where the reverse complement is present and reverse marked primary
		if set([16,256]) == set(flags) and flags.count(16) == 1:
			index = flags.index(16)

		# Salvage cases where the reverse complement is present and forward marked primary
		elif set([0,272]) == set(flags) and flags.count(272) == 1:
			index = flags.index(272)

		# Salvage cases where there is a unique maximum score among the alignments
		elif alignScores.count(max(alignScores)) == 1:
			index = alignScores.index(max(alignScores))

		# Format and write output setting the align count to 1 but preserving score and mismatch count
		if index != -1:
			barcode = readName.split(":")[7]
			oligo = oligos[index]
			alignCount = alignCounts[index]
			alignScore = alignScores[index]
			mismatchCount = mismatchCounts[index]
			
			if alignScore >= 100 and mismatchCount <= 5:
				toWrite = barcode + "\t" + oligo + "\n"
				outfile.write(toWrite)

# 		else:
# 			print("Not used: " + "\t".join(line))











