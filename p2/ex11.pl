%esta_ordenada(L)

%esta_ord(L):- write(L).

esta_ordenada([]).
esta_ordenada([_]):- !.
esta_ordenada([X, Y|L]):- X =< Y, esta_ordenada([Y|L]).
