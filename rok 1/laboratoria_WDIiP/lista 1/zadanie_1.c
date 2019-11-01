#include <stdio.h>

int main(void)
{
	char tab_abrakadabra[] ="ABRAKADABRA";
	int n;

	for(int i = 0; i < 11; i++)
		{
		n=0;
		while(n != i)
			{ 
			printf(" ");
			n = n + 1;
			}
		for(int j = 0; j < 11 - i; j++)
			{
			printf("%c ", tab_abrakadabra[j]);
			}
		printf("\n");
		}
	return 0;
}
