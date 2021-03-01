rybki(Kto) :-
    build_houses(Street),
    member(house(_,Kto,_,rybka,_,_), Street).

build_houses(Street):-
    Street = [
        house(1, _,  _,     _,   _,    _),
        house(2, _,  _,     _,   _,    _),
        house(3, _,  _,     _,   _,    _),
        house(4, _,  _,     _,   _,    _),
        house(5, _,  _,     _,   _,    _)],

    member(house(1,norweg,_,_,_,_), Street),
    member(house(_,anglik,_,_,_,czerwony), Street),
    member(house(A,_,_,_,_,zielony), Street),
    member(house(B,_,_,_,_,bialy), Street),
    left_of(A,B),
    member(house(_,dunczyk,_,_,herbata,_), Street),
    member(house(C,_,light,_,_,_), Street),
    member(house(D,_,_,kot,_,_), Street),
    next_to(C,D),
    member(house(_,_,cygaro,_,_,zolty), Street),
    member(house(_,niemiec,fajka,_,_,_), Street),
    member(house(3,_,_,_,mleko,_), Street),
    member(house(E,_,light,_,_,_), Street),
    member(house(F,_,_,_,woda,_), Street),
    next_to(E,F),
    member(house(_,_,bez_filtra,ptak,_,_), Street),
    member(house(_,szwed,_,pies,_,_), Street),
    member(house(G,norweg,_,_,_,_), Street),
    member(house(H,_,_,_,_,niebieski), Street),
    next_to(G,H),
    member(house(I,_,_,kon,_,_), Street),
    member(house(J,_,_,_,_,zolty), Street),
    next_to(I,J),
    member(house(_,_,mentolowe,_,piwo,_), Street),
    member(house(_,_,_,_,kawa,zielony), Street).
    
left_of(X, Y) :- X is Y-1.

next_to(X,Y) :- left_of(X,Y); left_of(Y,X).