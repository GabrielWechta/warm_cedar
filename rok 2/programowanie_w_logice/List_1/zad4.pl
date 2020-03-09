le(1, 1).
le(1, 2).
le(1, 3).
le(2, 2).
le(2, 3).
le(3, 3).

le(1, a1).
le(2, a1).
le(a1, a1).

maksymalny(X) :-
    le(X, X),
    \+ ( le(X, Y),
         X\=Y
       ).
    
minimalny(X) :-
    le(X, X),
    \+ ( le(Y, X),
         X\=Y
       ).

najwiekszy(X) :-
    maksymalny(X),
    \+ ( maksymalny(Y),
         X\=Y
       ).
najmniejszy(X) :-
    minimalny(X),
    \+ ( minimalny(Y),
         X\=Y
       ).