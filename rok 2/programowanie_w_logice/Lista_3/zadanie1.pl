mySum([], 0).
mySum([H|T], Sum) :-
    mySum(T, Rest),
    Sum is H+Rest.

average(List, Ave) :-
    mySum(List, Sum),
    length(List, Len),
    Ave is Sum/Len.

wariancja3([], _, 0).
wariancja3([H|T],Ave,D):-
    wariancja3(T,Ave,Rest),
    D is (H-Ave)**2 + Rest.
       
wariancja(List, Variance) :-
    average(List, Ave),
    wariancja3(List, Ave, D),
    length(List, Len),
    Variance is D/Len.

