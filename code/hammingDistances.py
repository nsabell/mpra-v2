#!/usr/bin/env python

import sys
import os
import numpy as np
import scipy as sp
import random

def hamming(s1, s2):

	assert len(s1) == len(s2)
	return sum(ch1 != ch2 for ch1, ch2 in zip(s1,s2))

def main():

	barcodes = list()
	distances = list()

	random.seed(1)

	with open('test.txt', 'r') as file:

		for line in file:

			if random.random() <= 0.1:

				line = line.strip().split()

				if barcodes:

					print barcodes

					for barcode in barcodes:

						dist = hamming(barcode, line[1])
						distances.append(dist)
						barcodes.append(line[1])

				else:

					barcodes.append(line[1])

		print barcodes
		print distances

if __name__== "__main__":
	main()
