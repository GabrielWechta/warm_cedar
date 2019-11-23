#include <signal.h>
#include <stdio.h>
#include <unistd.h>

    int i, j;

void ctrC_handler(int dummy)
{
    signal(SIGINT, ctrC_handler);
    printf("CTR+C\n");
    printf("%d\n",j);
}

int main()
{

    signal(SIGINT, ctrC_handler);

    for(j = 0; j < 10; j++)
    {
        sleep(10);
    }

    return 0;
}