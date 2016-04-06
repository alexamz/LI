suma(0, []).
suma(X, [Y|L]):- suma(X1, L), X is X1 + Y.

concat([], L, L).
concat([X|L1], L2, [X|L3]):- concat(L1, L2, L3).

pert_rst(X, L, R):- concat(L1, [X|L2], L), concat(L1, L2, R).

suma_ants(L):-concat(X, [Y|_], L), suma(R, X), Y is R, !.
