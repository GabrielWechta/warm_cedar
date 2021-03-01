#include <stdio.h>
#include <assert.h>

int main(void)
{

	int zlote, grosze;
	int Ban[]={200,100,50,20,10,5,2,1};
	int Mon[]={50,20,10,5,2,1};
	printf("Podaj prosze liczbe zloty\n");
	scanf("%d", &zlote);
	printf("Podaj prosze liczbe groszy\n");	
	scanf("%d", &grosze);
	assert(zlote != 0 && grosze != 0);
	for(int i = 0; i < 8; i++)
		{
		if(zlote == 0) break;
		if(Ban[i] == 200) printf("\nbanknoty");
		if(Ban[i] == 5) printf("\nmonety:");
		int x = zlote / Ban[i];
		if(x != 0)
			{
			printf("\n\t%d x %d zl", x, Ban[i]);
			zlote -= x * Ban[i];
			}
		}

	for(int i = 0; i < 6; i++)
		{
		if(grosze == 0) break;
		int x = grosze / Mon[i];
		if(x!= 0)
			{
			printf("\n\t%d x %d gr", x, Mon[i]);
			grosze -= x * Mon[i];
			}
		}
	printf("\n");
	return 0;
}
