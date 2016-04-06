delete(_,[],[]).
delete(X,[X|L1], L2):-!,delete(X, L1, L2). %esborra tots els elements X duna llista L1 i deixa el resultat en una llista L2
delete(X,[Y|L1],[Y|L2]):- delete(X, L1, L2).

search(X,[X|_]):-!.
search(X,[_|L1]):- search(X, L1).

union([],L,L).		%unio de dues llistes
union([X|L1], L2, [X|L3]):-delete(X,L2,L22), union(L1,L22,L3).

intersection([], _, []).
intersection([X|L1], L2, [X|L3]) :- search(X, L2), intersection(L1, L2, L3).
intersection([_|L1], L2, L3) :- inter(L1, L2, L3).