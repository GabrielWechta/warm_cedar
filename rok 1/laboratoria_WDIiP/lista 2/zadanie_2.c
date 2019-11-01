#include <stdio.h>
#include <assert.h>
int main(void)
{
	int n;
	double srednia = 0,x;
	scanf("%d", &n);
	assert(n != 0);
	for(int i = 0; i < n; i++)
		{
		scanf("%lf", &x);
		srednia += x / (double) n;
		}

	printf("\n\t %g\n", srednia);
	return 0;
}
