how_many(List, Ans) :-
    count(List, 0, Ans).

count([], Same, Same).
count([_|Tail], Acum, Ans) :-
    Acum_new is Acum+1,
    count(Tail, Acum_new, Ans).