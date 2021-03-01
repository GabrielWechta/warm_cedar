#include <signal.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, int *argv)
{
        int pid = 0;
        printf("Enter pid you want to spam: ");
        scanf("%d", &pid);
        for(int i = 0; i < 100; i++)
        {
            kill(pid, SIGUSR1);
            printf("I sent SIGUSR1 %d time \n", i);
            kill(pid, SIGUSR2);
            printf("I sent SIGUSR2 %d time \n", i);
        }
    return 0;
}