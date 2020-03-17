% mozliwa, tzn. zawiera wszystkie liczby od 1 do N, kazda po dwa razy
mozliwa_lista(1, [1, 1]).
mozliwa_lista(N, L) :-
    N>1,
    K is N-1,
    mozliwa_lista(K, L2),
    select(N, L1, L2),
    append(F, [N|S], L1),
    select(N, S1, S),
    append(F, [N|S1], L).
    
% miedzy wystapieniami N
parzysta_odleglosc(N, L) :-
    member(N, L),
    append(_, [N|S], L),
    append(Mid, [N|_], S),
    length(Mid, Len),
    Len mod 2=:=0.

% tzn. dla kazdego i ze 0 < i < n, i pojawia sie przed pierwszym wystapieniem n
wszystkie_poprzednie(1, _).
wszystkie_poprzednie(N, L) :-
    N>1,
    K is N-1,
    append(F, [N|_], L),
    !,
    member(K, F),
    wszystkie_poprzednie(K, L).

lista(N, L) :-
    mozliwa_lista(N, L),
    \+ ( between(1, N, I),
         \+ ( parzysta_odleglosc(I, L),
              wszystkie_poprzednie(I, L)
            )
       ).