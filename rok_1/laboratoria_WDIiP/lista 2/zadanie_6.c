#include <stdio.h>
#define N 10000	
int sigma(int n)
{
	int suma = 1, i;
	for(i = 2; i*i < n; i++)
	{
		if(n%i == 0) suma += i + n/i;
	}
	if(i * i == n) return suma + i;
	else return suma;
}

int main(void)
{
	printf("liczby doskonale: \n");
	for(int i = 2; i <= N; i++) if (sigma(i) == i) printf("%d\n",i);

	printf("pary liczb zaprzyjaznionych: \n");
	for(int i = 2; i <= N; i++)
	{
		for(int j = i+1; j <= N; j++)
		{
			if(sigma(j) == i && sigma(i) == j) printf("(%d,%d) \n", i, j);
		}
	}
	return 0;
}
