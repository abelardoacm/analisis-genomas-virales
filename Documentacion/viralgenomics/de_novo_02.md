## **SKESA**

SKESA es una herramienta para el ensamblaje de genomas microbianos que utiliza ***De Bruijn Graphs*** a través de métodos heurísticos conservadores, es decir, conjuntos de parámetros o presuntos empíricos que han demostrado su efectividad para el ensamblaje de genomas. (pero que pueden no ser óptimas en todos los casos).

SKESA está diseñado para crear interrupciones en las regiones repetitivas del genoma. Una forma de entenderlo es pensar que, cuando SKESA "crea interrupciones" en estas regiones repetitivas, está optando por romper los contigs en estos puntos en lugar de adivinar cómo se deben ensamblar las repeticiones. 

Esto nos permite acoplarlo a un análisis efectuado por un GFA (Graphical Fragment Assembly), un análisis posterior a SKESA que nos permite tomar los contigs y conectarlos para poder darnos una idea de la estructura del genoma.

Y finalmente, pero no menos importante, SKESA es un algoritmo de ensamblaje muy eficiente que puede ensamblar genomas rápidamente, incluso en computadoras con recursos limitados.

### **Otras particularidades de SKESA**

 * **Extracción de k-mers conservadores:** SKESA utiliza una estrategia conservadora de extracción de k-mers (identificando aquellos k-mers que son soportados por un número suficiente de lecturas), para minimizar la inclusión de k-mers que pueden ser el resultado de errores de lectura. Esto ayuda a reducir el ruido en el Grafo de Bruijn

 * ***Branch and bound***: Es una estrategia que implica dividir un gran problema en sub problemas. En el caso del ensamblaje de novo, el problema más grande podría ser ensamblar todo el genoma, y los subproblemas podrían ser ensamblar regiones individuales del genoma. SKESA crea estos subproblemas al dividir el grafo de k-mers en puntos donde el grafo se bifurca, es decir, en puntos donde una secuencia de k-mers podría extenderse de varias maneras diferentes.  En el caso del ensamblaje de novo, la "calidad" de un ensamblaje podría ser medida en términos de su longitud (queremos ensamblajes más largos) y la exactitud de la secuencia (queremos secuencias que sean fieles a la secuencia original). Si una solución parcial (por ejemplo, un ensamblaje de una sola región del genoma) ya es de menor calidad que la mejor solución completa que se ha encontrado hasta ahora, entonces no tiene sentido continuar extendiendo esa solución parcial, y se puede descartar.

### **Práctica: Uso de SKESA para el ensamblaje de novo**

Para esta demostración, vamos a recurrir a los archivos con los que hemos trabajado (FASTQ), que son nuestras lecturas de secuenciación de Illumina. Recuerda, estos son archivos paired-end, lo que significa que cada par de lecturas proviene de ambos extremos de un fragmento de material genético.

    DETOUR: Como muchas herramientas bioinformáticas, para instalarlas en nuestras computadoras personales podemos recurrir a conda Si necesitas instalar SKESA en tu computadora, podrás hacerlo con el siguiente comando: `$ conda install -c bioconda skesa`

Una vez que tenemos instalado SKESA en nuestro sistema, este puede ejecutarse de manera sencilla (para una muestra) utilizando el siguiente comando:

```bash
skesa --fastq sample1_R1.fastq.gz,sample1_R2.fastq.gz --use_paired_ends --contigs_out ../skesa_test/sample1_contigs.fasta
```

Mientras el análisis termina de ejecutarse, veamos qué significan algunos mensajes:

 * ***Seed kmers:*** Este es el número de k-mers semilla utilizados para comenzar el proceso de ensamblaje. Un valor de 0 significa que no se especificaron k-mers semilla en particular y que SKESA generó sus propios k-mers semilla a partir de las lecturas.

 * ***Cleaned reads:*** Este es el número de lecturas después de la limpieza, que implica eliminar lecturas de baja calidad y adaptadores.

 * ***Reads for connection:*** Este es el número de lecturas que se utilizarán para conectar contigs durante el ensamblaje.

 * ***Internal reads:*** Este es el número de lecturas que se utilizan para la construcción interna del gráfico de ensamblaje. 

 * ***Kmer len:*** Este es el tamaño del k-mer que SKESA está utilizando para cada paso del ensamblaje.

 * ***Raw kmers:*** Este es el número de k-mers crudos extraídos de las lecturas.

 * ***Distinct kmers:*** Este es el número de k-mers distintos después de eliminar los k-mers duplicados.

 * ***Graph size:*** Este es el tamaño del gráfico de ensamblaje después de este paso. En tu caso, el tamaño del gráfico es de 3190404.

 * ***Contigs in:*** Este es el número de contigs que se han ensamblado hasta ahora.

 * ***Valley:*** Este valor se refiere a la profundidad del valle más profundo en el histograma de cobertura de k-mer. Un valor de 0 significa que no se encontró ningún valle profundo, lo que puede indicar que no hay mucha redundancia en las lecturas.

 * ***Kmers in multiple/single contigs:*** Este valor muestra el número de k-mers que aparecen en múltiples contigs y en un solo contig, respectivamente.

 * ***Genome:*** Este es el tamaño del genoma ensamblado hasta ahora.

 * ***N50:*** El valor N50 se calcula ordenando todos los contigs o secuencias de un ensamblaje de mayor a menor y sumando las longitudes de los contigs hasta que se llegue a la mitad del tamaño total del genoma. Un N50 más alto generalmente se interpreta como un ensamblaje de mayor calidad. El valor de N50 es la longitud del contig más corto en ese punto.. En tu caso, el valor N50 es de 3673.

 * ***L50:*** El valor L50 es el número mínimo de contigs cuyas longitudes suman al menos la mitad del tamaño total del genoma. En otras palabras, si ordenas los contigs de mayor a menor, el L50 es cuántos contigs tienes que sumar para llegar al 50% del tamaño total del genoma. Un valor L50 más bajo generalmente indica un mejor ensamblaje, ya que significa que menos contigs componen la mitad del tamaño del genoma. En tu caso, el valor L50 es de 5.

### **Interpretación de los resultados**

Los resultados de SKESA se generan en formato FASTA, que es uno de los formatos más comunes para almacenar información de secuencias de nucleótidos. Cada registro en un archivo FASTA se compone de una línea de descripción, seguida por líneas de secuencias de bases. La línea de descripción se distingue de la secuencia de bases por un carácter de mayor que (">") al inicio.

Un ejemplo de un archivo FASTA producido por SKESA podría verse así:

```
>contig00001 length=57291 numreads=54
ACCGGTTAA...
>contig00002 length=45121 numreads=23
GTTAACCG...
...
```
Después del nombre del contig, verás atributos adicionales. length es la longitud del contig, que representa el número de bases en la secuencia del contig. numreads es el número de lecturas que se han ensamblado para formar este contig.

Al interpretar estos resultados, es importante recordar que un número mayor de lecturas que contribuyen a un contig o una longitud de contig más larga no necesariamente implican que ese contig es más "importante" o "preciso". Estos son simplemente artefactos del proceso de ensamblaje y pueden estar sujetos a variaciones debido a diferencias en la cobertura de secuenciación, errores de secuenciación y variabilidad biológica.

En términos más generales, los resultados del ensamblaje de SKESA, al igual que cualquier ensamblaje de novo, deben ser interpretados en el contexto de la pregunta de investigación, y generalmente requieren pasos de análisis adicionales, como la anotación del genoma, para proporcionar información más detallada y biológicamente relevante.
