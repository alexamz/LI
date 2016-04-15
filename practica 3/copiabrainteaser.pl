equalList([X], [X]):-!.
equalList([X], [Y]):- X \= Y, !, fail.
equalList([X|L1], [Y|L2]):- equalList([X], [Y]), equalList(L1, L2).

seekDestroy([Y|L], X, L):- equalList(Y, X), !.
seekDestroy([Y|L], X, [Y|L2]):- seekDestroy(L, X, L2).

split(L, P, C, N) :- append(P, C, L), length(P, 1), length(C, N).

modify1([X,Y|_], L1, L2):- X1 is X - 1, X2 is X - 2, append([X2], [Y], L2), append([X1], [Y], L1), canMove(L2), canMoveUpRight(L2).			% UpRight
modify2([X,Y|_], L1, L2):- X1 is X - 1, X2 is X - 2, Y1 is Y - 1, Y2 is Y - 2, append([X2], [Y2], L2), append([X1], [Y1], L1), canMove(L2). % UpLeft
modify3([X,Y|_], L1, L2):- X1 is X + 1, X2 is X + 2, Y1 is Y + 1, Y2 is Y + 2, append([X2], [Y2], L2), append([X1], [Y1], L1), canMove(L2). % DownRight
modify4([X,Y|_], L1, L2):- X1 is X + 1, X2 is X + 2, append([X2], [Y], L2), append([X1], [Y], L1), canMove(L2). 							% DownLeft
modify5([X,Y|_], L1, L2):- Y1 is Y + 1, Y2 is Y + 2, append([X], [Y2], L2), append([X], [Y1], L1), canMove(L2). 							% Right
modify6([X,Y|_], L1, L2):- Y1 is Y - 1, Y2 is Y - 2, append([X], [Y2], L2), append([X], [Y1], L1), canMove(L2). 							% Left

canMove([X,Y|_]):- 1 =< X, X =<5, 1 =< Y, Y =< 5.
canMoveUpRight([X,Y|_]):- Y =< X.

cutUp([X|_], X).

out([]).
out([I, E|C]):- out(C), write(I), write(" jumps over "), write(E), nl.% write(I), write(T), write(E).

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-

    unPaso( EstadoActual, EstSiguiente, M ), cutUp(EstadoActual, P), \+member(EstSiguiente, CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [P, M|CaminoHastaAhora], CaminoTotal ).

solucionOptima(L):-
 	length(L, Length),
 	N is Length - 1,
    split(L, [P|_], R, N),
    camino([P, R, N], [_, _, 0], [], C),
    out(C), !.

solve(L):- append(X, Y, L), length(X, Length), Length > 0, append(Y, X, L1), solucionOptima(L1).%length(L, Length), between(1, Length, _), asd(L, L1). %, solucionOptima(L1).

asd([P, R, N], [P1, R1, N1]):- 

unPaso([P, R, N], [P1, R1, N1], M):- modify1(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1.	%UpRight
unPaso([P, R, N], [P1, R1, N1], M):- modify2(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1.	%UpLeft
unPaso([P, R, N], [P1, R1, N1], M):- modify3(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1.	%DownRight
unPaso([P, R, N], [P1, R1, N1], M):- modify4(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1.	%DownLeft
unPaso([P, R, N], [P1, R1, N1], M):- modify5(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1.	%Right
unPaso([P, R, N], [P1, R1, N1], M):- modify6(P, M, P1), seekDestroy(R, M, R1), N1 is N - 1.	%Left
