#include <stdio.h>
#include <math.h>
#define N 100000
typedef int bool;
#define true 1
#define false 0
int main(void)
{
	FILE *plik;
	unsigned int w, pierw;
	bool T[N];
	for(int i = 2; i <= N; i++) T[i] = true;
	pierw = (unsigned int)sqrt(N);
	// tutaj odbywa sie sito
	for(int i = 2; i <= pierw; i++)
	{
		if(T[i])
		{
			w = i * i;
			while(w <= N) 
			{
				T[w] = false;
				w += i;
			}
		}
	}
	unsigned int pi = 0;
	double iloraz;

	plik = fopen("gestosc_licz_pierwszych.txt", "w");

	for(int i = 2; i <= N; i++)
	{
		if(T[i]) pi++;
		iloraz = (double)pi*log(i)/(double)i;
		fprintf(plik, "%d;%lf\n", i, iloraz);
	}
	return 0;
}
