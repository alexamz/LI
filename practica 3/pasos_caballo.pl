camino( E,E, C,C, _, P, P).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal, N, P, PMAX):-
  unPaso(EstadoActual, EstSiguiente, N), NP is P + 1,
  \+member(EstSiguiente,CaminoHastaAhora),
  camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal, N, NP, PMAX ).

solucionOptima:-
camino([0, 0], [3, 3], [[0, 0]], C, 4, 0, 2), %-estado: [P ini,P fi]. Vars auxiliares: N tablero, P pasosHastaAhora, P MaximoPasos]
write(C), !.

constraint(N, NX, NY):- NX >= 0, NX =< N - 1, NY >= 0, NY =< N - 1.

unPaso([X, Y], [NX, NY], N):- NX is X - 1, NY is Y + 2, constraint(N, NX, NY).			%1 izq 2 arriba
unPaso([X, Y], [NX, NY], N):- NX is X + 1, NY is Y + 2, constraint(N, NX, NY).        	%1 der 2 arriba
unPaso([X, Y], [NX, NY], N):- NX is X - 1, NY is Y - 2, constraint(N, NX, NY).        	%1 izq 2 abajo
unPaso([X, Y], [NX, NY], N):- NX is X + 1, NY is Y - 2, constraint(N, NX, NY).			%1 der 2 abajo

unPaso([X, Y], [NX, NY], N):- NX is X - 2, NY is Y + 1, constraint(N, NX, NY).        	%2 izq 1 arriba
unPaso([X, Y], [NX, NY], N):- NX is X + 2, NY is Y + 1, constraint(N, NX, NY).       	%2 der 1 arriba
unPaso([X, Y], [NX, NY], N):- NX is X - 2, NY is Y - 1, constraint(N, NX, NY).			%2 izq 1 abajo
unPaso([X, Y], [NX, NY], N):- NX is X + 2, NY is Y - 1, constraint(N, NX, NY).        	%2 der 1 abajo
