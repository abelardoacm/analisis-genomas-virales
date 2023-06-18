## Introducción al ensamble de novo
### **Definición y relevancia del ensamble de novo**

El ensamble de novo se refiere al proceso de ensamblar fragmentos de DNA/RNA provenientes de las lecturas de la secuenciación, en una secuencia completa o parcialmente completa SIN la ayuda de una secuencia de referencia. 

En otras palabras, el ensamble de novo es como reconstruir el las notas de un periódico que explotó.

Este proceso nos permite descubrir nuevos genomas, identificar variantes estructurales y analizar linajes poco conocidos para los cuales no hay secuencias de referencia disponibles. El ensamble de novo es particularmente útil cuando se secuencian nuevos organismos o se estudian comunidades complejas, donde se desconoce la mayoría de las secuencias genómicas, como es el caso frecuentemente para los virus.

En el contexto de la genómica viral, el ensamble de novo es de crucial importancia por varias razones:

 * **Diversidad viral**: Las secuencias de referencia pueden no ser útiles para linajes altamente variables (como la mayoría)... incluso pueden llegar a jugarnos en contra.

 * **Descubrimiento de nuevos virus**: Es posible descubrir nuevos virus o variantes.

 * **Estudio de la recombinación/segmentación**: Como lo exploramos anteriormente, los virus de algunos linajes suelen recombinarse o segmentarse, incluso como parte de algunas estrategias para la infección. Estos fenómenos muy particulares de los virus y elementos genéticos móviles retan la utilidad de las secuencias de referencia, no solo por la identidad a nivel de los nucleótidos, sino también hablando de la sintenia de los genes.

### **Breve historia de los algoritmos de ensamble**

El ensamble de novo ha sido una parte fundamental de la bioinformática y la genómica durante varias décadas, y los algoritmos y técnicas han cambiado y evolucionado significativamente a lo largo de los años.

#### **Primeros algoritmos**

Los primeros algoritmos de ensamble surgieron en la década de 1980 con los primeros esfuerzos para secuenciar genomas completos. Los métodos de secuenciación de la época producían lecturas de secuencias relativamente largas, pero en cantidades limitadas. 

Algoritmos como Phrap o TIGR assembler, se basaban en la idea de solapar las lecturas y utilizar estos solapamientos para unir las lecturas en contiguos más largos.

#### **Aparición de la secuenciación de nueva generación (NGS)**

Con la introducción de la secuenciación de nueva generación (NGS) a mediados de la década de 2000, el panorama cambió dramáticamente. Los métodos NGS podían generar millones de lecturas cortas (de unos pocos cientos de pares de bases) en un solo experimento. Este aumento en el volumen de datos creó nuevos desafíos para los algoritmos de ensamble, ya que los métodos existentes no eran adecuados para manejar la gran cantidad de datos producidos por las tecnologías NGS.

En respuesta a estos desafíos, se desarrollaron nuevos algoritmos que utilizaban los ***grafos de De Bruijn*** para ensamblar genomas a partir de lecturas cortas. Los gráficos de De Bruijn representan las relaciones entre las secuencias de lectura en términos de k-mers (secuencias de longitud k), lo que permite un enfoque más eficiente para el ensamble de lecturas cortas. 

Los primeros algoritmos de gráficos de De Bruijn, como Velvet, ABySS y SOAPdenovo, permitieron el ensamble de genomas mucho más grandes y complejos.

#### **Secuenciación de tercera generación**

Recientemente, la aparición de la secuenciación de tercera generación, que produce lecturas de secuencias mucho más largas (de decenas de miles a cientos de miles de pares de bases), ha dado lugar a toda una nueva generación de algoritmos de ensamble. Estos algoritmos están diseñados para lidiar con enormes volúmenes de información.


### **Principales desafíos del ensamble de novo**

 * **Complejidad y tamaño del genoma:** En general, cuanto más grande y complejo es el genoma, más difícil es ensamblarlo de novo. Los genomas con una gran cantidad de repeticiones largas, duplicaciones y regiones de baja complejidad son particularmente desafiantes. 
 
     * Aunque los genomas virales son mucho más pequeños que los genomas de los eucariotas, la alta diversidad y tasa de mutación de los virus puede aumentar la complejidad del ensamble de novo.

 * **Calidad y cantidad de los datos de secuenciación:** La calidad y cantidad de los datos de secuenciación pueden tener un impacto significativo en la precisión y la completitud del ensamble de novo. La secuenciación de baja calidad o la cobertura de secuenciación insuficiente puede dar lugar a ensambles fragmentados o imprecisos. Asimismo, las secuencias de adaptadores y los artefactos de PCR pueden introducir errores en el ensamble si no se eliminan antes del ensamble de novo.

      * En el caso de los virus esto tiene un enorme impacto en el diseño experimental para la extracción del material genético y la secuenciación, ya que este proceso siempre debe considerar su condicion endoparásitica y sus particularidades genómicas.

 * **Errores de ensamble y validación de los resultados:** Debido a las incertidumbres inherentes al proceso de ensamble, es posible que se introduzcan errores en los ensambles. Estos pueden incluir la incorporación de lecturas erróneas. Por lo tanto, es importante validar y corregir los ensambles utilizando diversas técnicas, como la resecuenciación, el mapeo de lecturas y la comparación con genomas de linajes cercanos.

 * **Optimización del algoritmo de ensamble:** Existen muchos algoritmos de ensamble de novo disponibles, cada uno con sus propias ventajas y desventajas. La elección del algoritmo de ensamble y la optimización de sus parámetros puede tener un impacto significativo en la calidad del ensamble. Esta elección puede ser especialmente desafiante para los genomas virales.

      * Reconstrucción del quimerismo y la variabilidad intra-host. En el caso de la secuenciación viral la optimización del algoritmo deberá hacerse según el impacto que sobre sus supuestos puedan tener la contaminación externa, variabilidad y el quimerismo.

