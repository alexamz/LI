%ordenacion([60,42,33,81,29,59,95,86,79,96,29,91,13,75,31,91,43,28,83,44,46,36,42,34,78,25,62,54,56,20,58,21,15,83,21,9,12,82,92,52,29,39,38,90,32,14,54,39,61,8], L)

ordenacion([], []).
ordenacion([X|L], L1):- ordenacion(L, L2), insercion(X, L2, L1). 

insercion(X, [], [X]):- !.
insercion(X, [Y|L1], [X,Y|L1]):- X < Y, !.
insercion(X, [Y|L1], [Y|L2]):- X >= Y, insercion(X, L1, L2).

