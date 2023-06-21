## Control de calidad de lecturas

### **Sample dataset**

Los archivos con los que trabajaremos en este taller son archivos FASTQ, que cuentan con bloques de cuatro tipos de lineas:

 1. **Línea de encabezado**: comienza con un carácter '@' seguido de una identificación única para la secuencia y, a veces, información adicional, como los identificadores del instrumento de secuenciación y los números de corrida.

 2. **Línea de secuencia**: la secuencia de nucleótidos en sí, donde cada nucleótido se representa por un solo carácter (A para adenina, C para citosina, G para guanina, T para timina, N para cualquier base o una base que no se pudo determinar).
 
 3. **Línea separadora**: una línea que usualmente contiene solo el carácter '+' y, a veces, la misma información que la línea de encabezado.

 4. **Línea de calidad**: caracteres que representan la calidad de cada base en la línea de secuencia. La calidad se mide como un valor ASCII de desplazamiento, y un valor de calidad más alto indica una mayor confianza en la base correspondiente en la secuencia de nucleótidos. La calidad de las bases en los archivos FASTQ se determina mediante un valor conocido como PHRED score, que se mide en una escala logarítmica. 


Los archivos FASTQ que usaremos provienen de una secuenciación de Illumina. En este experimento, se utilizó un método llamado "enriquecimiento con amplicones" para aumentar la cantidad de material genético del virus SARS-CoV-2 en las muestras antes de la secuenciación.

Tenemos dos muestras, cada una con dos archivos FASTQ asociados. 

 * Los archivos de la muestra 1 son **sample1_R1.fastq.gz** y **sample1_R2.fastq.gz**, y los archivos de la muestra 2 son **sample2_R1.fastq.gz** y **sample2_R2.fastq.gz**. 
 * Los archivos **R1** contienen la primera lectura de cada par de lecturas secuenciadas, y los archivos **R2** contienen la segunda lectura de cada par. Estos son lo que se conoce como lecturas paired-end, lo que significa que cada fragmento de RNA fue secuenciado desde ambos extremos. En el caso de los genomas virales, puede ayudar con ciertos tipos de análisis, como la identificación de variantes o la interpretación de la estructura del genoma.

Además de los archivos FASTQ, también tenemos dos archivos adicionales que nos proporcionan información sobre los primers que se utilizaron en el experimento de enriquecimiento con amplicones. 

 * Los archivos **nCoV-2019.artic.primers.fasta** y **nCoV-2019.schemeMod.bed** contienen las secuencias de los primers y las ubicaciones de los cebadores en el genoma del virus SARS-CoV-2, respectivamente.

**NOTA: En muchos escenarios, al trabajar con dato de secuenciación nuestra primer labor bioinformática será la remoción de adaptadores. Estas son pequeñas secuencias de DNA/RNA que se ligan a los extremos de las cadenas a secuenciar. Estos proporcionan sitios de unión a los primers y están diseñados para facilitar la unión de las moléculas a la superficie de la plataforma. En análisis más elaborados, estps adaptadores pueden contener secuencias muy específicas que permitan hacer **multiplexing**, es decir, mezclar múltiples muestras en un sólo experimento de secuenciación y distinguirlas *a posteriori*.**

Remover los adaptadores es una tarea sencilla que puede realizarse con ***`cutadapt`***. Por ejemplo:

```bash
cutadapt -a ADAPTER_SEQUENCE -o output.fastq input.fastq
```

O para archivos ***paired-end*** (como los nuestros), En este tipo de secuenciación, ambos extremos de cada fragmento de DNA/RNA se secuencian, típicamente para obtener una mayor resolución de la secuencia y para poder identificar reordenamientos y deleciones que pueden no ser evidentes con la secuenciación de un solo extremo. **Esta es la técnica de secuenciación más común al trabajar con genomas virales.**

```bash
# Remocion de adaptadores en muestras paired-end
cutadapt -a ADAPTER1 -A ADAPTER2 -o trimmed_R1.fastq -p trimmed_R2.fastq input_R1.fastq input_R2.fastq
```
Y finalmente para ***multiplex*** podemos ingresar un listado de adaptadores `adapters.fa` con el siguiente comando:

```bash
cutadapt -q 20 -a file:adapters.fa -o output.fastq input.fastq
```
### **FastQC**

FastQC es una herramienta de control de calidad que proporciona una visión rápida de la calidad de los datos de secuenciación en bruto. Su inclusión en pipelines bioinformáticos que utilizan datos de secuenciación es vital, ya que la calidad de las lecturas puede determinar qué objetivos son alcanzables, así como las mejores opciones para llegar a ellos.

FastQC realiza evaluaciones de calidad en varios aspectos. Algunas de las métricas que analiza incluyen: la calidad de las bases a lo largo de las lecturas, la distribución de la longitud de las lecturas, la presencia de secuencias sobre-representadas (que podrían ser adaptadores o contaminantes).

Podemos ejecutar FastQC para un archivo fastq con el comando

```bash
fastqc <archivo>
```

Al ejecutarlo se generará un archivo de salida, con extensión `.html` que incluye un informe detallado de la calidad de los datos de secuenciación.

El conocimiento de las muestras, experimento y objetivos del estudio definirán la interpretación sobre las calificaciones otorgadas en las pruebas de calidad.

### **Diseño de un informe de calidad de lecturas**

#### **Informe** ***default***

FastQC ofrece una serie de gráficos y tablas con métricas clave. Para resumir esto en un informe, para en ensamble de genomas virales podemos centrarnos en las siguientes secciones:

 * ***Basic Statistics***: Proporciona información general sobre el archivo FASTQ, como el número de lecturas, la longitud de la secuencia, la calidad media de la secuencia, el contenido de GC, etc.

  * ***Per base sequence quality***: Muestra la calidad de las bases a lo largo de todas las secuencias. Las líneas azules representan el rango intercuartil de la calidad, mientras que la línea roja representa la mediana. Esta gráfica ayuda a identificar cualquier disminución sistemática de la calidad hacia el final de las lecturas (esto puede pasar por acumulación de errores, degradación de señal de fluorescencia o phasing).

 * ***Per sequence quality scores***: Muestra la distribución de la calidad promedio de las secuencias. Ayuda a identificar si hay lecturas de baja calidad en el conjunto de datos.

 * ***Per base sequence content***: Muestra la proporción de cada base en cada posición en las lecturas. Idealmente, cada posición debería tener un contenido de base uniforme.

 * ***Per sequence GC content***: Compara el contenido de GC de las secuencias con un modelo teórico. Una distribución significativamente diferente puede indicar contaminación.

 * ***Sequence Length Distribution***: Muestra la distribución de la longitud de las secuencias. Debería ser consistente con las longitudes de secuencia esperadas.

 * ***Sequence Duplication Levels***: Muestra el nivel de duplicación de secuencias. Un alto nivel de duplicación puede indicar problemas técnicos.

 * ***Overrepresented sequences***: Enumera las secuencias que aparecen con mayor frecuencia de lo esperado. Estas secuencias pueden ser contaminantes, adaptadores, etc.


Entre los principales desafíos en la secuenciación de virus, podemos describir los siguientes:

* **Alta tasa de mutación**: Muchos virus, especialmente los Riboviria (RNA), tienen tasas de mutación altas. Esto significa que la población viral dentro de un solo huésped puede ser muy diversa, por lo que un control de calidad muy estricto sobre la variación puede derivar en pérdidas de lecturas correctas. 

* **Genomas pequeños**: Por su tamaño, los genomas virales pueden ser enmascarados por lecturas de sus hospederos u otras entidades biológicas presentes.

* **Coinfección y recombinación**: Los virus pueden recombinarse entre sí si un huésped está infectado con más de un tipo de virus a la vez. Esto puede resultar en lecturas que pudieran catalogarse como inconsistentes.

* **Persistencia y latencia**: Los estados de latencia y la rápida degradación de su material pueden provocar que el material genético secuenciado sea insuficiente.


#### **Informe agregado**

Debido al formato de salida, FastQC no proporciona una forma sencilla de exportar sus resultados en un formato fácilmente procesable, por lo que su automatización puede requerir el uso de otras herramientas.

Por ejemplo, MultiQC es un programa que agrega resultados de FastQC y otras herramientas en un informe único. Podemos llamar a FastQC para procesar los archivos fastq en un directorio, y posteriormente agregar sus resultados mediante MultiQC.

```bash
#!/bin/bash

# directorio de entrada
DIR_ENTRADA="$1"

# Validar la entrada
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 /ruta/a/directorio" >&2
    exit 1
fi

# Ejecutar FastQC en todos los archivos FASTQ del directorio
fastqc ${DIR_ENTRADA}/*.fastq.gz

# Generar informe de MultiQC
multiqc ${DIR_ENTRADA} -o ${DIR_ENTRADA}/multiqc_report

```

Al analizar nuestros resultados podemos respondernos las siguientes preguntas:

 * ¿Cómo varía la calidad de las lecturas entre las muestras?
 * ¿Hay alguna muestra que tenga un contenido de GC notablemente diferente?
 * ¿Hay evidencia de secuencias sobre-representadas en algunas muestras?
 * ¿Qué pasos podrían tomarse para limpiar las muestras, si fuera necesario?


### **Informe visual**

Finalmente crearemos un reporte utilizando ***R markdown*** un lenguaje centrado en la estructura y presentación del contenido y salidas del código, utilizado para crear documentos bien organizados como puede ser el caso de un reporte de calidad.

Para ejecutar el código de R incluido en un archivo R markdown este requiere de un "puente" que en este caso es el paquete Knitr. Knitr toma los bloques de código R y los ejecuta siguiendo los parámetros establecidos en la cabecerad el bloque. Luego, estos resultados se integran en el documento final, ya sea como texto, tablas, gráficos o cualquier otra salida generada por el código.

**Sin embargo**, R es un lenguaje interpretado de nivel superior. Esto quiere decir que sus abstracciones y estructuras de datos son más cercanas al lenguaje humano. A pesar de que para fines didácticos esto es una gran ventaja, **no lo es para sus tiempos de ejecución y uso de memoria**, más aún cuando involucramos un nivel más al utilizar R markdown. 

La ventaja de un informe en R markdown es que podemos personalizar más lo que queremos o no mostrar y la forma en que lo hacemos.

Ahora revisaremos los contenidos del archivo **Reporte_de_calidad_de_lecturas.Rmd** para aprender cómo está estructurado y las opciones que nos brinda.

Una vez que nos aseguremos que el archivo muestra todos los elementos visuales que queremos en nuestro reporte, es posible renderizarlo a un *html* desde RStudio, o dese la terminal de Bash con el siguiente comando:

```bash
R -e "rmarkdown::render('informe_calidad.Rmd')"
```
