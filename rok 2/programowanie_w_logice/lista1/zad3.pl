direct_above(bicycle, pencil).
direct_above(camera, butterfly).
direct_left_of(pencil, hourglass).
direct_left_of(hourglass, butterfly).
direct_left_of(butterfly, fish).


left_of(X, Y) :-
    direct_left_of(X, Y).

left_of(X, Y) :-
    direct_left_of(X, Z),
    left_of(Z, Y).

above(X, Y) :-
    direct_above(X, Y).

above(X, Y) :-
    direct_above(X, Z),
    above(Z, Y).

right_of(X, Y) :-
    left_of(Y, X).

below(X, Y) :-
    above(Y, X).

higher(X, Y) :-
    (   left_of(Z, Y)
    ;   right_of(Z, Y)
    ),
    above(X, Z).

higher(X, Y) :-
    above(X, Y).