#!/bin/bash

# Solicitar al usuario que introduzca la ruta al directorio con los archivos FASTQ
echo "Por favor, introduce la ruta al directorio con los archivos FASTQ:"
read DIR_FASTQ

# Verificar que el directorio proporcionado existe
if [ ! -d "$DIR_FASTQ" ]; then
    echo "El directorio proporcionado no existe: $DIR_FASTQ" >&2
    exit 1
fi

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
