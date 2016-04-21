concat([], L, L).
concat([X|L1], L2, [X|L3]):- concat(L1, L2, L3).

suma(0, []).
suma(X, [Y|L]):- suma(X1, L), X is X1 + Y.

pert_rst(X, L, R):- concat(L1, [X|L2], L), concat(L1, L2, R).

suma_demas(L):- pert_rst(X, L, R), suma(X1, R), X is X1, !.
