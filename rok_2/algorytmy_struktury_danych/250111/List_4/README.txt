Aby wykonać program należy odpalić skrypt main.sh z takimi deskryptorami jak w poleceniu (np. bash main.sh --type rbt <input.txt >output.txt).
możliwe flagi: --type bst | rbt | hmap

zadanie 1:
Binary Search Tree oraz Red-Black Tree są zaimplementowane według pseudokodu z książki Cormen'a.
Hash Table jest zrobiona tak, że klasa HashTable z pakietu hash_table ma tablice obiektów klasy LinkedList, konstruktor klasy przyjmuje parametr size (10^size to rozmiar tablicy), n_t ilość elementów w pojedynczje komórce tablicy, po której następuje migracja z LinkedList na Red-Black Tree. Eksperymentalnie wyznaczyłem, że dla dużych słowników (jak LOTR.txt) size = 3 (1000 komórek w tablicy) i migracja po 20 elementach, dawała najelpsze wyniki. Funkcja haszująca, której używam (defaultowa w pythonie) daje rozkład w miarę losowy. Migracja powrotne nie następuje, do końca trwania programu w tej komórce tablicy jest wskażnik na Red-Black Tree nawet jeżeli ilosć elementów w tej strukturze zostanie zmniejszona do < n_t. Uznałem, że w przypadku takiej wieloktornej migracji, zysk zmiany typu struktury jest zupelnie nieporównywalny do kosztu migracji.

Struktury pozwalają na powtórzenia, a porządek to porządek leksykograficzny realizowany przez str.lower().
 
Niektóre strukture mają troche więcej funkcjonalności niż te wymieniona, są niepewne, nie spędziłem czasu na testowanie ich.

Hash Table ma tylko insert, delete, find, w przeciwnym wypadku wypisuje '\n'.

Wynik jest wypisywany na stdout.

Statystyki:
Klasa Scientist z pakietu scientist, zajmuje się zbieraniem statystyk.
Klasa ma pola zliczające liczbę wywołań operacji, czas wykonywań operacji oraz metodę describe(), która na stderr wypisuje wszytskie statysyki wymienione w treści zadania.
Eksperymenty przeprowadziłem na txt1.txt i txt2.txt i na ich podstawie dobrane są stałe.

Przykład outputu dla txt1.txt znajduje się w pliku tamizpowrotem.txt (Binary Search Tree wykonywał program dla 575234 słów przez 15 minut, dla porównania Red-Black Tree wykonywał te same instrukcje 10 sekund)

zadanie 2:
Metoda liczenia porównań w procedurze find: Każda struktura ma pole compares, które po wywołaniu find inkrementuje to pole, po wykonania przez procedurę porównania. Dzięki takiemu podejściu dalej mogę korzystać z tablicy obiektów w kalsie HashTable.

Eksperyment:
	1. Wczytuję dane komendą load *.txt
	2. Wykonuje find na trzech rodzajach kluczy z początku tekstu, środka i końca (dla plików bez powtórzeń, dla plików z powtórzeniami nie mam pewności, czy słowo z końca tekstu nie wystąpiło wcześniej, więc wybieram ów słowo szukając słów, które wydają się być rzadko używane w okolicach początku, środka i końca)
	3. Wykonuje punkt 2. na trzech zaimplementowanych strukturach.

Dla wszytskich struktur skrócę dane tak aby Binary Search Tree podołał.

Wyniki:
	Z powtórzeniami:

		BST	RBT	HMAP
"Bilbo"		11	15	1
"handkerchief"	55	37	3
"Records"	53	41	11

	Bez powtórzeń:

		BST	RBT	HMAP
"A"		1	25	1
"Cindy"		163	21	4
"Kimberly"	725	47	11

Wynik testów bez powtórzeń pokazuje, że w zasadzie ciężko cokolwiek mądrego powiedzieć o testach z powtórzeniami.
Testy można łatwo przeprowadzić odpowiednio zmieniając plik find_test_input.txt i przekierowując go na wejście programu.

Tezy:
Mojej odpowiedzi udzielam na pdostawie podręcznika Cormen'a.

Hash Table:
Złożoność optymistyczna i średnia są O(1). W tym przypadku wiele zależy od dobrania rozmiaru tablicy i funkcji haszującej. Jak widać po wynikach oba testy, potwierdzają te złożoność.
Przypadek pesymistyczny, gdy hash będzie taki sam dla wszystkich danych trafiamy wtedy (po przejściu granicy migracji) na Red-Black Tree, czyli złożoność O(log n).

Red-Black Tree:
W przypadku samobalansującej struktury, ilość porównań będzie O(log n) dla wszystkich przypadków. Oczywiście może się wahać (jak w wynikach) ale nie przekroczy log n.
W optymistycznym możemy od razu natrafić na szukany element, a w pesymistycznym szukać go w ostatnich poziomach, ale drzewo czerwono-czarne zachowuje równomierny rozkład.

Binary Search Tree:
W pesymistycznym przypadku ilość porównań jest Theta(n), (input posortowany), w optymistycznym i średnim będzie to O(log n), w niepatologicznym przypadku drzewo będzie w miarę równomiernie rozłożone.

# Swoją drogą bazując na wynikach dla LOTR, można się zastanowić nad liczbą słów, których używa Tolkien we Władcy Pierścieni.


