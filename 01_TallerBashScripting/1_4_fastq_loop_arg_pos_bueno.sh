#!/bin/bash
# Script para procesar archivos FASTQ
# Argumentos: Ruta al directorio con los archivos FASTQ
# Uso: ./procesar_fastq.sh /ruta/a/directorio
# Autor: ATGenomics
# Fecha: 66/66/6666

set -e  # Detener el script si ocurre un error

# Validar los datos de entrada
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 ruta/a/directorio_fastq" >&2
    exit 1
fi

DIR_FASTQ="$1"

# Función para procesar un archivo FASTQ
procesar_fastq() {
    local FASTQ="$1"
    echo "Procesando archivo: $FASTQ"
    # Aquí puedes añadir los comandos para procesar el archivo FASTQ
}

# Bucle para procesar cada archivo FASTQ
for FASTQ in "$DIR_FASTQ"/*.fastq.gz
do
    procesar_fastq "$FASTQ"
done
