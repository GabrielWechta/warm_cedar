le(1, 1).
le(1, 2).
le(1, 3).
le(2, 2).
le(2, 3).
le(3, 3).

le(1, a1).
le(2, a1).
le(a1, a1).

zwrotny :-
    \+ ( (   le(X, _)
         ;   le(_, X)
         ),
         \+ le(X, X)
       ).
przechodni :-
    \+ ( ( le(X, Y),
           le(Y, Z)
         ),
         \+ le(X, Z)
       ).

slabo_antysymetryczny :-
    \+ ( le(X, Y),
         le(Y, X),
         X\=Y
       ).

czesciowy_porzadek :-
    zwrotny,
    przechodni,
    slabo_antysymetryczny.