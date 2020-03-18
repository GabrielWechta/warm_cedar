possible(1, [1, 1]).
possible(N, L) :- %smart generator 2*N lists
    N>1,
    K is N-1,
    possible(K, L2),
    select(N, ListAppended, L2),
    append(F, [N|S], ListAppended),
    select(N, S1, S),
    append(F, [N|S1], L).
    
even(N, L) :- % even number of numbers between Ns
    member(N, L),
    append(_, [N|S], L),
    append(Middle, [N|_], S),
    length(Middle, Length),
    Length mod 2=:=0.

all_previous(1, _).
all_previous(N, L) :- %checker - if k ∈ {1, 2, . . . , n}, than all 1, 2, . . . , k − 1 appeard before
    N>1,
    K is N-1,
    append(F, [N|_], L),
    !,
    member(K, F),
    all_previous(K, L).

lista(N, L) :-
    possible(N, L),
    \+ ( between(1, N, I), %for every I check our rules
         \+ ( even(I, L),
              all_previous(I, L)
            )
       ).