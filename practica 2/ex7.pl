%dados().
%dados():-.


permutacion([],[],[]).
permutacion([X|L1],[Y|L2],[X,Y|L3]):-write(X),permutacion(L1, L2, L3).
%permutacion([X|L1],[Y|L2],[X,Y|L3]):-[_,_|L3], permutacion(L1, L2, L3).