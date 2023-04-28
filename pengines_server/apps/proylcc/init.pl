:- module(init, [ init/2 ]).

/**
 * init(-Grid, -NumOfColumns).
 * 
 * Predicado especificando la grilla inicial, que será mostrada al comienzo del juego, donde
 * Grid es una lista con los números que conforman la grilla, y NumOfColumns es la cantidad de columnas, 
 * determinando las dimensiones de la misma.
 */

 init(Grid, 5) :-
    length(Grid, 40), % 8 filas x 5 columnas = 40 elementos en total
    randomizeGrid(Grid).

/**
 * randomizeGrid(+Grid).
 * 
 * Predicado que genera una rejilla aleatoria con potencias de 2 menores a 64.
 * Grid es la lista que representa la rejilla y se modifica con valores aleatorios.
 */

randomizeGrid([]).
randomizeGrid([X | Grid]) :-
    randomPowerOfTwo(X),
    randomizeGrid(Grid).

/**
 * randomPowerOfTwo(-Num).
 * 
 * Predicado que genera un número aleatorio que es una potencia de 2 menor a 64.
 * Num es el número generado.
 */

randomPowerOfTwo(Num) :-
    random_between(1, 6, Exp), % Genera un exponente aleatorio de 1 a 6 (correspondiente a las potencias de 2 menores a 64)
    Num is 2 ^ Exp.