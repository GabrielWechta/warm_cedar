on(block1, block2).
on(block2, block3).
on(block3, block4).

above(X, Y) :- on(X, Y).
above(X, Y) :- on(X, Z), above(Z, Y).
