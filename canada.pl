:- encoding(utf8).
% arista(Origen, Destino, Costo)  -- grafo dirigido
arista(vancouver, edmonton, 16).
arista(vancouver, calgary, 13).
arista(edmonton, saskatoon, 12).
arista(calgary, edmonton, 4).
arista(calgary, regina, 14).
arista(saskatoon, calgary, 9).
arista(saskatoon, winnipeg, 20).
arista(regina, saskatoon, 7).
arista(regina, winnipeg, 4).

% Conexión directa entre dos nodos, en cualquier sentido
conexion(X, Y, C) :- arista(X, Y, C).
conexion(X, Y, C) :- arista(Y, X, C).

% Un nodo tiene aristas si sale o llega alguna arista a él
tiene_aristas(X) :- (arista(X, _, _) ; arista(_, X, _)), !.

% Costo de ir de X a Z pasando por Y
costo(X, Y, Z, C) :-
    arista(X, Y, C1),
    arista(Y, Z, C2),
    C is C1 + C2.

% ¿Es posible viajar de X a Y? (sin repetir nodos, evita ciclos)
viajar(X, Y, Ruta, Costo) :- viajar(X, Y, [X], R, Costo), reverse(R, Ruta).
viajar(X, X, Visitados, Visitados, 0).
viajar(X, Y, Visitados, Ruta, Costo) :-
    arista(X, Z, C),
    \+ member(Z, Visitados),
    viajar(Z, Y, [Z|Visitados], Ruta, C2),
    Costo is C + C2.
