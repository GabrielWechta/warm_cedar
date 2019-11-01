//main.c

#include "funs.h"
#include <stdio.h>

int main(void)
{
	char napis[100];
	printf("Dzien dobry! Prosze podac teksty, ktory sprawdzimy na bycie palindromem: ");
	scanf("%s",napis);
		if(palindrom(napis) == true) printf("a jakze!\n");
		else printf("nope\n");
	return 0;
}
