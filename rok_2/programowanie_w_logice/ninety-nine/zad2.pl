almost_last([Y, _], Y).
almost_last([_|Tail], Ans) :-
    almost_last(Tail, Ans), !.
