:- use_module(library(clpfd)).

plecak(Wartosci, Wielkosc, Pojemnosc, Zmienne):-
    length(Wielkosc, N),
    length(Zmienne, N),
    Zmienne ins 0..1,
    scalar_product(Wielkosc, Zmienne, #=<, Pojemnosc),
    scalar_product(Wartosci, Zmienne, #=, VM),
    once(labeling([max(VM)], Zmienne)).