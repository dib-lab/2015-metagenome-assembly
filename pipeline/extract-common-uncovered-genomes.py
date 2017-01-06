#! /usr/bin/env python
import argparse

import numpy
import screed
import sys
from collections import defaultdict


def load_reference(filename, genomes):
    
    for record in screed.open(filename):
	if record.name in genomes:
		fp = open(record.name, 'w')
		print >> fp, '>' + record.name
		print >> fp, record.sequence 
  


def main():
    genomes = {'Shewanella_baltica_OS223,', 'Fusobacterium_nucleatum_subsp._nucleatum_ATCC_25586', 'Desulfovibrio_vulgaris_DP4', 'Enterococcus_faecalis_V583', 'Thermus_thermophilus_HB27' }
    load_reference('mircea.fa', genomes)   

if __name__ == '__main__':
   main() 
