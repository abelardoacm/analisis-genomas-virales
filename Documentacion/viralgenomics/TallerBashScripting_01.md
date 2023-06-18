## Introducción al Bash Scripting

### **¿Qué es el Bash scripting?**
- El *shell* es un programa de computadora que proporciona una interfaz de usuario para interactuar con el sistema operativo. ***Bash*** es el *shell*, o lenguaje de comandos más utilizado, ya que es el intérprete de comandos predeterminado en la mayoría de las distribuciones de *Linux*. 
- Un ***Bash script***, o script de *Bash*, es un archivo de texto que contiene una serie de comandos escritos Bash, utilizados para automatizar tareas en sistemas operativos basados en ***Unix***, como *Linux* y *macOS*.
- Por ejemplo, podrías tener un script que automatice la copia de seguridad de ciertos archivos en tu sistema, o uno que descargue e instale actualizaciones de software. Los Bash scripts también son utilizados en labores científicas y son el pan de cada día para muchxs bioinformáticxs.
### **Ventajas y aplicaciones del Bash scripting**

  Entre las ventajas del Bash scripting se encuentran:

  1. **Automatización**: Permite la automatización de tareas repetitivas, ahorrando tiempo y reduciendo la probabilidad de errores humanos.
  2. **Consistencia**: Las tareas rutinarias se realizan de la misma manera cada vez.
  3. **Eficiencia**: Los scripts de Bash se pueden utilizar para procesar grandes cantidades de datos de forma rápida y eficiente.
  4. **Versatilidad**: Bash es potente y extensible, con un rico conjunto de comandos y utilidades que se pueden combinar.
  5. **Escalabilidad**: Pueden adaptarse a diferentes tamaños de datos y proyectos. Puedes escribir scripts que procesen muestras individuales o scripts más complejos que procesen grandes conjuntos de datos.

El uso de **scripts de Bash** para el **análisis de datos de secuenciación** ofrece ventajas significativas, como la **automatización** de tareas repetitivas, la **flexibilidad** para adaptar el análisis a necesidades específicas, la **integración** con otras herramientas bioinformáticas, la **reproducibilidad** de los análisis, la **escalabilidad** para manejar diferentes tamaños de datos y proyectos, y el **control personalizado** del flujo de análisis. 


### **HELLO WORLD! El primer script de todxs**

Ahora, veamos un script de Bash más sencillo y popular. Este script imprimirá el mensaje "¡Hola, mundo!" cuando se ejecute.

Para crear un script de Bash, primero necesitas abrir un archivo de texto en cualquier editor de texto. Vamos a llamar a este archivo `1_1_HELLO_WORLD.sh`.

#### ***shebang***
En la primera línea del script, debes incluir una "shebang" (`#!`). Esta es una secuencia de caracteres que indica al sistema que el resto del archivo debe interpretarse como un script de Bash. La *shebang* de Bash es es **`#!/bin/bash`**, que como puedrás notar **es una ruta en de nuestro sistema**.

A continuación, puedes añadir los comandos que quieras que se ejecuten. Para nuestro script `1_1_HELLO_WORLD.sh`, sólo queremos que imprima "¡Hola, mundo!", utilizando el comando **`echo`**:

```bash
#!/bin/bash
echo "¡Hola, mundo!"
```

Para ejecutar este script, se deben otorgar permisos de ejecución al archivo utilizando el comando ***`chmod`***. A continuación, puedes ejecutarlo con `./1_1_HELLO_WORLD.sh` desde la terminal.

Este es un ejemplo simple, pero a medida que te familiarices con Bash, podrás crear scripts más complejos y útiles.

