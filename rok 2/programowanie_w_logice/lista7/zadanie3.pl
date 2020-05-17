% nie wiem do końca czy dobrze interpretuje "Każdy filozof działa w następującej nieskończonej pętli" z zadania. 
% po pewnym, po paru pełnych obiadach, pętla się zatrzymuje podejrzewam, ze to kwestia przepełnienia stosu.
widelce('0', widelec4, widelec0).
widelce('1', widelec0, widelec1).
widelce('2', widelec1, widelec2).
widelce('3', widelec2, widelec3).
widelce('4', widelec3, widelec4).

filozofowie :-
    mutex_create(widelec0),
    mutex_create(widelec1),
    mutex_create(widelec2),
    mutex_create(widelec3),
    mutex_create(widelec4),
    thread_create(filozof(), _, [alias('0')]),
    thread_create(filozof(), _, [alias('1')]),
    thread_create(filozof(), _, [alias('2')]),
    thread_create(filozof(), _, [alias('3')]),
    thread_create(filozof(), _, [alias('4')]),
    thread_join('0', _),
    thread_join('1', _),
    thread_join('2', _),
    thread_join('3', _),
    thread_join('4', _),
    mutex_destroy(widelec0),
    mutex_destroy(widelec1),
    mutex_destroy(widelec2),
    mutex_destroy(widelec3),
    mutex_destroy(widelec4),
    filozofowie.

filozof :-
    thread_self(Who),
    format('[~w] mysli~n', [Who]),
    flush_output,
    format('[~w] chce prawy widelec~n', [Who]),
    flush_output,
    widelce(Who, Left, Right),
    mutex_lock(Right),
    format('[~w] podniosl prawy widelec~n', [Who]),
    flush_output,
    format('[~w] chce lewy widelec~n', [Who]),
    flush_output,
    mutex_lock(Left),
    format('[~w] podniosl lewy widelec~n', [Who]),
    flush_output,
    format('[~w] je~n', [Who]),
    flush_output,
    (   random_float>0.5
    ->  format('[~w] odklada prawy widelec~n', [Who]),
        flush_output,
        mutex_unlock(Right),
        format('[~w] odklada lewy widelec~n', [Who]),
        flush_output,
        mutex_unlock(Left)
    ;   format('[~w] odklada lewy widelec~n', [Who]),
        flush_output,
        mutex_unlock(Left),
        format('[~w] odklada prawy widelec~n', [Who]),
        flush_output,
        mutex_unlock(Right)
    ).