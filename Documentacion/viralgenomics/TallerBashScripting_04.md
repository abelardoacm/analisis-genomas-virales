## Debugging y solución de problemas en Bash Scripting

El proceso de ***debugging*** **/depuración** , se refiere al proceso de identificar y corregir errores o fallas en un script, para solucionar errores o comportamientos inesperados.

Este (usualmente tedioso) proceso implica: identificar el problema, reproducirlo de manera consistente, utilizar herramientas de depuración, agregar registros (*logging*) para monitorear puntos clave, probar soluciones y verificar si  no se introdujeron nuevos errores.

### **Métodos sencillos**

Aunque en grandes proyectos de código, el proceso suele llevarse a cabo por especialistas, algunas herramientas sencillas pueden ser útiles para nuestras tareas.

 * **`echo`**: Para imprimir el valor de una variable o proceso conflictivo.
 * **`-x`**: Al ejecutar un script con `bash -x script.sh`, Bash imprimirá cada comando antes de ejecutarlo, permitiendo así monitorear qué procesos están fallando.
 * **`set -x/set +x`**: Dentro del script, la depuración puede habilitarse con `set -x` en una región, y deshabilitarse en otra con `set +x`.

Por ejemplo, este es un script que hemos implementado anteriormente, con opciones de *debugging* habilitados:

```bash
#!/bin/bash

set -x  # Habilitar la impresión de comandos

DIR_FASTQ="$1"
echo "DIR_FASTQ: ${DIR_FASTQ}"  # Imprimir el valor de DIR_FASTQ

# Función para procesar un archivo FASTQ
procesar_fastq() {
    local FASTQ="$1"
    echo "Procesando archivo: ${FASTQ}"
    # Aquí puedes añadir los comandos para procesar el archivo FASTQ
}

# Bucle para procesar cada archivo FASTQ
for FASTQ in "${DIR_FASTQ}"/*.fastq.gz
do
    echo "FASTQ: ${FASTQ}"  # Imprimir el valor de FASTQ
    procesar_fastq "${FASTQ}"
done

set +x  # Deshabilitar la impresión de comandos
```

