Zadanie 1:
Implementacja opiera się o dwie klasy HeapQueue i Element. Złożoność wszytskich operacji oprócz print jest O(log n).
Program na std inpucie przyjmuje m - liczbę operacji i następnie czeka na operacje.

W zadaniach 2 i 3 nie korzystam z mojej implementacji HeapQueue, a z wbudowanego modułu pythona 3.8 - heapq, ze względu na szybkość i niską wagę w porównaniu z moim kodem. Sprawdziłem, że dla wszystkich zastosowań moja implementacja działa, natomiast heapq po prostu działa szybciej.

Zadanie 2:
W zadaniu 2 na standardowym wejściu przyjmujemy {n, m, (u, v, w) * m, wierzchołek startowy}. Tym samym pliki testowe ze strony dr. Gołębiewskiego należy rozszerzyć o dodatkową linijkę z wierzchołkiem startowym.

Program implementuje algorytm Dijkstry (wersja Cormena) przy użyciu:
- słownika z listami do reprezentacji grafu,
- heapq do kolejki priorytetowej, gdzie priorytet wyznacza waga krawędzi,
- zbioru (klasy set) do zapisywania już odwiedzonych weirzchołków.

Z jakiegoś powodu python czasami wypisywał wartości float z dużą liczbą '0' na końcu. Stąd linijka:
         print(id_node, round(path_cost, 8))

Zadanie 3:
Reprezentacja grafu jest podobna jak poprzednio przy czym krawędzie są dodawane symetrycznie do słownika.
Tym razem algorytmy Prima i Kruskela pochodzą z Dasgupty. Krsukel to niemal kopia Djikstry, z drobną zmianą przy lcizeniu kosztu, natomiast Prim korzysta z tablicy ojców do reprezentacji należenia do zbioru.
Wierzchołek startowy jest wybierany losowo.

Zadanie 4:
Do generowaniu grafów pełnych z zachowaniem własności trójkąta jest program edges_generator.py, który jako argument przyjmuje n - liczbę wierzchołków i generuje wszytskie możliwe połaczenia w jedną stronę. To wystarczy, zad4.py poradzi osbie i doda je symetrycznie. Aby zachować własność trójkąta, waga wygenerowanej krawędzi to odległość euklidesowa między wierzchołkami.

Przykładowe wywołanie: 
	python3 edges_generator.py 12 | python3 zad4.py 

Wierzchołek startowy jest wybieranu z zakresu (0, n-1)

Z powodów, które zawarłem w mailu nie udało mi się rozwiązać tego zadania do końca (nie napisałem ostatniego przeszukiwania). 

Wyniki testów zawierają się w plikach 5*.txt. Przy 50000 dostałem broken_pipe error z linuxa. Dla innego formatu 

