:- include('tok_api.pl').
:- include('par_api.pl').
:- include('interpreter_by_Kob.pl').

wykonaj(NazwaPliku) :-
    open(NazwaPliku, 'read', Strumien),
    scanner(Strumien, Tokeny),
    close(Strumien),
    phrase(program(Program), Tokeny), 
    !,
    interpreter(Program).