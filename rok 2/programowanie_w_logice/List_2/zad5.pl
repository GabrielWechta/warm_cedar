pierwsza([1], 1).

pierwsza(L, N) :-
    append(L1, [N | _], L),
    \+ member(N, L1),
    X is N - 1,
    pierwsza(L1, X).

zla(L) :-
    append(_, [X | L1], L),
    append(L2, [X | _], L1),
    length(L2, N),
    N mod 2 =:= 1.

lista(N, X) :-
    numlist(1, N, L),
    append(L, L, P),
    permutation(X, P),
    \+ zla(X),
    pierwsza(X, N).