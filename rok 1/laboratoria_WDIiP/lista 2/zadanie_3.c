#include <stdio.h>
#define N 10

int main(void)
{
	double suma = 0.0;
	int i = 0;
	while (suma <= N)
	{
		i++;
		suma += 1.0/(double)i;
		printf("\t%lg\t%lg\n",suma, 1/(double)i);
	}
	printf("\n%d\n", i);
	return 0;
}
