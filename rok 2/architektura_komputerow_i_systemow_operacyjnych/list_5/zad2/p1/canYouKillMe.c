#include <signal.h>
#include <stdio.h>
#include <unistd.h>


void sigKill_handler(int dummy)
{
    signal(SIGKILL, sigKill_handler);
    printf("You can't kill me\n");
}

void ctrC_handler(int dummy)
{
    signal(SIGINT, ctrC_handler);
    printf("You can't stop me \n");
}

int main()
{
    int j;

    signal(SIGKILL, sigKill_handler);
    signal(SIGINT, ctrC_handler);

    for(j = 0; j < 100; j++)
    {
        sleep(1);
        printf("I am still alvie\n");
    }

    return 0;
}