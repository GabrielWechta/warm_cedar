my_last([X], X).
my_last([_|Tail], Ans) :-
    my_last(Tail, Ans),
    !.