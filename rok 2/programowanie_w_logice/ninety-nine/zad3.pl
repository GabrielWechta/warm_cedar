element_at([Head|_], Head, 0).
element_at([_|Tail], Ans, K) :-
    K1 is K-1,
    element_at(Tail, Ans, K1),
    !.