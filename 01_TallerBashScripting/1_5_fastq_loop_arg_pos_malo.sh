#!/bin/bash
a=$1
b=($(ls $a/*.fastq.gz))
for c in ${b[@]}
do
echo "Procesando archivo: $c"
done
