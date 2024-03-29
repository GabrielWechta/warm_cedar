#include <stdio.h>
//sprytny wzór iloczynowy Eulera
int phi(long int n) 
{ 
    double result = n;
    for (int p = 2; p * p <= n; p++) 
	{ 
		if (n % p == 0) 
		{      
		    while (n % p == 0) n = n/p;  
		    result *= (1.0 - (1.0 / (double)p)); 
		} 
    	} 

    if (n > 1) 
        result *= (1.0 - (1.0 / (double)n)); 
  
    return (int)result; 
} 

int main(void)
{
	long int liczba;
	scanf("%li", &liczba);
	
	int odpowiedz;
	odpowiedz = phi(liczba);
	printf("phi(%li) = %i\n", liczba, odpowiedz);
	return 0;
}
