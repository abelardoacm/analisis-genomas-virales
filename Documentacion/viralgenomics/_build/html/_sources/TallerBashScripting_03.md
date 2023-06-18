## Buenas prácticas en Bash Scripting

### **Comentarios y documentación de scripts**

Los comentarios son una parte integral de cualquier script y sirven para explicar lo que el código está haciendo. Los comentarios en los scripts de Bash se hacen utilizando el símbolo `#`. Todo lo que esté después de este símbolo en la misma línea será ignorado por el intérprete.

También es una buena práctica documentar tu script al comienzo, proporcionando información como la descripción del script, los argumentos que necesita, cómo se usa, la fecha de creación, el autor y cualquier otra información relevante.

### **Cómo estructurar scripts de manera eficiente y legible**

  Para hacer que los scripts sean más legibles y eficientes, puedes:

  1. **Usar indentación**: Las estructuras de control como los bucles y las declaraciones if-then-else deben hacer uso de espacios vacíos al inicio de las líneas para identificar bloques de código de un mismo nivel jerárquico.

  2. **Evitar la repetición**: Cuando varios bloques se repiten, seule ser mejor poner ese bloque en una función.

  3. **Nombres de variables significativos**: Los nombres de las variables deben ser descriptivos de los datos que almacenan, dando pistas sobre su identidad y su relación con otras variables.

### **Seguridad y manejo de errores en scripts de Bash**

Esto cobra particular importancia cuando se trabaja con volúmenes grandes de información que puedan perderse o sobreescribirse, o con scripts que modificarán el sistema de alguna manera.
  
* Algunas prácticas recomendadas para la seguridad en Bash son:
    * Utilizar la opción `set -e` al comienzo de tus scripts. Esto hace que el script se detenga tan pronto como ocurra un error.
    * Validar los datos de entrada antes de usarlos en tu script.
    * Utilizar las comillas dobles al referirse a las variables para evitar problemas con los espacios en blanco y los caracteres especiales.

El siguiente script de Bash es una modificación del anterior que pretende seguir las buenas prácticas.

```bash
#!/bin/bash
# Script para procesar archivos FASTQ
# Argumentos: Ruta al directorio con los archivos FASTQ
# Uso: ./procesar_fastq.sh /ruta/a/directorio
# Autor: ATGenomics
# Fecha: 66/66/6666

set -e  # Detener el script si ocurre un error

# Validar los datos de entrada
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 /ruta/a/directorio" >&2
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
```

- [x] Comentarios
- [x] Documentación
- [x] Indentación
- [x] Funciones
- [x] Validación
- [x] Nombres descriptivos

aunque sin seguir las pautas también podría verse así...

```bash
#!/bin/bash
a=$1
b=($(ls $a/*.fastq.gz))
for c in ${b[@]}
do
echo $c
done
```

