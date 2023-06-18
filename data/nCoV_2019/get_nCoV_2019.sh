#!/bin/bash

wget https://zenodo.org/record/3735111/files/nCoV-2019.artic.primers.fasta?download=1
wget https://zenodo.org/record/3735111/files/nCoV-2019.schemeMod.bed?download=1
wget https://zenodo.org/record/3735111/files/sample1_R1.fastq.gz?download=1
wget https://zenodo.org/record/3735111/files/sample1_R2.fastq.gz?download=1
wget https://zenodo.org/record/3735111/files/sample2_R1.fastq.gz?download=1
wget https://zenodo.org/record/3735111/files/sample2_R2.fastq.gz?download=1

ls -1 | grep '?download=1' | while read missname ; do mv $missname $(echo $missname |sed 's/\?download\=1//g') ; done
