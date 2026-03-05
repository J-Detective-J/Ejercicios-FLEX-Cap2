# Flex & Bison - Ejercicios del Capítulo 2

Este repositorio contiene las soluciones a los ejercicios propuestos en el Capítulo 2 del libro *flex & bison* de John Levine.

## Contenido de los Ejercicios

### 1. Optimización de Lectura (`ej1.l`)
Se modificó el escáner para evitar el procesamiento carácter por carácter. Utiliza el patrón `[^\n]+` para leer bloques de texto.

### 2. Concordancia Case-Insensitive (`ej2.l`)
Implementación de una tabla de símbolos que ignora la diferencia entre mayúsculas y minúsculas. 
- Utiliza `tolower()` en la función de hash.
- Utiliza `strcasecmp()` para la comparación de cadenas.
- Incluye una función de impresión final para mostrar los resultados tras detectar el fin de archivo (EOF).

### 3. Tabla de Símbolos Dinámica (`ej3.l`)
Elimina el límite de tamaño fijo de la tabla de símbolos.
- Implementa **Rehashing**.
- Utiliza `realloc()` y `calloc()` para garantizar que la memoria sea contigua, permitiendo el uso de algoritmos de ordenamiento como `qsort`.

## Instrucciones de Compilación

Es necesario tener instalados `flex` y un compilador de C (como `gcc`).

```bash
# Ejercicio 1
flex -o ej1.lex.c ej1.l
gcc -o ej1 ej1.lex.c

# Ejercicio 2
flex -o ej2.lex.c ej2.l
gcc -o ej2 ej2.lex.c

# Ejercicio 3
flex -o ej3.lex.c ej3.l
gcc -o ej3 ej3.lex.c
