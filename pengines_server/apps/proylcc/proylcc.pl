:- module(proylcc, 
	[  
		get_element/5,
		replace/4, 
		replace_element/6,
		replace_elements/5,
		next_power_of_two/2,
		sum_grid_elements/4,
		sum_grid_elements/5,
		replace_path/4,
		join/4
	]).


% Predicado para obtener un elemento de la grilla dado las coordenadas
get_element(Grid, NumOfColumns, X, Y, Element) :- % X=columnas, Y=filas
    % Calculamos el índice correspondiente a las coordenadas
    Index is (X * NumOfColumns) + Y,
    % Obtenemos el elemento en el índice calculado
    nth0(Index, Grid, Element).

% Predicado para sumar los elementos de la grilla Grid según los pares ordenados de Path
sum_grid_elements(Grid, Path, NumOfColumns, Sum) :-
    sum_grid_elements(Grid, Path, 0, NumOfColumns, Sum).

sum_grid_elements(_, [], Acc, _NumOfColumns, Acc).
sum_grid_elements(Grid, [[X, Y] | Rest], Acc, NumOfColumns, Sum) :-
    get_element(Grid, NumOfColumns, X, Y, Element),
    NewAcc is Acc + Element,
    sum_grid_elements(Grid, Rest, NewAcc, NumOfColumns, Sum).

% Predicado para obtener la próxima potencia de 2 mayor o igual a un número dado
next_power_of_two(Number, NextPower) :-
    NextPower is 2 ** ceil(log(Number) / log(2)).

replace(List, Index, Element, Result) :-
	nth0(Index, List, _, Temp),
	nth0(Index, Result, Element, Temp).

% Predicado para reemplazar un elemento de la grilla dado las coordenadas
replace_element(Grid, NumOfColumns, X, Y, NewElement, RGrids) :-
	% Calculamos el índice correspondiente a las coordenadas
	Index is X * NumOfColumns + Y,
	% Reemplazamos el elemento en el índice calculado
	replace(Grid, Index, NewElement, RGrids).

% Predicado para reemplazar múltiples elementos de la grilla
replace_elements(Grid, NumOfColumns, [], Element, Grid). % Caso base: no hay más elementos para reemplazar
replace_elements(Grid, NumOfColumns, [[X, Y] | Rest], Element, RGrids) :-
	replace_element(Grid, NumOfColumns, X, Y, Element, TempGrid),
	replace_elements(TempGrid, NumOfColumns, Rest, Element, RGrids).

% Predicado principal para reemplazar el último elemento del Path con la próxima potencia de 2, además reemplaza el resto del camino a 0
replace_path(Grid, NumOfColumns, Path, [RGrids]) :-
    sum_grid_elements(Grid, Path, NumOfColumns, Sum),
    next_power_of_two(Sum, NextPower), 
	replace_elements(Grid, NumOfColumns, Path, 0, GridAux),
    last(Path, [X, Y]), % Obtener las coordenadas del último par ordenado en Path
    replace_element(GridAux, NumOfColumns, X, Y, NextPower, RGrids). %Reemplaza el último elemento de Path con la potencia obtenida



/**
 * join(+Grid, +NumOfColumns, +Path, -RGrids) 
 * RGrids es la lista de grillas representando el efecto, en etapas, de combinar las celdas del camino Path
 * en la grilla Grid, con número de columnas NumOfColumns. El número 0 representa que la celda está vacía. 
 */ 

 join(Grid, NumOfColumns, Path, RGrids) :-
    replace_path(Grid, NumOfColumns, Path, RGrids).