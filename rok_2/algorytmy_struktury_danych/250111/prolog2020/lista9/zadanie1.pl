% Dla przykładowych danych, program zwraca inny wynik, ale również optymalny.
% Program akceptuje również wynik z przykładu do zadania.
:- use_module(library(clpfd)).
tasks([
    %D R1 R2
    [2, 1, 3],
    [3, 2, 1],
    [4, 2, 2],
    [3, 3, 2],
    [3, 1, 1],
    [3, 4, 2],
    [5, 2, 1]]).

%         R1 R2
resources(5, 5).

schedule(Horizon, Starts, MakeSpan):-
    Starts = [S1, S2, S3, S4, S5, S6, S7],
    Starts ins 0..Horizon,
    resources(Res1, Res2),
    tasks([[D1,X1,Y1],[D2,X2,Y2],[D3,X3,Y3],[D4,X4,Y4],[D5,X5,Y5],[D6,X6,Y6],[D7,X7,Y7]]),
    Tasks_x = [task(S1,D1,E1,X1,_),
    task(S2,D2,E2,X2,_),
    task(S3,D3,E3,X3,_),
    task(S4,D4,E4,X4,_),
    task(S5,D5,E5,X5,_),
    task(S6,D6,E6,X6,_),
    task(S7,D7,E7,X7,_)],

    Tasks_y = [task(S1,D1,E1,Y1,_),
    task(S2,D2,E2,Y2,_),
    task(S3,D3,E3,Y3,_),
    task(S4,D4,E4,Y4,_),
    task(S5,D5,E5,Y5,_),
    task(S6,D6,E6,Y6,_),
    task(S7,D7,E7,Y7,_)],

    cumulative(Tasks_x, [limit(Res1)]),
    cumulative(Tasks_y, [limit(Res2)]),

    MakeSpan #= max(max(max(max(max(max(E1,E2),E3),E4),E5),E6),E7),
    once(labeling([min(MakeSpan)], Starts)).






