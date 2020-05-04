program([]) --> [].
program([Instrukcja | Program]) -->
    !, instrukcja(Instrukcja), program(Program).

instrukcja(assign(ID, Wyrazenie)) --> 
    [id(ID)], [sep(:=)], wyrazenie(Wyrazenie), [sep(;)].
instrukcja(read(ID)) -->
    [key(read)], [id(ID)], [sep(;)].
instrukcja(write(Wyrazenie)) -->
    [key(write)], wyrazenie(Wyrazenie), [sep(;)].
instrukcja(if(Warunek, Program)) -->
    [key(if)], warunek(Warunek), [key(then)], program(Program), [key(fi)], [sep(;)].
instrukcja(if(Warunek, Program1, Program2)) -->
    [key(if)], warunek(Warunek), [key(then)], program(Program1), [key(else)], program(Program2), [key(fi)], [sep(;)].
instrukcja(while(Warunek, Program)) -->
    [key(while)], warunek(Warunek), [key(do)], program(Program), [key(od)], [sep(;)].

wyrazenie(Skladnik + Wyrazenie) -->
    skladnik(Skladnik), [sep(+)], wyrazenie(Wyrazenie).
wyrazenie(Skladnik - Wyrazenie) -->
    skladnik(Skladnik), [sep(-)], wyrazenie(Wyrazenie).
wyrazenie(Skladnik) -->
    skladnik(Skladnik).

skladnik(Czynnik * Skladnik) -->
    czynnik(Czynnik), [sep(*)], skladnik(Skladnik).
skladnik(Czynnik / Skladnik) -->
    czynnik(Czynnik), [sep(/)], skladnik(Skladnik).
skladnik(Czynnik mod Skladnik) -->
    czynnik(Czynnik), [sep(mod)], skladnik(Skladnik).
skladnik(Czynnik) -->
    czynnik(Czynnik).

czynnik(Identyfikator) -->
    [id(Identyfikator)].
czynnik(int(Liczba_naturalna)) -->
    [int(Liczba_naturalna)].
czynnik((Wyrazenie)) -->
    [sep('(')], wyrazenie(Wyrazenie), [sep(')')].

warunek(Koniunkcja ; Warunek) -->
    koniunkcja(Koniunkcja), [key(or)], warunek(Warunek).
warunek(Koniunkcja) -->
    koniunkcja(Koniunkcja).

koniunkcja(Prosty , Koniunkcja) -->
    prosty(Prosty), [key(and)], koniunkcja(Koniunkcja).
koniunkcja(Prosty) -->
    prosty(Prosty).

prosty(Wyrazenie1 =:= Wyrazenie2) -->
    wyrazenie(Wyrazenie1), [sep(=)], wyrazenie(Wyrazenie2).
prosty(Wyrazenie1 =\= Wyrazenie2) -->
    wyrazenie(Wyrazenie1), [sep(/=)], wyrazenie(Wyrazenie2).
prosty(Wyrazenie1 < Wyrazenie2) -->
    wyrazenie(Wyrazenie1), [sep(<)], wyrazenie(Wyrazenie2).
prosty(Wyrazenie1 > Wyrazenie2) -->
    wyrazenie(Wyrazenie1), [sep(>)], wyrazenie(Wyrazenie2).
prosty(Wyrazenie1 >= Wyrazenie2) -->
    wyrazenie(Wyrazenie1), [sep(>=)], wyrazenie(Wyrazenie2).
prosty(Wyrazenie1 =< Wyrazenie2) -->
    wyrazenie(Wyrazenie1), [sep(=<)], wyrazenie(Wyrazenie2).
prosty(Warunek) -->
    [sep('(')], warunek(Warunek), [sep(')')].

%%poprzedni scanner%%
scanner(Strumien, Tokeny) :-
    read_string(Strumien, _, String),
    string_codes(String, List),
    wybierz_token(List, Tokeny).

wybierz_token([], []).
wybierz_token([H | T], Tokeny) :-
    H > 96,
    H < 123,
    !,
    key(T, [H], Tokeny).
wybierz_token([H | T], Tokeny) :-
    atom_codes(Atom, [H]),
    member(Atom, [';','+','-','*','/','(',')','<','>','=',':']),
    !,
    sep(T, [H], Tokeny).
wybierz_token([H | T], Tokeny) :-
    H > 47,
    H < 58,
    !,
    int(T, [H], Tokeny).
wybierz_token([H | T], Tokeny) :-
    H > 64,
    H < 91,
    !,
    id(T, [H], Tokeny).
wybierz_token([H | T], Tokeny) :-
    atom_codes(Atom, [H]),
    member(Atom, ['\n', ' ', '\t']),
    !,
    wybierz_token(T, Tokeny).

key([H | T], Chs, Tokeny) :-
    H > 96,
    H < 123,
    append(Chs, [H], L),
    !,
    key(T, L, Tokeny).
key(L, Chs, [Token | Tokeny]) :-
    atom_codes(Atom, Chs),
    member(Atom, ['read','write','if','then','else','fi','while','do','od','and','or','mod']),
    Token = key(Atom),
    !,
    wybierz_token(L, Tokeny).

sep([H | T], Chs, Tokeny) :-
    atom_codes(Atom, [H]),
    member(Atom, [';','+','-','*','/','(',')','<','>','=',':']),
    append(Chs, [H], L),
    !,
    sep(T, L, Tokeny).
sep(L, Chs, [Token | Tokeny]) :-
    atom_codes(Atom, Chs),
    member(Atom, [';','+','-','*','/','(',')','<','>','=<','>=',':=','=','/=']),
    Token = sep(Atom),
    !,
    wybierz_token(L, Tokeny).

int([H | T], Chs, Tokeny) :-
    H > 47,
    H < 58,
    append(Chs, [H], L),
    !,
    int(T, L, Tokeny).
int(L, Chs, [Token | Tokeny]) :-
    atom_codes(Atom, Chs),
    atom_number(Atom, Number),
    Token = int(Number),
    !,
    wybierz_token(L, Tokeny).

id([H | T], Chs, Tokeny) :-
    H > 64,
    H < 91,
    append(Chs, [H], L),
    !,
    id(T, L, Tokeny).
id(L, Chs, [Token | Tokeny]) :-
    atom_codes(Atom, Chs),
    Token = id(Atom),
    !,
    wybierz_token(L, Tokeny).
