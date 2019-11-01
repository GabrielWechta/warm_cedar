#include <stdio.h>

int main(void)
{
	char n; // to ze wzgledu na oszczednosc miejsca, powinien byc int
	printf("Daj mi n, a narysuje ci prostokat o n wierszy i 2n kolumn\n");

	scanf("%i", &n);
	printf("\n");
	for(int i = 0; i < n ; i = i + 1)
		{
		for(int j = 0; j < 2*n; j = j + 1) printf("*");
		printf("\n");
		}
	printf("\n");
	return 0;
}
