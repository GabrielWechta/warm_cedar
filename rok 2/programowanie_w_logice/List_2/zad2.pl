jednokrotnie(List,X):-
    findall([X,L], (bagof(true,member(X,List),Xs), length(Xs,L)), Occ),
    member([X,1],Occ).

dwukrotnie(List,X):-
    findall([X,L], (bagof(true,member(X,List),Xs), length(Xs,L)), Occ),
    member([X,2],Occ).