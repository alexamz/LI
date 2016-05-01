equalList([X], [X]):-!.
equalList([X], [Y]):- X \= Y, !, fail.
equalList([X|L1], [Y|L2]):- equalList([X], [Y]), equalList(L1, L2).

seekDestroy([Y|L], X, L):- equalList(Y, X), !.
seekDestroy([Y|L], X, [Y|L2]):- seekDestroy(L, X, L2).

modify1([X,Y|_], L1, L2):- X1 is X - 1, X2 is X - 2, 
		append([X2], [Y], L2), append([X1], [Y], L1), canMove(L2), canMoveUpRight(L2).		% UpRight
modify2([X,Y|_], L1, L2):- X1 is X - 1, X2 is X - 2, Y1 is Y - 1, Y2 is Y - 2, 
		append([X2], [Y2], L2), append([X1], [Y1], L1), canMove(L2). 						% UpLeft
modify3([X,Y|_], L1, L2):- X1 is X + 1, X2 is X + 2, Y1 is Y + 1, Y2 is Y + 2, 
		append([X2], [Y2], L2), append([X1], [Y1], L1), canMove(L2). 						% DownRight
modify4([X,Y|_], L1, L2):- X1 is X + 1, X2 is X + 2, 
		append([X2], [Y], L2), append([X1], [Y], L1), canMove(L2). 							% DownLeft
modify5([X,Y|_], L1, L2):- Y1 is Y + 1, Y2 is Y + 2, 
		append([X], [Y2], L2), append([X], [Y1], L1), canMove(L2). 							% Right
modify6([X,Y|_], L1, L2):- Y1 is Y - 1, Y2 is Y - 2, 
		append([X], [Y2], L2), append([X], [Y1], L1), canMove(L2). 							% Left

canMove([X,Y|_]):- 1 =< X, X =<5, 1 =< Y, Y =< 5.
canMoveUpRight([X,Y|_]):- Y =< X.

out([]).
out([I, E|C]):- out(C), write(I), write(" jumps over "), write(E), nl.

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
	selectPivots(EstadoActual, P, R, N),
    unPaso( P, R, N, EstSiguiente, M ), \+member(EstSiguiente, CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [P, M|CaminoHastaAhora], CaminoTotal ).

solve(L):- 	length(L, N),
    camino([L, N], [_, 1], [], C),
    out(C).

selectPivots([L, N], P, R, N):- select(P, L, R).

unPaso(P, R, N,  [L, N1], M):-  modify1(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1, append([P1], R1, L).	%UpRight
unPaso(P, R, N,  [L, N1], M):-  modify2(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1, append([P1], R1, L).	%UpLeft
unPaso(P, R, N,  [L, N1], M):-  modify3(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1, append([P1], R1, L).	%DownRight
unPaso(P, R, N,  [L, N1], M):-  modify4(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1, append([P1], R1, L).	%DownLeft
unPaso(P, R, N,  [L, N1], M):-  modify5(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1, append([P1], R1, L).	%Right
unPaso(P, R, N,  [L, N1], M):-  modify6(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1, append([P1], R1, L).	%Left
