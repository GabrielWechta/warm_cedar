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
