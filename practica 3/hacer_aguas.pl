camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
  unPaso( EstadoActual, EstSiguiente ),
  \+member(EstSiguiente,CaminoHastaAhora),
  camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
nat(N), % Buscamos soluci ́on de "coste" 0; si no, de 1, etc. 
camino([0,0],[0,4],[[0,0]],C), % En "hacer aguas": -un estado es [cubo5,cubo8],
length(C,N), % -el coste es la longitud de C.
write(C), !.

nat(0).
nat(N) :- nat(M), N is M + 1.

unPaso([_, B], [5, B]).		 					%llenar el de 5
unPaso([A, _], [A, 8]). 						%llenar el de 8
unPaso([_, B], [0, B]). 						%vaciar el de 5
unPaso([A, _], [A, 0]). 						%vaciar el de 8
unPaso([A, B], [0, TB]):- TB is A + B, TB =< 8. 			%verter 5 sobre 8 sin desborde
unPaso([A, B], [TA, 8]):- TT is A + B, TA is A - (8 - B), TT > 8.  	%verter 5 sobre 8 con desborde
unPaso([A, B], [TA, 0]):- TA is A + B, TA =< 5. 			%verter 8 sobre 5 sin desborde
unPaso([A, B], [5, TB]):- TT is A + B, TB is B - (5 - A), TT > 5. 	%verter 8 sobre 5 con desborde



