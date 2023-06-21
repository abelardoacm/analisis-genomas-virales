## **SPAdes**

### **Introducción a SPAdes**
SPAdes (St. Petersburg genome assembler) es un programa de software que se utiliza para el ensamble de novo de genomas bacterianos, aunque también ha demostrado ser efectivo en el ensamble de genomas virales con alta variabilidad. Trabaja tanto con lecturas de secuenciación de longitud corta (como las generadas por Illumina) como con lecturas de longitud media a larga (como las generadas por PacBio o Oxford Nanopore).

SPAdes se basa en algoritmos de ensamble de novo que utilizan una combinación de técnicas, incluyendo ***De Bruijn Graphs***  y técnicas de mapeo de lecturas.

SPAdes tiene una amplia gama de opciones y parámetros que se pueden ajustar para optimizar los resultados del ensamble. Por ejemplo, SPAdes puede realizar ensamblajes híbridos utilizando tanto lecturas de secuenciación de longitud corta como de longitud larga, lo que permite aprovechar las ventajas de ambos tipos de datos.

### **Etapas de SPAdes**


 * **Creación de gráficos de De Bruijn:** Para generar el gráfico de De Bruijn, SPAdes primero descompone las lecturas de secuenciación en k-mers y luego construye el gráfico de De Bruijn a partir de estos k-mers.

 * **Simplificación del gráfico:** SPAdes simplifica el gráfico de De Bruijn para reducir la complejidad del problema de ensamble.

     1. Eliminación de puntas: Las puntas son pequeñas ramas en el grafo que generalmente se deben a errores de secuenciación. Al eliminar estas puntas, SPAdes puede reducir el ruido en el grafo.

     2. Fusión de bulbos: Los bulbos son estructuras en el grafo que se forman debido a variaciones menores en la secuencia. Al fusionar estos bulbos en una sola ruta, SPAdes puede reducir la complejidad del grafo.

     3. Compresión de caminos: Cuando hay una serie de nodos en el grafo que todos tienen un solo predecesor y un solo sucesor, pueden comprimirse en un solo nodo. Esto puede reducir significativamente el tamaño del grafo.

     4. Resolución de repeticiones: Las repeticiones son secuencias que aparecen más de una vez en el genoma y pueden causar problemas en el ensamblaje ya que crean múltiples rutas posibles a través del grafo. SPAdes utiliza varias técnicas para tratar de resolver estas repeticiones y elegir la ruta más probable.

 * **Ensamblaje del genoma:** Finalmente, SPAdes utiliza el gráfico de De Bruijn simplificado para generar los contigs del ensamble. Este proceso implica la identificación de caminos a través del gráfico que representan secuencias genómicas probables. 

Es importante destacar que SPAdes utiliza un enfoque multi-k-mer en el que se crean y procesan varios gráficos de De Bruijn con diferentes valores de k. Esto permite a SPAdes manejar más efectivamente las variaciones en la cobertura de secuenciación y las regiones repetitivas en el genoma.

### **Práctica: Uso de SPAdes para el ensamblaje de novo**

    DETOUR: Como muchas herramientas bioinformáticas, para instalarlas en nuestras computadoras personales podemos recurrir a conda Si necesitas instalar SPAdes en tu computadora, podrás hacerlo con el siguiente comando: `$ conda install -c bioconda spades`

Una vez instalado, la ejecución de SPAdes es sencilla. En nuestro caso, que tenemos muestras pareadas, simplemente tenemos que usar ambos archivos como argumento e indicar el directorio de salida. Pero antes...

:::{note}
PREGUNTA: Supón que nuestro objetivo último es lograr secuenciar y ensamblar de novo el genoma de SARS CoV-2, y al equipo de bioinformática llegan dos tipos de muestras. En el primero el proceso experimental simplemente consistió en aislamiento de material genético, amplificación y secuenciación. El segundo consistió en lo mismo, excepto que con una eficiente metodología para amplificar selectiva y drásticamente el material genético, únicamente de nuestro virus de interés. ¿Cómo podría impactar ello en el proceso de ensamble?.
:::

Ejecutaremos el siguiente comando para la muestra 1, recuerda ajustar las rutas:

```bash
spades.py -1 sample1_R1.fastq.gz -2 sample1_R2.fastq.gz -o ./spades_out/
```


### ** Interpretación de los resultados de SPAdes**

Después de ejecutar SPAdes, se generará un directorio de salida (que especificaste con la opción `-o` en el comando de SPAdes). Dentro de este directorio, encontrarás una serie de archivos y subdirectorios que contienen los resultados del ensamblaje de SPAdes.

#### 1. `contigs.fasta` y `scaffolds.fasta`

Estos dos archivos contienen los contigüidades (contigs) y ensambles finales (scaffolds) resultantes del ensamblaje.

- Los `contigs` son secuencias que SPAdes ha ensamblado a partir de las lecturas. Son los bloques de construcción básicos del genoma.

- Los `scaffolds` son conjuntos de contigs que se han unido con la ayuda de las lecturas pareadas. Los scaffolds pueden contener regiones de "N" que representan gaps o regiones desconocidas entre los contigs.

#### 2. `spades.log`

Este archivo contiene el registro de la ejecución de SPAdes. Proporciona información detallada sobre cada etapa del proceso de ensamblaje. 

#### 3. Carpeta `KXX`

Esta carpeta contiene los resultados intermedios de las distintas etapas del ensamblaje. SPAdes realiza múltiples iteraciones de ensamblaje utilizando diferentes longitudes de k-mers. Cada una de estas iteraciones tiene su propia carpeta, llamada `KXX`, donde `XX` es la longitud del k-mer utilizado.

#### 4. `params.txt`

Este archivo muestra los parámetros y opciones que se utilizaron para ejecutar SPAdes.

---

Para interpretar los resultados de SPAdes, podríamos comenzar por revisar los archivos `contigs.fasta` y `scaffolds.fasta`,contar el número de contigs/scaffolds, y también puedes calcular su longitud total y la longitud del contig o scaffold más largo. 

Un análisis más detallado requerirá herramientas bioinformáticas adicionales. Por ejemplo, podrías utilizar BLAST para comparar tus contigs o scaffolds con secuencias de referencia conocidas, o podrías utilizar una herramienta de visualización de genomas como Bandage para examinar visualmente el grafo de ensamblaje.


