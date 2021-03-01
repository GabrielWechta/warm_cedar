//rozwiazanie.c
#include "funs.h"

double rozwiazanie(double a, double b, double eps)
{
	if (f(a) == 0.0) return a;
	if (f(b) == 0.0) return b;
	
	
	while(b-a > eps)
	{
		double srodek = (a+b)/2.0;
		//if(srodek == 0) return srodek;
		else if (f(a) * f(srodek) < 0) b = srodek;
			else a = srodek;
	}

	return (a+b)/2;
}
