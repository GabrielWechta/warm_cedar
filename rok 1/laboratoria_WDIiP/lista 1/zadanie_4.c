#include <stdio.h>

int main(void)
{
	int n;
	printf("\nPodaj mi prosze n, a ja narysuje ci trojkat rownoramienny zlozony z n wierszy\n");
	scanf("%i", &n);

	for(int i = 0; i < n; i = i + 1)
		{
		for(int j = 0; j < 2*n - 1 ; j = j + 1)
			{
			if(j >= (n - 1 - i) && j <= (n - 1 + i)) printf("*");
			else printf(" ");
			}
		printf("\n");
		}
	return 0;
}
