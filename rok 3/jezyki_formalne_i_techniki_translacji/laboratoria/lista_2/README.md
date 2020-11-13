zad1:
* Zliczamy tylko niepuste linie. 
* Przypadek gdy mamy
			  \

(tj. [\t ]*\\\n) jest traktowany jako empty line.

zad2:
* Przepisałem na stany. Przy okazji przypomniałem sobie, że jedyne cechy, które prolog dzieli z prorokiem to domniemane szaleństwo.

zad3:

zad4:
* stos ma (stack_size) = 100, można go zmienić w dyrektywie prepocesora #define.
* znak '-' poprzedzający cyfrę bez spacji jest interpretowany jako -cyfra. Przykład:
-2 3-4* nie przejdzie, kiedy
-2 3+4* przejdzie
mam nadzieję, że zawiera się w to moich kompetencjach aby poprosić w celu ominięcia niejdnoznaczności, że: 
-2 3-4* = -2 ? (3 * -4) zły input
a poprawny input to:
-2 3 - 4* = (-2 - 3) * 4
wtedy też:
-2 3 --4* = (-2 - 3) * (-4)
jest dozwolone. 
Wydaje się to rozsądne bo '-' jest operacją prefiksową lub ifniksową.

