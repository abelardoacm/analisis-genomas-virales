## Pipelines

Un pipeline en el contexto de la bioinformática, es una serie de pasos que se ejecutan en un orden específico. Cada paso en este pipeline toma datos de entrada, realiza alguna operación y genera datos de salida. Estos datos de salida se utilizan entonces como entrada para el siguiente paso del pipeline. 

Este concepto se asemeja a una línea de ensamblaje de una fábrica, donde cada estación de trabajo realiza una tarea específica en un producto que se mueve a lo largo de la línea.

![Figura 2](https://www.netjet.es/wp-content/uploads/2019/04/Gui%CC%81a-para-comprar-tuberi%CC%81as-y-lo-que-debes-tener-en-cuenta-1000x500.jpg)

En un pipeline de bioinformática, cada paso a menudo implica un tipo específico de análisis. Por ejemplo, si estás trabajando con datos de secuenciación de DNA, los pasos del pipeline podrían incluir el control de calidad de las lecturas, el alineamiento de las lecturas a una referencia, la llamado de variantes y visualización de los resultados. Cada uno de estos pasos puede requerir una herramienta o software especializado.

Los pipelines son muy valiosos en bioinformática debido a la gran cantidad de datos que se manejan y la complejidad de los análisis. Proporcionan una manera de estructurar y automatizar los análisis, lo que hace que el procesamiento de los datos sea más eficiente y reproducible. Esto significa que si alguien más necesita realizar el mismo tipo de análisis, puede usar el mismo pipeline y obtener los mismos resultados.

Los pipelines pueden ser codificados en varios lenguajes de programación y existen varios frameworks específicos para su implementación, como Nextflow, que permite diseñar pipelines complejos de manera sencilla y eficiente.


## Nextflow

Nextflow es un marco de trabajo o framework, un sistema de ejecución que proporciona una estructura estándar de construccion de codigo. Nextflow es una herramienta diseñada para hacer más eficientes, reproducibles y portables los análisis complejos de bioinformática. Este lenguaje de programación y marco de ejecución te permite escribir flujos de trabajo computacionales o pipelines con un enfoque basado en scripts y a la vez sacar provecho de la paralelización.

![Figura 3](https://www.nextflow.io/img/nextflow2014_no-bg.png)

En esencia, Nextflow es una capa de abstracción, es decir una forma de ocultar los detalles de implementación de una funcionalidad particular, permitiendo que los usuarios o los programas interactúen con la funcionalidad a un nivel de abstracción más alto. Por ejemplo, una capa de abstracción podría ocultar los detalles de cómo se almacenan y recuperan los datos en un sistema de archivos, permitiendo a los programas leer y escribir archivos utilizando una API sencilla. La capa de abstracción permite que los programadores se centren en su lógica de aplicación sin tener que preocuparse de los detalles de bajo nivel.

Nextflow está basado en el lenguaje de programación Groovy, pero la mayor parte de su sintaxis es similar a la de Unix, por lo que resulta familiar. 

Los scripts de Nextflow definen procesos, los cuales son bloques de código que se ejecutan en paralelo. Cada proceso tiene su propio espacio de trabajo y funciona de manera aislada del resto. Los procesos pueden tener declaraciones de entrada y salida, lo que permite definir flujos de trabajo en los que los datos se procesan en etapas secuenciales.

![Figura 4](https://www.nextflow.io/img/home-dsl2.png)

Nextflow también tiene un sistema de manejo de errores robusto que permite reintentar la ejecución de una tarea si esta falla. Los datos intermedios se guardan, lo que permite reanudar un flujo de trabajo desde el punto en que se interrumpió.

Una característica clave de Nextflow es su portabilidad, que se logra mediante la encapsulación de las tareas de un flujo de trabajo en contenedores (usando tecnologías como Docker o Singularity) que contienen todas las dependencias necesarias para ejecutar esa tarea. Nextflow permite la creación de pipelines de análisis de datos que pueden ejecutarse en una variedad de infraestructuras, incluyendo sistemas locales, clústeres de alto rendimiento (HPCs), y servicios de computación en la nube, como Google Cloud, Amazon Web Services (AWS) y Microsoft Azure.

Nextflow también es compatible con Docker y Singularity, lo que permite encapsular el software y sus dependencias en contenedores que pueden ser fácilmente distribuidos y ejecutados en cualquier sistema. Esto facilita la reproducción de análisis bioinformáticos en diferentes entornos.

## viralrecon

Ahora bien, viralrecon es un pipeline de bioinformática construido sobre Nextflow, que está diseñado para el análisis de secuencias de genomas virales. Este pipeline incluye una serie de etapas de análisis secuencial, desde el control de calidad de los datos de secuenciación hasta la anotación de variantes genéticas, el montaje de genomas y la análisis filogenéticos.

![Figura 5](https://github.com/nf-core/viralrecon/raw/master/docs/images/nf-core-viralrecon_logo_dark.png#gh-dark-mode-only)

Al igual que otros pipelines basados en Nextflow, viralrecon es altamente paralelizable y puede escalarse para procesar grandes cantidades de datos de secuenciación.

En resumen, Nextflow y herramientas como viralrecon son esenciales para el análisis eficiente y reproducible de los datos de genómica viral a gran escala. Es importante familiarizarse con estas herramientas y aprender a usarlas de manera efectiva para poder realizar análisis bioinformáticos de alta calidad.

```{note}
Es importante destacar que, aunque viralrecon automatiza gran parte del análisis de secuencias virales, aún se necesita experiencia en genómica y bioinformática para interpretar correctamente los resultados. Además, al igual que con cualquier pipeline bioinformático, es esencial comprender los métodos y herramientas utilizados en cada etapa del análisis para poder evaluar adecuadamente la calidad y la confiabilidad de los resultados.
```
![Figura 5](https://github.com/nf-core/viralrecon/raw/master/docs/images/nf-core-viralrecon_metro_map_illumina.png)


Para ejecutar viralrecon con nuestros datos de lecturas de SARS CoV2, vamos a ejecutar uno de los siguientes comandos:

```{bash}
nextflow run nf-core/viralrecon -profile singularity --input '/ruta/a/tus/datos/fastq.gz' --outdir resultados_viralrecon

nextflow run nf-core/viralrecon -profile test,singularity --outdir resultados_viralrecon
```