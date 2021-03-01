#include<stddef.h>
#include<sys/types.h>
#include<unistd.h>

#define _GNU_SOURCE

int main() {
    char *name[2] = {"bash", NULL};
    setuid(0);
    execvp("/bin/bash", name);
}