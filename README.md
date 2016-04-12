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


### Práctica 1: Directivas con OpenMP

En esta práctica hacemos uso de las directivas que nos ofrece OpenMP para crear y terminar regiones paralelas, realizar tareas compartidas mediante sincronización y comunicación entre hilos.


> **Consideraciones:**
> 
> - Se hace especial hincapié en el uso de variables, funciones y directivas de OpenMP.
> - Debemos distinguir entre bloque estructurado, región y construcción.
> - Debemos distinguir entre directiva ejecutable y directiva declarativa.
> - El código en ASM ha sido generado con `gcc -S`.


### Práctica 2: Cláusulas OpenMP

En esta práctica hacemos uso de cláusulas fundamentales que ofrece OpenMP, con la que podremos tener control de la comunicación/sincronización y visibilidad de las variables.

> **Consideraciones:**
> 
> - Podremos discernir el ámbito de una variable en código.
> - Debemos hacer distinción entre directivas y cláusulas.
> - Entre los ejemplos se deja el producto de una matriz cuadrada M por un vector V implementado con OpenMP.