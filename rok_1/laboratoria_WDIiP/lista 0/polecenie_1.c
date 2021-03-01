#include <stdio.h>

int main(void)
{

float x, y;
float suma, roznica, iloczyn, iloraz;
printf("Podaj prosze dwie liczby rzeczywiste\n");
scanf("%f", &x);
scanf("%f", &y);

suma = x + y;
roznica = x - y;
iloczyn = x*y;
iloraz = x/y;

printf("\nO to wyniki elementrnych dzialan na tych liczbach:\n");

printf("suma = %g", suma);
printf("\nroznica = %g", roznica);
printf("\niloczyn = %g", iloczyn);
printf("\niloraz = %g\n", iloraz);


return 0;
}
