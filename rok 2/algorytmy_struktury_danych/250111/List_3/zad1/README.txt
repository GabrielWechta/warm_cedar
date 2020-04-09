main.cpp zawiera rozwiązanie zadania pierwszego z listy 3 w identyczny sposób jak moje poprzednie rozwiązanie z listy 2, natomiast, żeby nie kopiować kodu i żeby był czytelniejszy program zawiera jedynie możliwośc wywołania dla radixSort flagą:
--type radix

plik radix_stats.xlsx zawiera porównanie radixSort dla liczb o długościach (ilości cyfr) 2, 3, 4, 8 i 10.

//notes:
output do pliku ma format:

n;o_c;ram;dur

gdzie:
n - to długość tablicy
o_c - operation count, program zlicza wszystkie operacje wykonywane na tablicach, jak: dodawanie, modulo, tab[i] = .. itd. 
ram - suma rozmiaru tablic na których program pracuje
dur - czas od rozpoczęcia do zakońćzenia programu w us.
