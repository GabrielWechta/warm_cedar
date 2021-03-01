//palindrom.c
#include "funs.h"
#include <string.h>

typedef int bool;
#define true 1
#define false 0

bool palindrom(char napis[])
{
	for(int i = 0, j = strlen(napis) - 1; i < j; i++, j--)
		{
		if(napis[i] != napis[j]) return false;
		}
	return true;
}		
