board(L) :-
    length(L, Size),
    forall(between(1, Size, N),
           (   N mod 2=:=1
           ->  row1(Size, N, L)
           ;   row2(Size, N, L)
           )),
    draw_up(Size).
    
row1(Size, N, L) :-
    RowN is Size-N+1,
    draw_up(Size),
    (   Size mod 2=:=0
    ->  forall(between(1, Size, ColN),
               (   ColN mod 2=:=1
               ->  draw_white(RowN, ColN, L)
               ;   draw_black(RowN, ColN, L)
               )),
        write('|'),
        nl,
        forall(between(1, Size, ColN),
               (   ColN mod 2=:=1
               ->  draw_white(RowN, ColN, L)
               ;   draw_black(RowN, ColN, L)
               )),
        write('|'),
        nl
    ;   forall(between(1, Size, ColN),
               (   ColN mod 2=:=1
               ->  draw_black(RowN, ColN, L)
               ;   draw_white(RowN, ColN, L)
               )),
        write('|'),
        nl,
        forall(between(1, Size, ColN),
               (   ColN mod 2=:=1
               ->  draw_black(RowN, ColN, L)
               ;   draw_white(RowN, ColN, L)
               )),
        write('|'),
        nl
    ).


row2(Size, N, L) :-
    RowN is Size-N+1,
    draw_up(Size),
    (   Size mod 2=:=0
    ->  forall(between(1, Size, ColN),
               (   ColN mod 2=:=0
               ->  draw_white(RowN, ColN, L)
               ;   draw_black(RowN, ColN, L)
               )),
        write('|'),
        nl,
        forall(between(1, Size, ColN),
               (   ColN mod 2=:=0
               ->  draw_white(RowN, ColN, L)
               ;   draw_black(RowN, ColN, L)
               )),
        write('|'),
        nl
    ;   forall(between(1, Size, ColN),
               (   ColN mod 2=:=0
               ->  draw_black(RowN, ColN, L)
               ;   draw_white(RowN, ColN, L)
               )),
        write('|'),
        nl,
        forall(between(1, Size, ColN),
               (   ColN mod 2=:=0
               ->  draw_black(RowN, ColN, L)
               ;   draw_white(RowN, ColN, L)
               )),
        write('|'),
        nl
    ).
    

draw_up(0) :-
    write(+),
    nl.
draw_up(N) :-
    N>0,
    write(+-----),
    N2 is N-1,
    draw_up(N2).

draw_white(RowN, ColN, L) :-
    nth1(ColN, L, RowN),
    write('| ### ').
draw_white(_, _, _) :-
    write('|     ').

draw_black(RowN, ColN, L) :-
    nth1(ColN, L, RowN),
    write('|:###:').
draw_black(_, _, _) :-
    write('|:::::').

perm([], []).
perm(L1, [X|L3]) :-
    select(X, L1, L2),
    permutation(L2, L3).

dobra(X) :-
    \+ zla(X).

zla(X) :-
    append(_, [Wi|L1], X),
    append(L2, [Wj|_], L1),
    length(L2, K),
    abs(Wi-Wj)=:=K+1.

hetmany(N, P) :-
    numlist(1, N, L),
    perm(L, P),
    dobra(P).