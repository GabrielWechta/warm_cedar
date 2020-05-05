PRzepisałem algorytm z zadania 2 na sparse matrix'y z pakietu scipy.
Napisałem również własną wersje dzielenia macierzy rzadkiej przez wektor (są dwie wersje nie wiem, która jest szybsza).
Wczytywanie danych z csv zrobiłem inaczej niż do zad1 i zad2, bo znalazłem, zdaje się, bardziej naturalny sposób join'a na dwóch array'ach, który niestety nie daje rady przy dużych tablicach (merge na id i pivot table).
Program działa parenasćie sekund po czym dostaje error - "Unstacked DataFrame is too big, causing int32 overflow".
Czytałem, że jest to wbudowane zabezpieczenie w pandas, którego nie sposób obejść.
Po stworzeniu sparse matrix algorytm już operuje tylko na niej ( i wektorze), nie rzutując na numpy.array.
Nastomiast nie potrafię wymyślić sposobu na stworzenie sparse matrix bez wcześniejszego zrobienia macierzy w numpy...

# tak napsiany algorytm dla starych danych z zad2 działa przynajmniej dwa razy szybciej.