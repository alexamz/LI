permutacion([], []).
permutacion(L, [X|P]):- pert_con_resto(X, L, R), permutacion(R, P).

pert_con_resto(X, L, R):- concat(L1, [X|L2], L), concat(L1, L2, R).

concat([],L, L).
concat([X|L1], L2, [X|L3]):- concat(L1, L2, L3).

esta_ordenado([]).
esta_ordenado([_]):- !.
esta_ordenado([X, Y|L]):- X =< Y, esta_ordenado([Y|L]).

ordenacion(L1, L2):- permutacion(L1, L2), esta_ordenado(L2), !.
