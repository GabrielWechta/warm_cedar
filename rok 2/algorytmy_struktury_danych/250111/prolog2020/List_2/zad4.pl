%%%%%%%%%%%%%/%%%%%%%%%%%%%
reguła(X, /, Y, X) :- %Y==1
    number(Y),
    Y=:=1,
    !.
reguła(X, /, _, 0) :- %X==0
    number(X),
    X=:=0,
    !.
reguła(_, /, Y, -1) :- %Y==0
    number(Y),
    Y=:=0,
    write("You are divining by zero! Are you sane?!"),
    !.

reguła(X, /, Y, 1) :- %Y==X
    Y==X,
    !.

reguła(X, /, Y, Z) :- %normal dividing
    X=..Temp,
    member(Y, Temp),
    delete(Temp, Y, Fixed),
    append([Fixed, [1]], G),
    T=..G,
    uprość(T, Z),
    !.

reguła(X, /, Y, X/Y). %catchfall

%%%%%%%%%%%%%*%%%%%%%%%%%%%
reguła(X, *, Y, Y) :- %X==1
    number(X),
    X=:=1,
    !.
reguła(X, *, Y, X) :- %Y==1
    number(Y),
    Y=:=1,
    !.
reguła(X, *, _, 0) :- %X==0
    number(X),
    X=:=0,
    !.
reguła(_, *, Y, 0) :- %Y==0
    number(Y),
    Y=:=0,
    !.
reguła(X, *, Y, X*Y). %catchfall
%%%%%%%%%%%%+%%%%%%%%%%%%
reguła(X, +, Y, Y) :- %X==0
    number(X),
    X=:=0,
    !.
reguła(X, +, Y, X) :- %Y==0
    number(Y),
    Y=:=0,
    !.

reguła(X, +, Y, X+Y). %catchfall

%%%%%%%%%%%%%%-%%%%%%%%%%%%
reguła(X, -, Y, Y) :- %X==0
    number(X),
    X=:=0,
    !.
reguła(X, -, Y, X) :- %Y==0
    number(Y),
    Y=:=0,
    !.

reguła(X, -, Y, 0) :- %Y==X
    Y==X,
    !.

reguła(X, -, Y, X-Y). %catchfall

%%%%%%%%%%%%%%%%%%%%%%%%%%%
uprość(E, E) :-
    (   atomic(E)
    ;   number(E),
        !
    ).
uprość(E, F) :-
    E=..[Op, La, Ra],
    uprość(La, X),
    uprość(Ra, Y),
    reguła(X, Op, Y, F).