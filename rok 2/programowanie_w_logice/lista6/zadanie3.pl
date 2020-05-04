ab(X) --> ab(X, 0, X, 0).
ab(Z, Z, Z, Z) --> ``.
ab(A, Acum, B, Bcum) --> `a`, {N is Acum + 1}, ab(A, N, B, Bcum).
ab(A, Acum, B, Bcum) --> `b`, {N is Bcum + 1}, ab(A, Acum, B, N).

abc(X) --> abc(X, 0, X, 0, X, 0).
abc(Z, Z, Z, Z, Z, Z) --> ``.
abc(A, Acum, B, Bcum, C, Ccum) --> `a`, {N is Acum + 1}, abc(A, N, B, Bcum, C, Ccum).
abc(A, Acum, B, Bcum, C, Ccum) --> `b`, {N is Bcum + 1}, abc(A, Acum, B, N, C, Ccum).
abc(A, Acum, B, Bcum, C, Ccum) --> `c`, {N is Ccum + 1}, abc(A, Acum, B, Bcum, C, N).

fib(0,1).
fib(1,1).
fib(N, X) :-
    N > 1,
	N1 is N - 1,
	N2 is N - 2,
	fib(N1, F1),
	fib(N2, F2),
    X is F1+F2, 
    !.

abfib(X) --> abfib(X, 0, F, 0), {fib(X, F)}.
abfib(Z, Z, F, F) --> ``.
abfib(A, Acum, B, Bcum) --> `a`, {N is Acum + 1}, abfib(A, N, B, Bcum).
abfib(A, Acum, B, Bcum) --> `b`, {N is Bcum + 1}, abfib(A, Acum, B, N).