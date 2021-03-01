#include <stdio.h>
#define MAX 10000

int tab[MAX];
int begining = 0, end = 0;

void push(int a)
{
    if (end == MAX)
        return;
    tab[end] = a;
    end++;
    return;
}
void pop()
{
    if (begining == end)
        return;
    begining++;

    return;
}

void show()
{
    for (int i = begining; i < end; i++)
    {
        printf("%d", tab[i]);
    }
    printf("\n");
}
int main()
{
    push(1);
    push(2);
    push(3);
    push(4);

    show();

    pop();

    show();
    return 0;
}