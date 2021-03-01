:- include('zadanie1.pl').

split(In, Out1, Out2) :-
	freeze(In, (
		In = [Head1 | In1]
		-> 	freeze(In1, (
				In1 = [Head2 | In2]
				->	Out1 = [Head1 | Tail1],
					Out2 = [Head2 | Tail2],
					split(In2, Tail1, Tail2)
				;	Out1 = [Head1],
					Out2 = []
				))
		;	Out1 = [],
			Out2 = []
		)).

merge_sort(In, Out) :-
	freeze(In, (
		In = [_ | Tail1]
		->	freeze(Tail1, (
            Tail1 = [_ | _]
			->	
				split(In, Splitted1, Splitted2), 
				merge_sort(Splitted1, Merged1),
				merge_sort(Splitted2, Merged2),
				merge(Merged1, Merged2, Out)
            ;	Out = In
        ))
			;	Out = []
		)
	).