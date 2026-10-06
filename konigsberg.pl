:- encoding(utf8).
% Zonas: norte (orilla norte), sur (orilla sur),
%        kneiphof (isla central), este (isla este)
% puente(Id, Zona1, Zona2)
puente(p1, norte, kneiphof).
puente(p2, norte, kneiphof).
puente(p3, sur, kneiphof).
puente(p4, sur, kneiphof).
puente(p5, norte, este).
puente(p6, sur, este).
puente(p7, kneiphof, este).

% Los puentes se pueden cruzar en ambos sentidos
cruza(P, X, Y) :- puente(P, X, Y).
cruza(P, X, Y) :- puente(P, Y, X).

% Recorrido que usa cada puente una sola vez (backtracking)
recorrido(X, X, Usados, Usados).
recorrido(X, Fin, Usados, Total) :-
    cruza(P, X, Y),
    \+ member(P, Usados),
    recorrido(Y, Fin, [P|Usados], Total).

% Paseo: cruza los 7 puentes y vuelve al punto de partida
paseo(Inicio) :-
    member(Inicio, [norte, sur, kneiphof, este]),
    recorrido(Inicio, Inicio, [], Usados),
    length(Usados, 7).

% Grado: cantidad de puentes que llegan a una zona
grado(Zona, N) :-
    member(Zona, [norte, sur, kneiphof, este]),
    findall(P, cruza(P, Zona, _), L),
    length(L, N).
