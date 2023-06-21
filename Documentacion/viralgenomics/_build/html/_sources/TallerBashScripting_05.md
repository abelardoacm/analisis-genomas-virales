## Scripts interactivos

Una práctica común en la bioinformática, será el dotar a nuestros scripts la capacidad de interactuar con el usuario para obtener información en tiempo de ejecución. Esto puede ser para guiarlo en la ejecución a través de instrucciones, o para obtener datos de usuario que cambian en cada uso de nuestro script.

### **`read`**

El comando read en Bash se utiliza para capturar la entrada del usuario desde `stdin` y le asigna una variable. 

Por ejemplo, podemos hacer una versión interactiva de nuestro script anterior:

```bash
#!/bin/bash

# Solicitar al usuario que introduzca la ruta al directorio con los archivos FASTQ
echo "Por favor, introduce la ruta al directorio con los archivos FASTQ:"
read DIR_FASTQ

# Verificar que el directorio proporcionado existe
if [ ! -d "${DIR_FASTQ}" ]; then
    echo "El directorio proporcionado no existe: ${DIR_FASTQ}" >&2
    exit 1
fi

# Función para procesar un archivo FASTQ
procesar_fastq() {
    local FASTQ="$1"
    echo "Procesando archivo: ${FASTQ}"
    # Aquí puedes añadir los comandos para procesar el archivo FASTQ
}

# Bucle para procesar cada archivo FASTQ
for FASTQ in "${DIR_FASTQ}"/*.fastq.gz
do
    procesar_fastq "${FASTQ}"
done
```

Este script solicita al usuario que introduzca la ruta al directorio con archivos FASTQ, y luego utiliza esa ruta para leerlos. Si el directorio proporcionado no existe, el script imprime un mensaje de error y termina. 

Esto es un ejemplo de cómo un script interactivo puede recoger datos del usuario y adaptarse en consecuencia.

### Argumentos y parámetros

Al invocar un script desde la línea de comandos, podemos pasar argumentos a nuestro script, es decir, acompañar al comando de ejecución con otras cadenas de texto, que pasen a guardarse en variables utilizadas en el script. Estos argumentos son accesibles para el script mediante variables especiales o posicionales $1, $2, $3, etc., donde $1 se refiere al primer argumento, $2 al segundo, y así sucesivamente. Por ejemplo, en el comando ./script.sh argumento1 argumento2, dentro de script.sh, $1 tendría el valor argumento1 y $2 tendría el valor argumento2.

De esta forma podemos utilizar un script una y otra vez con diferentes parámetros, simplemente cambiando los argumentos posicionales.

El siguiente script define las variables con las que opera a partir de argumentos posicionales. 



```bash
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

if [ ! -f "${FASTQ}" ]; then
    echo "El archivo FASTQ proporcionado no existe: ${FASTQ}" >&2
    exit 1
fi

# Subset
seqtk sample -s100 ${FASTQ} ${NSUBMUESTRA} > ${OUTPUT}
```

**NOTA:¿Cómo podrías dotar al script la capacidad de operar con argumentos posicionales cuando estos son declarados, o mediante `user input stdin` con `read` cuando se da el caso de que no están definidds**

