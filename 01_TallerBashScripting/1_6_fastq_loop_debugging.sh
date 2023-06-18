#!/bin/bash

set -x  # Habilitar la impresión de comandos

DIR_FASTQ="$1"
echo "DIR_FASTQ: $DIR_FASTQ"  # Imprimir el valor de DIR_FASTQ

# Función para procesar un archivo FASTQ
procesar_fastq() {
    local FASTQ="$1"
    echo "Procesando archivo: $FASTQ"
    # Aquí puedes añadir los comandos para procesar el archivo FASTQ
}

# Bucle para procesar cada archivo FASTQ
for FASTQ in "$DIR_FASTQ"/*.fastq.gz
do
    echo "FASTQ: $FASTQ"  # Imprimir el valor de FASTQ
    procesar_fastq "$FASTQ"
done

set +x  # Deshabilitar la impresión de comandos
