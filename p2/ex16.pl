%ordenacion([60,42,33,81,29,59,95,86,79,96,29,91,13,75,31,91,43,28,83,44,46,36,42,34,78,25,62,54,56,20,58,21,15,83,21,9,12,82,92,52,29,39,38,90,32,14,54,39,61,8], L)

%ordenacion([], []).
%ordenacion([X|L], L1):- ordenacion(L, L2).

%divide la lista en dos mitades
split([],[],[]).
split([A],[A],[]).
split([A,B|R],[A|Ra],[B|Rb]) :-  split(R,Ra,Rb).



merge([], []):- !.
merge([X], [X]):- !.
merge(L, R):- split(L, L1, L2), merge(L1, L11), merge(L2, L22), sort(L11, L22, R).

%sort(L1, L2, R)
sort([], [], []).
sort([X|L1], [Y|L2], [Y, X|R]):- X >= Y, sort(L1, L2, R).
sort([X|L1], [Y|L2], [X, Y|R]):- X < Y, sort(L1, L2, R).

