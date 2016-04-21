card([],[]).
card([X|L], [ [X, N]| C]):- erase(L, R, X, N), card(R, C).

card(L):- card(L, C), write(C).

erase([], [], _, 1).
erase([X|L], L2, X, N):- !, erase(L, L2, X, N1), N is N1 + 1.
erase([Y|L], [Y|L2], X, N):- erase(L, L2, X, N).


