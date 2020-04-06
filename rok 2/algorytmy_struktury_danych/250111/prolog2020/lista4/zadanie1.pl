wyrażenie(List, Value, X) :-
    undress(List, X),
    good(X, Value).

good(Wyrażenie, Wartość) :-
    Wynik is Wyrażenie,
    Wynik =:= Wartość.

undress([X], X).
undress(Expr, X + Y) :-
    append([L|Left], [R|Right], Expr),
    undress([L|Left], X),
    undress([R|Right], Y).
undress(Expr, X * Y) :-
    append([L|Left], [R|Right], Expr),
    undress([L|Left], X),
    undress([R|Right], Y).
undress(Expr, X - Y) :-
    append([L|Left], [R|Right], Expr),
    undress([L|Left], X),
    undress([R|Right], Y).
undress(Expr, X / Y) :-
    append([L|Left], [R|Right], Expr),
    undress([L|Left], X),
    undress([R|Right], Y),
    IsZero is Y,
    \+ IsZero =:= 0.