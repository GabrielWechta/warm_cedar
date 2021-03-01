#include <stdio.h>

int main(void)
{

float fahrenheit;
float celsjusz;

printf("Bardzo prosze podaj temperature w stopniach Celsjusza\n");

scanf("%f", &celsjusz);

fahrenheit = celsjusz * 1.8 + 32;

printf("Temperatura %g stopni Celsjusza odpowiada temperaturze %.2f stopni Fahrenheita\n", celsjusz, fahrenheit);


return 0;
}
