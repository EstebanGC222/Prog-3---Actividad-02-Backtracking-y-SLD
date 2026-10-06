:- encoding(utf8).
% carretera(Ciudad1, Ciudad2, Km)
carretera(coruna, vigo, 171).
carretera(coruna, valladolid, 455).
carretera(vigo, valladolid, 356).
carretera(oviedo, bilbao, 304).
carretera(valladolid, bilbao, 280).
carretera(valladolid, madrid, 193).
carretera(bilbao, madrid, 395).
carretera(bilbao, zaragoza, 324).
carretera(madrid, zaragoza, 325).
carretera(zaragoza, barcelona, 296).
carretera(barcelona, gerona, 100).
carretera(barcelona, valencia, 349).
carretera(madrid, badajoz, 403).
carretera(madrid, jaen, 335).
carretera(madrid, albacete, 251).
carretera(albacete, valencia, 191).
carretera(albacete, murcia, 150).
carretera(valencia, murcia, 241).
carretera(jaen, sevilla, 242).
carretera(jaen, granada, 99).
carretera(sevilla, granada, 256).
carretera(sevilla, cadiz, 125).
carretera(granada, murcia, 278).

% Las carreteras son de doble sentido
conectado(X, Y, D) :- carretera(X, Y, D).
conectado(X, Y, D) :- carretera(Y, X, D).

% Camino de X a Y sin repetir ciudades (backtracking)
camino(X, Y, Ruta, Km) :- camino(X, Y, [X], R, Km), reverse(R, Ruta).
camino(X, X, Visitados, Visitados, 0).
camino(X, Y, Visitados, Ruta, Km) :-
    conectado(X, Z, D),
    \+ member(Z, Visitados),
    camino(Z, Y, [Z|Visitados], Ruta, K),
    Km is D + K.

% Ruta más corta: el camino de menor distancia
ruta_mas_corta(X, Y, Ruta, Km) :-
    findall(K-R, camino(X, Y, R, K), Caminos),
    keysort(Caminos, [Km-Ruta|_]).
