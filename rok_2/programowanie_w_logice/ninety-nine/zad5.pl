my_reverse(L1,L2) :- my_rev(L1,L2,[]).

my_rev([], L2, L2) :- !.
my_rev([Head | Tail], L2, Acc):- 
    my_rev(Tail, L2, [Head|Acc]).