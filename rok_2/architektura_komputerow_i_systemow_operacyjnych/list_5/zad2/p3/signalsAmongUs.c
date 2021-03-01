#include <signal.h>
#include <stdio.h>
#include <unistd.h>

int j = 0, k = 0;

void siguser_handler(int dummy) 
{
    signal(SIGUSR1, siguser_handler);

    for(int i = 0; i < 100000; i++)
    {
        i++;
    }

    printf("SIGUSR1 handeled, btw j = %d\n", j);
    j++;
}

void siguser2_handler(int dummy) 
{
    signal(SIGUSR2, siguser2_handler);

    printf("SIGUSR2 handeled, btw k = %d\n", k);
    k++;
}

int main()
{
    signal(SIGUSR1, siguser_handler);
    signal(SIGUSR2, siguser2_handler);

    while(1);

    return 0;
}