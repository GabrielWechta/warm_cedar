#include <signal.h>
#include <stdio.h>
#include <unistd.h>

int main()
{
    for(int i = 1; i < 65; i++)
    {
        kill(1, i);
        printf("I signaled %d to init\n",i);
    }
    return 0;
}