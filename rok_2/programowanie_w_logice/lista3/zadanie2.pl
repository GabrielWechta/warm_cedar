% Kadane's algorithm
max_sum(List, Sum) :-
    max_sum(List, 0, 0, Sum).

max_sum([], _, Sum, Sum).

max_sum([H | T], High, Last, Ans) :-
    Current is max(0, High + H),
    (Last < High + H -> 
        Best is Current; 
        Best is Last),
    max_sum(T, Current, Best, Ans).