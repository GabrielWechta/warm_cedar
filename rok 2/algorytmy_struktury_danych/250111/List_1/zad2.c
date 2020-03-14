#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct node
{
    int val;
    struct node *next;
} node_t;

void print_list(node_t *head)
{
    node_t *current = head;

    while (current != NULL)
    {
        printf("%d\n", current->val);
        current = current->next;
    }
}

void add(node_t *head, int val)
{
    node_t *current = head;
    while (current->next != NULL)
    {
        current = current->next;
    }

    current->next = (node_t *)malloc(sizeof(node_t));
    current->next->val = val;
    current->next->next = NULL;
}

void merge(node_t *head1, node_t *head2) //function merge merges second list into first one
{
    node_t *current = head1;

    while (current->next != NULL)
    {
        current = current->next;
    }

    current->next = head2;
}

void populate(node_t *head, int number)
{
    time_t t;
    srand((unsigned)time(&t));

    for (int i = 0; i < number; i++)
    {
        add(head, rand() % 10000);
    }
}

double find(node_t *head, int searched_position)
{
    clock_t start, end;
    start = clock();

    node_t *current = head;
    int iterator = 0;

    while (current != NULL)
    {
        if (iterator == searched_position)
        {
            end = clock();
            double time_taken = ((double)(end - start)) / CLOCKS_PER_SEC;

            //printf("Found it! Looking for %dth, which is %d took me %f\n", searched_position, current->val, time_taken);
            return time_taken;
        }
        iterator++;
        current = current->next;
    }
    //printf("Didn't find it\n");
    return 0;
}

double finding_average(node_t *head, int search_position, int how_many_times)
{
    double sum = 0.0, average = 0.0;
    for (int i = 0; i < how_many_times; i++)
    {
        sum += find(head, search_position);
    }
    average = sum / how_many_times;
    printf("Looking for %d %d times on average took me %f\n", search_position, how_many_times, average);

    return average;
}

int main()
{

    node_t *head = NULL;
    head = (node_t *)malloc(sizeof(node_t));
    if (head == NULL)
    {
        return 1;
    }

    node_t *head2 = NULL;
    head2 = (node_t *)malloc(sizeof(node_t));
    if (head2 == NULL)
    {
        return 1;
    }

    head->val = 1;
    head->next = NULL;
    head2->val = 5;
    head2->next = NULL;

    add(head, 2);
    add(head, 3);

    populate(head, 1000);

    merge(head, head2);

    print_list(head);

    find(head, 1);
    find(head, 10);
    find(head, 100);
    find(head, 1000);
    find(head, rand() % 1000);

    finding_average(head, 1, 1000);
    finding_average(head, 10, 1000);
    finding_average(head, 100, 1000);
    finding_average(head, 1000, 1000);
    finding_average(head, rand() % 1000, 1000);
    
    return 0;
}
