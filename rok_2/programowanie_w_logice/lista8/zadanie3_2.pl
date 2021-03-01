:- use_module(library(clpfd)).

odcinek(List):-
    length(List, 8),
    List ins 0..1,
    sum(List, #=, 4),
    consecutive(List).

consecutive([H1, H2, H3, H4 | Tail]):-
    (H1 == 1 ->
        chain([H1, H2, H3, H4], #=)
        ;
        true
    ),
    append([H2, H3, H4], Tail, NewList),
    % writeln([H1, H2, H3, H4]),
    % writeln(Tail),
    % chain([H1, H2, H3, H4], #=),

    % sum(NewList, #=, 3),
    writeln(NewList),
    consecutive(NewList).
    
    
    