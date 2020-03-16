arc(a, b).
arc(b, a).
arc(b, c).
arc(c, d).


osiagalny(X, Y) :-
    osiagalny(X, Y, [X]).
   
osiagalny(X, X, Visited).
   
osiagalny(X, Y, Visited) :-
    arc(X, N),
    not(member(N, Visited)),
    osiagalny(N, Y, [N|Visited]).