Obliczenia naukowe, Lista 5

Wszystkie zaimplementowane funckje znajdują się w module blocksys w pliku o nazwie blocksys.jl.

Ze względu na potrzebę modułu matrixgen w folderze, w którym programy się wykonują dołączam również go do rozwiązania. 

tests.jl, czyli plik, w którym znajdują się wszystkie testy, których wyniki są przedstawione w sprawozdaniu, w ostantniej sekcji (gdzie zapisywane są wygenerowane wykresy) ma adresy absolutne do folderów na moim komputerze, jeżeli będzie Pani chciała je puścić (zachęcam, ale proponuję zrobić to przed obiadem, bo liczą się ponad dwie godziny :) należy je zmienić na takie, w których chciałaby Pani zapisać wykresy.

Test "minimum", tj. jedna macierz w pliku, nazwa podana do programu z linii poleceń, policzona przez wszystkie cztery metody i ich wyniki zapisane w folderze, w którym program zostanie odpalony, z błędem względnym, ma następującą instrukcję wywołania:

$ julia test_for_Ms_Bujkiewicz.jl nazwa_pliku_z_macierza

