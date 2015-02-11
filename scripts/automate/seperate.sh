#!/bin/bash

for i in kak*.fq
do
   /usr/local/share/khmer/scripts/extract-paired-reads.py $i
   name=$(basename $i .fq)
   mv ${name}.fq.pe ${name}.pe.fq
   mv ${name}.fq.se ${name}.se.fq
done
