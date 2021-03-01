#include <stdio.h>
#define N 1000
int nwd(int a, int b)
{
	if( b == 0) return a;
	return nwd(b, a % b);
}

int main(void)
{
	FILE *plik;
	int ro = 0;
	double iloraz;
	plik = fopen("gestosc wzglednie pierwszych.txt", "w");
	for(int n = 1; n <= N; n++)
	{
		for(int m = 1; m <= n; m++)
		{
			if(nwd(n,m) == 1) ro++;
		}
		iloraz = (double)ro/(n*n);
		fprintf(plik,"%d;%lf\n", n, iloraz);
	}
		
	return 0;
}
