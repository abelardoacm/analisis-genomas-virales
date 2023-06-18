## Conceptos clave en Bash Scripting:

### **Variables en Bash scripting**

Las variables son espacios de memoria que reservamos para almacenar valores. Puedes pensar en una variable como un contenedor o una etiqueta con un nombre. Estos nombres sin embargo tienen algunas reglas. En Bash son sensibles a las mayúsculas y minúsculas, y no pueden comenzar con un dígito. La sintáxis de asignación es similar a otros lenguajes, ya que usamos el operador `=`. Por ejemplo, `x=10` asigna el valor 10 a la variable `x`. Para referirse al valor de una variable, se utiliza el símbolo `$`. Por ejemplo, `echo $x` imprimirá el valor de `x`.

### **Uso de estructuras de control y bucles**

Los bucles y las estructuras de control permiten ejecutar bloques de código de forma condicional o repetitiva. La estructura `if-else` permite ejecutar bloques de código si se cumple una determinada condición. Por ejemplo, al ejecutar:

```bash
x=8
```

```bash
  if [ $x -gt 5 ]
  then
      echo "x es mayor que 5"
  else
      echo "x no es mayor que 5"
  fi
```

y también se pueden usar en combinación con los símbolos `[]` 

```bash
if [ $x -gt 1 ] && [ $x -lt 10 ]; then
    echo "El número está entre 1 y 10."
fi
```
* Otras opciones son:
    * `eq`: Compara si dos valores son iguales.
    * `-lt`: Compara si un valor es menor que otro.
    * `-le`: Compara si un valor es menor o igual que otro.
    * `-ne`: Compara si dos valores no son iguales.
    * `-ge`: Compara si un valor es mayor o igual que otro.
    * `-z`: Comprueba si una cadena de texto está vacía.
    * `-n`: Comprueba si una cadena de texto no está vacía.
    * `==`: Compara si dos cadenas de texto son iguales (solo disponible en versiones más recientes de Bash).

Los bucles `for` y `while` permiten ejecutar bloques de código varias veces. Por ejemplo, el siguiente bucle `for` imprimirá los números del 1 al 5:

  ```bash
  for i in {1..5}
  do
      echo $i
  done
  ```

Por otra parte, un bucle `while` se ejecutará mientras se cumpla una determinada condición. Por ejemplo, el siguiente bucle `while` también imprimirá los números del 1 al 5:

  ```bash
  i=1
  while [ $i -le 5 ]
  do
      echo $i
      ((i++))
  done
  ```

### **Conceptos de entrada y salida estándar (stdin, stdout, stderr) y cómo se redirigen**

`stdin`, `stdout` y `stderr` son los tres flujos de datos que todo proceso en un sistema ***Unix*** tiene por defecto. 
  
* `stdin` (entrada estándar) es el flujo desde el que el proceso lee su entrada.
* `stdout` (salida estándar) es el flujo hacia el que el proceso escribe su salida.
* `stderr` (error estándar) es el flujo hacia el que el proceso escribe sus mensajes de error.

Estos flujos pueden redirgirse usando los operadores `>` y `>>` para la salida y el error estándar, y `<` para la entrada estándar. Por ejemplo, el comando `echo "hola" > archivo.txt` redirigirá la salida estándar del comando `echo` a `archivo.txt`. Si `archivo.txt` ya existe, será sobrescrito. Si quieres agregar la salida al final del archivo en lugar de sobrescribirlo, puedes usar el operador `>>`.

Para redirigir el error estándar, puedes usar `2>`. Por ejemplo, `ls /noexiste 2> error.txt` redirigirá el error estándar del comando `ls` a `error.txt`.

Por ejemplo, con el siguiente código podemos redirigir `stdout` la salida estándar del comando echo y crear una lista de virus en un archivo llamado **virus.txt**.

```bash
echo -ne "HIV\nEbola\nZika\nHepatitis_C\nDengue\nSARS\nMERS-CoV" > virus.txt
```

Y posteriormente hacer un script que procese el contenido de **virus.txt** ingresándolo desde la entrada estándar `stdin`.

```bash
#!/bin/bash

while read -r nombre
do
    echo "Nombre de virus: $nombre"
done < virus.txt
```


**Ejemplo de Bash Scripting con datos de secuenciación de genomas virales:**

Modifica y ejecuta el siguiente ejemplo de script para procesar archivos ***FASTQ*** de secuenciación

```bash
#!/bin/bash

# Definir las variables
DIR_FASTQ="/ruta/a/directorio/con/fastq"  # Actualiza la ruta al directorio que contiene los archivos FASTQ
ARCHIVOS_FASTQ=($(ls $DIR_FASTQ/*.fastq.gz))  # Lista de archivos FASTQ

# Bucle para procesar cada archivo FASTQ
for FASTQ in ${ARCHIVOS_FASTQ[@]}
do
    echo "Procesando archivo: $FASTQ"
    # Aquí puedes añadir los comandos para procesar el archivo FASTQ
done
```

Este script recorrerá todos los archivos FASTQ en el directorio especificado y ejecutará los comandos dentro del for loop uno a la vez.

