#!/bin/bash

# Archivo de entrada FASTQ, archivo de salida y umbral de calidad
FASTQ="$1"
OUTPUT="$2"
NSUBMUESTRA="$3"

# Validar la entrada
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 archivo.fastq salida.fastq calidad" >&2
    exit 1
fi

if [ ! -f "$FASTQ" ]; then
    echo "El archivo FASTQ proporcionado no existe: $FASTQ" >&2
    exit 1
fi

# Subset
seqtk sample -s100 $FASTQ $NSUBMUESTRA > $OUTPUT
