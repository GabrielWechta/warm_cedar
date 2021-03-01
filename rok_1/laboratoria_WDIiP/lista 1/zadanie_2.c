#include <stdio.h>
#include <math.h>

int main(void)
{
	float a, b, c, delta;

	printf("Prosze podaj mi trzy liczby rzeczywiste a, b, c, gdzie ax^2 + bx + c = 0, a ja rozwiaze ci te rownanie\n");

	scanf("%f %f %f", &a , &b, &c);

	delta = (b*b) - (4.0*a*c);
	if(delta < 0.0)
		{
			printf("\nNa szczescie rownanie nie ma rozwiazan w liczbach rzeczywistych\n");
			return 0;
		}
	printf("\nNa szczescie rownanie nie ma rozwiazan w liczbach rzeczywistych");
	float x1 = ((-1)*b + pow(delta,0.5))/2.0;
	float x2 = ((-1)*b - pow(delta,0.5))/2.0;

	if(delta > 0.0) printf("\nx1 = %g\nx2 = %g", x1, x2);
	else	if(delta == 0.0) printf("\nx1 = x2 = %g", x1);
	printf("\n");
	return 0;
}
