tokeny([], []).
tokeny([String | SubStrings], [Token, Sep | Tokeny]) :-
    atom_string(Atom, String),
    sub_atom(Atom, Before, 1, After, Char),
    Char = ';', %here we check if line ends with ';'
    Sep = sep(;),
    sub_atom(Atom, After, Before, _, Main),
    token(Main, Token),
    tokeny(SubStrings, Tokeny), 
    !.
tokeny([String | SubStrings], [Token | Tokeny]) :-
    atom_string(Atom, String),
    token(Atom, Token),
    !,
    tokeny(SubStrings, Tokeny).

token(String, key(String)) :- 
    member(String, ['read','write','if','then','else','fi','while','do','od','and','or','mod']),
    !.
token(String, int(Number)) :-
    atom_number(String, Number),
    integer(Number),
    !.
token(String, sep(String)) :-
    sep(String),
    !.
token(String, id(String)) :-
    atom_string(String, S),
    string_upper(S, S2),
    atom_string(A, S2),
    String = A,
    !.

sep(X) :- member(X, [';','+','-','*','/','(',')','<','>','=<','>=',':=','=','/=']), !.

scanner(Strumien, Tokeny) :-
    read_string(Strumien, _, String),
    split_string(String, " \n", "\n\t\s", SubStrings),
    tokeny(SubStrings, Tokeny),
    !.