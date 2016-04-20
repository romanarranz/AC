Arquitectura de Computadores
===================

Prácticas y seminarios de la asignatura Arquitectura de Computadores cursada en el Grado en Informática de la **Universidad de Granada**

----------

##Índice de Prácticas

### Práctica 0: Entorno de Programación
En esta práctica se dejan varios ejemplos básicos de programas usando **OpenMP** que será la API para la programación multiproceso de memoria compartida que se usa en la asignatura.

> **Consideraciones:**

> - Los guiones de prácticas resueltos no los he subido, no obstante si surgiera alguna duda puedes ponerte en contacto conmigo a través de mi email.
> - Otro de los ejemplos que se deja SumaVectores.cpp para C++ y SumaVectores.c se usará en otras prácticas


### Práctica 1: Directivas de OpenMP

En esta práctica hacemos uso de las directivas que nos ofrece OpenMP para crear y terminar regiones paralelas, realizar tareas compartidas mediante sincronización y comunicación entre hilos.


> **Consideraciones:**
>
> - Se hace especial hincapié en el uso de variables, funciones y directivas de OpenMP.
> - Debemos distinguir entre bloque estructurado, región y construcción.
> - Debemos distinguir entre directiva ejecutable y directiva declarativa.
> - El código en ASM ha sido generado con `gcc -S`.


### Práctica 2: Cláusulas de OpenMP

En esta práctica hacemos uso de cláusulas fundamentales que ofrece OpenMP, con la que podremos tener control de la comunicación/sincronización y visibilidad de las variables.

> **Consideraciones:**
>
> - Podremos discernir el ámbito de una variable en código.
> - Debemos hacer distinción entre directivas y cláusulas.
> - Entre los ejemplos se deja el producto de una matriz cuadrada M de tamaño NxN por un vector V de tamaño N implementado con OpenMP.
> - Se pide estudio de escalabilidad para N = 100, 500, 1000, 1500 para la multiplicación de matriz por vector.


### Práctica 3: Interacción con el entorno OpenMP

En esta práctica hacemos uso de las variables de entorno de OpenMP para definir el número de threads, modificar cómo se encargan los threads del reparto de la carga y como planificar los bucles.

> **Consideraciones:**
> 
> - Podremos deducir el número de threads en un código paralelo.
> - Especificar el número de threads que queremos en nuestro programa.
> - Modificar el comportamiento de las asignaciones de recursos a los threads.
> - Normalmente se suele utilizar el tipo de asignación de threads `dynamic`.
> - Entre los ejercicios se deja uno que multiplica una matriz triangular por un vector, tanto en su versión secuencial como paralela.
> - Entre los ejercicios se deja uno que realiza una multiplicación de matrices cuadradas de tamaño NxN.
> - Se pide estudio de escalabilidad para N = 100, 500, 1000, 1500 para la multiplicación de matrices.

### Práctica 4: Optimización de código

En esta práctica se nos proporcionaba diferentes ejemplos los cuales no eran eficientes ya que no estaban optimizados.
Uno de los principales objetivos es tener en cuenta la arquitectura y microarquitectura.

> **Consideraciones:**
> 
> - Nosotros realizamos optimizaciones a alto nivel, es decir no profundizamos a incluir código ASM en linea para programas en C o C++.
> - Utilizamos la propia optimización del compilador en algunos casos, con los modificadores `gcc -On` para n = {1,2,3}
> Implementamos la rutina DAXPY que multiplica un vector por una constante y lo suma a otro vector. Esta tarea es utilizada en el Benchmark Linpack para evaluar los computadores más rápidos del mundo [Top500Report](http://www.top500.org). 

## Licencia

Los detalles se encuentran en el archivo `LICENSE`. En resumen, todo el contenido tiene como licencia **MIT License** por lo tanto es totalmente gratuito su uso para proyectos privados o de uso comercial.