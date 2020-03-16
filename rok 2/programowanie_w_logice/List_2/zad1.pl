is_even(List) :-
    length(List, Y),
    Y mod 2=:=1.

srodkowy(List, MiddleElement) :-
    is_even(List),
    length(List, Len),
    divmod(Len, 2, Quotient, Remainder),
    N is Quotient + Remainder,
    nth1(N, List, MiddleElement).