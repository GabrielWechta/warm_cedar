show(_, 25).
show(List, N) :-
    N<25,
    (   member(N, [1, 8, 15, 22])
    ->  write(+)
    ;   write('')
    ),
    (   member(N, [1, 2, 3, 8, 9, 10, 15, 16, 17, 22, 23, 24])
    ->  (   member(N, List)
        ->  write('   +')
        ;   write(---+)
        )
    ;   write('')
    ),
    (   member(N, [4, 5, 6, 7, 11, 12, 13, 14, 18, 19, 20, 21])
    ->  (   member(N, List)
        ->  write('    ')
        ;   write('|   ')
        )
    ;   write('')
    ),
    (   member(N, [3, 7, 10, 14, 17, 21, 24])
    ->  nl
    ;   write('')
    ),
    N2 is N+1,
    show(List, N2).

squares(_, 0, List, List).
squares(Edges, N, List, Ans) :-
    N>0,
    select(X, Edges, L),
    union(List, X, Ans2),
    N2 is N-1,
    squares(L, N2, Ans2, Ans).

big(List) :-
    numlist(1, 24, L1),
    Edges=[1, 2, 3, 7, 14, 21, 24, 23, 22, 18, 11, 4],
    subtract(L1, Edges, List).

medium(N, List) :-
    numlist(1, 24, L1),
    Edges=[[1, 2, 6, 13, 16, 15, 11, 4], [2, 3, 7, 14, 17, 16, 12, 5], [8, 9, 13, 20, 23, 22, 18, 11], [9, 10, 14, 21, 24, 23, 19, 12]],
    squares(Edges, N, [], Ans),
    subtract(L1, Ans, List).

small(N, List) :-
    numlist(1, 24, L1),
    Edges=[[1, 5, 8, 4], [2, 6, 9, 5], [3, 10, 7, 6], [8, 12, 15, 11], [9, 13, 16, 12], [10, 14, 17, 13], [15, 19, 22, 18], [16, 20, 23, 19], [17, 21, 24, 20]],
    squares(Edges, N, [], Ans),
    subtract(L1, Ans, List).

zapalki(N, Squares) :-
    Squares=(duze(1), srednie(S), male(M)),
    big(ListB),
    medium(S, ListM),
    small(M, ListS),
    intersection(ListB, ListM, L1),
    intersection(L1, ListS, L2),
    length(L2, N),
    show(L2, 1).

zapalki(N, Squares) :-
    Squares=(srednie(S), male(M)),
    medium(S, ListM),
    small(M, ListS),
    intersection(ListM, ListS, L2),
    length(L2, N),
    show(L2, 1).

zapalki(N, Squares) :-
    Squares=(duze(1), srednie(S)),
    big(ListB),
    medium(S, ListM),
    intersection(ListB, ListM, L1),
    length(L1, N),
    show(L1, 1).

zapalki(N, Squares) :-
    Squares=(duze(1), male(M)),
    big(ListB),
    small(M, ListS),
    intersection(ListB, ListS, L2),
    length(L2, N),
    show(L2, 1).
