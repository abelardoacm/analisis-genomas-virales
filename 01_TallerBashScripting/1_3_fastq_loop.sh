#!/bin/bash

# Definir las variables
DIR_FASTQ="../data/"  # Actualiza la ruta al directorio que contiene los archivos FASTQ
ARCHIVOS_FASTQ=($(ls $DIR_FASTQ/*.fastq.gz))  # Lista de archivos FASTQ

# Bucle para procesar cada archivo FASTQ
for FASTQ in ${ARCHIVOS_FASTQ[@]}
do
    echo "Procesando archivo: $FASTQ"
    # Aquí puedes añadir los comandos para procesar el archivo FASTQ
done
