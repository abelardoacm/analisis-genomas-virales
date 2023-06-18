#!/bin/bash

# directorio de entrada
DIR_ENTRADA="$1"

# Validar la entrada
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 /ruta/a/directorio" >&2
    exit 1
fi

# Ejecutar FastQC en todos los archivos FASTQ del directorio
fastqc $DIR_ENTRADA/*.fastq.gz

# Generar informe de MultiQC
multiqc $DIR_ENTRADA -o $DIR_ENTRADA/multiqc_report
