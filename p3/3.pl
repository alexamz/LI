shopping(K, LP):- addProducts(N), between(1, K, M), subsetOfSize(M, N, LN), exactNNut(LN), getP(LN, LP).

exactNNut(LN):- insInL(LN, L), length(L, N1), numNutrients(N1).

getP([], []).
getP([L|LN], [Y|LP]):- getP(LN, LP), findall(X, product(X,L), Y).  

union([],L,L).
union([X|L1],L2, L3 ):- member(X,L2),!, union(L1,L2,L3).
union([X|L1],L2,[X|L3]):- union(L1,L2,L3).

subsetOfSize(0, _, []):- !.
subsetOfSize(N, [X|L], [X|S]):- N1 is N-1, length(L, Leng), Leng >= N1, subsetOfSize(N1, L, S).
subsetOfSize(N, [_|L],    S ):-            length(L, Leng), Leng >= N,  subsetOfSize( N, L, S).

insInL([], []).
insInL([X|L], L1):- insInL(L, L2), union(X, L2, L1).

addProducts(N):- findall(Y, product(_, Y), N).
numNutrients(8).
product(milk, 	[2, 4, 6]).
product(meat, 	[1, 8]).
product(fish, 	[3, 5, 6]).
product(carrot, [7, 8]).
product(tomato, [2, 5]).
product(oil, 	[1, 7, 8]).
product(bread, 	[3, 4]).