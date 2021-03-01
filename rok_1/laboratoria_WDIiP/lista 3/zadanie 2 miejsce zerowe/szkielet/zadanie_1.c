#include <stdio.h>
#include <math.h>
#include <assert.h>

double f(double x)
{
	return cos(x/2.0);
}

double rozwiazanie(double a, double b, double eps)
{
	if (f(a) == 0.0) return a;
	if (f(b) == 0.0) return b;
	
	
	while(b-a > eps)
	{
		double srodek = (a+b)/2.0;
		if(srodek == 0) return srodek;
		else if (f(a) * f(srodek) < 0) b = srodek;
			else a = srodek;
	}

	return (a+b)/2;
}

int main(void)
{
	double a, b, eps;
	printf("Podaj prosze a, b i eps  ");
	scanf("%lf %lf %lf", &a, &b, &eps);
	assert(a < b);
	double pierwiastek = rozwiazanie(a, b, eps);
	printf("%f", pierwiastek);
	return 0;
}
