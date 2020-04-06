inversions(_, [], 0).
inversions(X, [Head|Tail], Counter):-
    inversions(X, Tail, TmpCounter),
    (X > Head -> Counter is TmpCounter + 1; Counter is TmpCounter).

parity([], 0).
parity([Head|Tail], Ans):-
    parity(Tail, TmpAns),
    inversions(Head, Tail, Output),
    Ans is TmpAns + Output.
    
even_permutation(List, X):-
    permutation(List, X),
    parity(X, Parity),
    Parity mod 2 =:= 0.

odd_permutation(List, X):-
    permutation(List, X),
    parity(X, Parity),
    Parity mod 2 =:= 1.
    