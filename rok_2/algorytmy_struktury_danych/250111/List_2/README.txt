Rozwiązanie wszytskich zadań stanowi plik zad1.cpp

możliwe flagi:
1. --type insert|merge|quick|dual|hybrid
2. --comp '>='|'<='
3. --stat nazwa_pliku k
4. --test (do testowania programu z danymi ustawionymi na sztywno)

Chcąc usunąć wszytskie niepotrzebne if'y rozdzieliłem fukncje na zwykłe i "clean". Funkcje zakończone na "clean" realizują jedynie algorytm, pozostałe dają output na deskryptor 1 i 2. Zrobiłem to chcąc dostać jak najabrdziej miarodajne wyniki zastosowanych algorytmów sortujących.

zadanie 2: 
 - Do generowania liczb pseudolosowych do populacji tablic użyłem mt19937.
 - Do wykonania wykresów i zebrania dancyh użyłem MS Excel.
 - Zwiększenie próbkowalności (k) wygładziło wykresy. Przedstawiłem w pliku zas1_stat.xlsx opracowane wyniki jedynie dla prób z k = 1000.

zadanie 3:
 - Nie udało mi się wyznaczyć średniej stojącej przy nln(n), podjerzewam, że powodem tego jest nieodpowiednie przeze mnie zliczanie kosztu algorytmu. Próbowałem manipulować inkrementatorami liczników ale nie dawało to skutku.

zadanie 4:
 - Do algorytmu hybrydowego użyłem: mergeSort i insertionSort. Algorytm przeżuca się na insertionSort dla tablic długości < 10.
 - Niestety polecenie zadania 4 przeczytałem na sam koniec gdy miałem już popisane wszytskie funkcje implementujące sorty. Zaimplementowałem mój pomysł na rozwiązanie problemu porządku zadanego przez użytkownika (struktura ze wskażnikiem na funkcję boolowską przyjmującą dwa argumenty) dopiero w ostanim algorytmie. Dodanie tego rozwiązania do pozostałych funckji kosztowałoby wiele pracy a byłoby to wyłącznie ctrC -> ctrV.

Dziękuję za możliwość poprawy zadania.
