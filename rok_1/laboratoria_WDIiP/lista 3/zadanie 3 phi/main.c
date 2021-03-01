//main.c

#include <stdio.h>
#include "funs.h"
			//sprytny wzór iloczynowy Eulera

int main(void)
{
	long int liczba;
	scanf("%li", &liczba);
	
	int odpowiedz;
	odpowiedz = phi(liczba);
	printf("phi(%li) = %i\n", liczba, odpowiedz);
	return 0;
}
