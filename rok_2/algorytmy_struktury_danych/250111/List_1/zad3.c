#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct node
{
    int val;
    struct node *next;
    struct node *prev;
} node_t;

void print_list(node_t *head)
{
    node_t *ptr;
    ptr = head;
    if (head == NULL)
    {
        printf("empty\n");
    }
    else
    {
        while (ptr->next != head)
        {
            printf("%d\n", ptr->val);
            ptr = ptr->next;
        }
        printf("%d\n", ptr->val);
    }
}

void insert(node_t *head, int value)
{
    node_t *ptr, *temp;

    ptr = (node_t *)malloc(sizeof(node_t));
    if (ptr == NULL)
    {
        printf("\nerror");
    }
    else
    {
        ptr->val = value;
        if (head == NULL)
        {
            head = ptr;
            ptr->next = head;
            ptr->prev = head;
        }
        else
        {

            temp = head;
            while (temp->next != head)
            {

                temp = temp->next;
            }

            temp->next = ptr;
            ptr->prev = temp;
            head->prev = ptr;
            ptr->next = head;
        }
    }
}

void merge(node_t *head1, node_t *head2) //this merge puts list starting from head2 directly after head1
{
    node_t *tail2 = head2->prev;
    node_t *tmp = head1->next;
    head1->next = head2;
    head2->prev = head1;
    tail2->next = tmp;
    tmp->prev = tail2;
}

void populate(node_t *head, int number)
{
    time_t t;
    srand((unsigned)time(&t));

    for (int i = 0; i < number; i++)
    {
        insert(head, rand() % 10000);
    }
}

int list_length(node_t *head)
{
    node_t *current = head;
    int length = 0;
    do
    {
        length++;
        current = current->next;
    } while (current != head);

    return length;
}

double find(node_t *head, int searched_position, int list_size)
{
    clock_t start, end;
    start = clock();

    node_t *current = head;
    int iterator = 0;
    if (searched_position < list_size / 2) //first half
    {
        while (current->next != head)
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
    }
    else //second half
    {
        iterator = list_size;
        while (current->prev != head)
        {
            if (iterator == searched_position)
            {
                end = clock();
                double time_taken = ((double)(end - start)) / CLOCKS_PER_SEC;

                //printf("Found it! Looking for %dth, which is %d took me %f\n", searched_position, current->val, time_taken);
                return time_taken;
            }
            iterator--;
            current = current->prev;
        }
    }
    //printf("Didn't find it\n");
    return 0;
}

double finding_average(node_t *head, int search_position, int list_size, int how_many_times)
{
    double sum = 0.0, average = 0.0;
    for (int i = 0; i < how_many_times; i++)
    {
        sum += find(head, search_position, list_size);
    }
    average = sum / how_many_times;
    printf("Looking for %d %d times on average took me %f\n", search_position, how_many_times, average);

    return average;
}

int main()
{
    node_t *head, *head2;
    head = (node_t *)malloc(sizeof(node_t));
    if (head == NULL)
    {
        return 1;
    }

    head->val = 1;
    head->next = head;
    head->prev = head;

    head2 = (node_t *)malloc(sizeof(node_t));
    if (head2 == NULL)
    {
        return 1;
    }

    head2->val = 2;
    head2->next = head2;
    head2->prev = head2;

    insert(head, 3);
    insert(head, 5);
    //insert(head2, 6);
    //insert(head2, 4);

    merge(head, head2);

    print_list(head);

    //printf("\n%d", list_length(head));

     populate(head, 9999);

    // print_list(head);

    // find(head, 999, 1000);

    finding_average(head, 1, list_length(head), 1000);
    finding_average(head, 10, list_length(head), 1000);
    finding_average(head, 100, list_length(head), 1000);
    finding_average(head, 999, list_length(head), 1000);
    finding_average(head, rand() % 1000, list_length(head), 1000);

    //printf("%d", head->next->next->next->val);
    return 0;
}
