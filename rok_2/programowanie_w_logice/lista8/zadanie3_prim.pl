:- use_module(library(clpfd)).

odcinek(List) :-
    length(List, 16),
    List ins 0..1,
    sum(List, #=, 8),
    label(List),
    conseciutive(List).

conseciutive([H1, H2, H3, H4, H5, H6, H7, H8|Tail]) :-
    (   ( H1 =\= 0,
          H1=H2,
          H2=H3,
          H3=H4,
          H4=H5,
          H5=H6,
          H6=H7,
          H7=H8
        ),
        !
    ;   append([H2, H3, H4, H5, H6, H7, H8], Tail, NewList),
        conseciutive(NewList)
    ).
    