#include <stdio.h>

int main() {
	for(int i = 0; i < 256; i++)
	{
	printf("\x1b[38;5;%dm", i);
	if(i == 15 || ((i > 15) && ((i - 15) % 12 == 0))) printf("\n");
	printf("Hello, wolrd ");
	}
return 0;
}
