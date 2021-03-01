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

czynnik(id(Identyfikator)) -->
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