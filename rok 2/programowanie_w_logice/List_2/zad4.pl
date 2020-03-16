%%%%%%%%%%%%%/%%%%%%%%%%%%%
s(/, X, Y, X) :- %Y==1
    number(Y),
    Y=:=1,
    !.
s(/, X, _, 0) :- %X==0
    number(X),
    X=:=0,
    !.
s(/, _, Y, -1) :- %Y==0
    number(Y),
    Y=:=0,
    write("You are divining by zero! Are you sane?!"),
    !.

s(/, X, Y, 1) :- %Y==X
    Y==X,
    !.

s(/, X, Y, Z) :- %normal dividing
    X=..Temp,
    member(Y, Temp),
    delete(Temp, Y, Fixed),
    append([Fixed, [1]], G),
    T=..G,
    simp(T, Z),
    !.

s(/, X, Y, X/Y). %catchfall

%%%%%%%%%%%%%*%%%%%%%%%%%%%
s(*, X, Y, Y) :- %X==1
    number(X),
    X=:=1,
    !.
s(*, X, Y, X) :- %Y==1
    number(Y),
    Y=:=1,
    !.
s(*, X, _, 0) :- %X==0
    number(X),
    X=:=0,
    !.
s(*, _, Y, 0) :- %Y==0
    number(Y),
    Y=:=0,
    !.
s(*, X, Y, X*Y). %catchfall
%%%%%%%%%%%%+%%%%%%%%%%%%
s(+, X, Y, Y) :- %X==0
    number(X),
    X=:=0,
    !.
s(+, X, Y, X) :- %Y==0
    number(Y),
    Y=:=0,
    !.

s(+, X, Y, X+Y). %catchfall

%%%%%%%%%%%%%%-%%%%%%%%%%%%
s(-, X, Y, Y) :- %X==0
    number(X),
    X=:=0,
    !.
s(-, X, Y, X) :- %Y==0
    number(Y),
    Y=:=0,
    !.

s(-, X, Y, 0) :- %Y==0
    Y==X,
    !.

s(-, X, Y, X-Y). %catchfall

%%%%%%%%%%%%%%%%%%%%%%%%%%%
simp(E, E) :-
    (   atomic(E)
    ;   number(E),
        !
    ).
simp(E, F) :-
    E=..[Op, La, Ra],
    simp(La, X),
    simp(Ra, Y),
    s(Op, X, Y, F).