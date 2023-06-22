 ## **Asignación taxonómica**

La asignación taxonómica es el proceso de clasificar y etiquetar secuencias genéticas en función de su similitud con secuencias de referencia previamente identificadas. Se utiliza para determinar a qué taxón o categoría taxonómica (como especie, género, familia, etc.) pertenece una secuencia desconocida. La asignación taxonómica es fundamental en la metagenómica y la metagenómica viral, ya que permite identificar los organismos o virus presentes en una muestra.

Los perfiles taxonómicos son representaciones de la composición de una muestra metagenómica. Estos perfiles indican las proporciones relativas de diferentes grupos taxonómicos presentes en la comunidad microbiana o viral. 

Usualmente, la asignación taxonómica y la generación de perfiles taxonómicos se basaa en algoritmos y bases de datos que contienen información taxonómica y secuencias de referencia.

## **MetaPhlAn**

MetaPhlAn (Metagenomic Phylogenetic Analysis) es una herramienta bioinformática ampliamente utilizada para el análisis taxonómico de datos metagenómicos. MetaPhlAn permite determinar la composición taxonómica de una muestra metagenómica utilizando secuencias de marcadores genéticos conservados presentes en los genomas.

![Figura 1](https://huttenhower.sph.harvard.edu/wp-content/uploads/2020/12/metaphlan3_starred-300x214.png)

El funcionamiento de MetaPhlAn se basa en la construcción de un perfil taxonómico utilizando un conjunto de marcadores génicos seleccionados que se encuentran en múltiples genomas. Estos marcadores son secuencias cortas y conservadas que se utilizan como "huellas digitales" para identificar y clasificar organismos.

El proceso típico de análisis con MetaPhlAn consta de los siguientes pasos:

    Preparación de los datos: Las secuencias metagenómicas se someten a un proceso de preprocesamiento, que incluye la eliminación de secuencias de baja calidad y adaptadores.

    Mapeo de secuencias: Las secuencias preprocesadas se comparan con una base de datos de marcadores genéticos utilizando un algoritmo de alineamiento eficiente. MetaPhlAn utiliza el programa Bowtie2 para realizar este paso.

    Cálculo de abundancias: MetaPhlAn asigna la abundancia relativa de cada taxón basada en la cantidad de secuencias que se alinean a los marcadores correspondientes. Utiliza un enfoque estadístico que tiene en cuenta las diferencias en la longitud y la variabilidad de los marcadores.

    Generación de perfiles taxonómicos: A partir de las abundancias asignadas a cada taxón, MetaPhlAn genera un perfil taxonómico que muestra la composición taxonómica de la muestra. Los perfiles se representan típicamente como un porcentaje de la abundancia relativa de cada taxón.

Es importante destacar que MetaPhlAn se basa en una estrategia de mapeo de secuencias cortas a marcadores genéticos, lo que permite una identificación rápida y eficiente de organismos microbianos en una muestra metagenómica. Sin embargo, debido a su enfoque basado en marcadores seleccionados, MetaPhlAn puede estar limitado en su capacidad para detectar y clasificar organismos que no posean los marcadores específicos utilizados en la base de datos, como la gran mayoría de los virus, incluso los ya conocidos.

```bash
metaphlan [opciones] archivo_entrada.fastq archivo_salida.txt
```

Al trabajar con virus utilizando MetaPhlAn, se pueden ajustar varias opciones y parámetros para adaptar el análisis a las características específicas de los virus. A continuación, se mencionan algunos de los principales parámetros y opciones que pueden ser útiles al trabajar con metagenómica viral:

    Base de datos de referencia: MetaPhlAn utiliza una base de datos de marcadores genéticos para realizar el mapeo y la asignación taxonómica. Para analizar datos virales, es importante asegurarse de utilizar una base de datos que contenga secuencias de virus. MetaPhlAn proporciona bases de datos específicas para virus, como "v20_m200" para la versión 20 de RefSeq con un umbral de longitud mínima de 200 nucleótidos.

    Ajustes de mapeo: Es posible ajustar los parámetros de mapeo utilizados por MetaPhlAn para mejorar la sensibilidad y especificidad del análisis. Estos incluyen opciones como la longitud mínima de coincidencia (--min_alignment_len) y la puntuación mínima de mapeo (--min_alignment_score).

    Umbral de detección: MetaPhlAn asigna abundancias relativas a los diferentes taxones detectados en la muestra. Se puede ajustar un umbral de detección (--bowtie2db) para limitar los resultados solo a aquellos taxones con abundancias superiores a un valor determinado.


## **Kraken2**
Kraken2 y MetaPhlAn son dos herramientas bioinformáticas ampliamente utilizadas para el análisis taxonómico de datos metagenómicos, pero difieren en su enfoque y funcionamiento. 

Kraken2 utiliza un enfoque basado en clasificación taxonómica utilizando k-mers, que son fragmentos cortos. En lugar de utilizar marcadores genéticos conservados, como en MetaPhlAn, Kraken2 asigna las secuencias metagenómicas a través de comparaciones de similitud con una base de datos taxonómica que contiene k-mers representativos de diferentes organismos.

El funcionamiento básico de Kraken2 implica los siguientes pasos:

    Construcción de la base de datos: Se genera una base de datos de k-mers a partir de secuencias genómicas de referencia de diferentes organismos. Esta base de datos contiene información taxonómica asociada a cada k-mer.

    Preprocesamiento de datos: Las secuencias metagenómicas se someten a un proceso de preprocesamiento similar al de MetaPhlAn, que incluye eliminación de adaptadores, filtrado de calidad y otras etapas de limpieza.

    Clasificación taxonómica: Kraken2 compara las secuencias preprocesadas con la base de datos de k-mers utilizando un algoritmo eficiente de búsqueda de similitud. Se asigna una categoría taxonómica a cada secuencia basada en la mejor coincidencia encontrada en la base de datos.

    Generación de informe de resultados: Kraken2 genera un informe que resume la composición taxonómica de la muestra, mostrando las proporciones relativas de los diferentes grupos taxonómicos presentes.

En cuanto al comando básico de ejecución de Kraken2, sería el siguiente:

```bash
kraken2 --db ruta_basedatos --report archivo_reporte.txt archivo_entrada.fastq
```