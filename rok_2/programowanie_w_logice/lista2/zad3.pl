arc(a, b).
arc(b, a).
arc(b, c).
arc(c, d).


osiągalny(X, Y) :-
    osiągalny(X, Y, [X]).
   
osiągalny(X, X, Visited).
   
osiągalny(X, Y, Visited) :-
    arc(X, N),
    not(member(N, Visited)),
    osiągalny(N, Y, [N|Visited]).