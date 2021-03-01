merge(In1, In2, Out) :-
    freeze(In1, (freeze(In2, (
                            In1 = [Head1 | Tail1]
                            ->  (In2 = [Head2 | Tail2]
                                -> (Head1 =< Head2 
                                    ->  Out = [Head1 | T],
                                        merge(Tail1, In2, T)
                                    ;   Out = [Head2 | T],
                                        merge(In1, Tail2, T))
                                ;   Out = In1)
                            ;   Out = In2
                            )))).