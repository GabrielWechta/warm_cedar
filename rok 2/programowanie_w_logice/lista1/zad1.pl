/*mamy:*/
ojciec(bóg, jezus).
matka(maria, jezus).
mężczyzna(jezus).
kobieta(maria).
rodzic(bóg, jezus).

jest_matką(X) :-
    matka(X, _).
jest_ojcem(X) :-
    ojciec(X, _).
jest_synem(X) :-
    mężczyzna(X),
    rodzic(_, X).
siostra(X, Y) :-
    kobieta(X),
    rodzic(Z, X),
    rodzic(Z, Y).
dziadek(X, Y) :-
    ojciec(X, Z),
    rodzic(Z, Y).
rodzeństwo(X, Y) :-
    X\=Y,
    rodzic(Z, X),
    rodzic(Z, Y).
