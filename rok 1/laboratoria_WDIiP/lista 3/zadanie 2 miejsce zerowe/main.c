//main.c

#include "funs.h"
#include <assert.h>
#include <stdio.h>

int main(void)
{
	double a, b, eps;
	printf("Podaj prosze a, b i eps  ");
	scanf("%lf %lf %lf", &a, &b, &eps);
	assert(a < b);
	double pierwiastek = rozwiazanie(a, b, eps);
	printf("%lf \n", pierwiastek);
	return 0;
}
