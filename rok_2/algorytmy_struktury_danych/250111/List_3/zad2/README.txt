Program oprócz flag -r i -p ma jeszcze flagę -s, która dla tablic o długości 1000 do 10000 (zarówno dla permutacji i losowych liczb) wykonuje RANDOM SELECT i SELECT 100 razy z k = n/3, gdzie n to dłguość tablicy i wpisuje statystki do 4 plików.

W pliku selects_stats.xlsx są opracowane statyski. Odchylenie standardowe zostało policzone dla RANDOM SELECT i SELECT działających na losowych liczbach.

//notes:
output do pliku ma format:

n;c_c;s_c

gdzie:
n - to długość tablicy
c_c - comparison count, licznik porównań
s_c - swap count, licznik przestawień
