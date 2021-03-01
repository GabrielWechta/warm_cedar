:- use_module(library(clpfd)).

odcinek(List):-
    List = [P15, P14,P13,P12,P11,P10,P9,P8,P7,P6,P5,P4,P3,P2,P1,P0],
    List ins 0..1,
    % sum(List, #=, 8),
    Value is 1111111100000000,
    to_num(List, Value),
    write(List);
    Value is 111111110000000,
    to_num(List, Value),
    write(List).

    % Value = 11111111;
    % Value = 111111110;
    % Value = 1111111100;
    % Value = 11111111000;
    % Value = 111111110000;
    % Value = 1111111100000;
    % Value = 11111111000000;
    
    
    
    
    
to_num([P15, P14,P13,P12,P11,P10,P9,P8,P7,P6,P5,P4,P3,P2,P1,P0], Value):-
    P15*1000000000000000 + P14*100000000000000 + P13*10000000000000 + P12*1000000000000 + P11*100000000000 + P10 * 10000000000 + P9 * 1000000000 + P8 * 100000000
    + P7 * 10000000 + P6 * 1000000 + P5 * 100000 + P4 * 10000 + P3* 1000 + P2* 100 + P1*10 + P0 == Value.
    

    