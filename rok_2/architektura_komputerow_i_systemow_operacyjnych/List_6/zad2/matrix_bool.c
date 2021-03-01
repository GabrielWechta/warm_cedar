#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <pthread.h>

int matrixA[100][100];
int matrixB[100][100];

int matrixK[100][100];
int rows = 0, columns = 0;
int rowsDone = 0;


typedef struct {
    pthread_mutex_t* lock;
    int id;
} Thread_struct;

void populateMatrix(int n, int m, int matrix[][m]){
    for(int i = 0; i< n; i++){
        for(int j = 0; j < m; j++){
            matrix[i][j] = rand() %2;
        }
    }
}

void displayMatrix(int n, int m, int matrix[][m]){
    for(int i = 0; i< n; i++){
        printf("\n");
        for(int j = 0; j < m; j++){
            printf("%d\t",matrix[i][j]);
        }
    }
    printf("\n");
}

bool getValueAt(int row, int col){
    bool result = false;
    int i = 0;
    while(i < col && result != true){
        result = result || (matrixA[row][i] && matrixB[i][col]);
        i++;
    }
    return result;
}

void calculateRow(int row){
    for(int i = 0; i < rows; i++){
        matrixK[row][i] = getValueAt(row,i);
    }
    //sleep(1);

}

void* threadRun(void* arg){
    int n;
    Thread_struct* t = (Thread_struct* ) arg;

    while(rowsDone < rows){
        pthread_mutex_lock(t->lock);
        n = rowsDone++;
        pthread_mutex_unlock(t->lock);
        if(n >= rows) continue;
                printf("Watek %d robi %d\n",t->id, n);
        if(n<rowsDone) calculateRow(n);
    }
}


int main(int argc, char* argv[]){
    if(argc < 4) {
        printf("usage: rows, columns, number of threads\n");
        exit(1);
    }

    rows = atoi(argv[1]);
    columns = atoi(argv[2]);
    int number_of_threads = atoi(argv[3]);
    printf("%d, %d, %d\n",rows, columns, number_of_threads);

    if(rows > 0 && rows < 100 && columns > 0 && columns < 100){
        srandom(time(NULL));
        for(int i = 0; i < rows; i++){
            for(int j = 0; j < columns; j++){

                matrixA[i][j] = (random() %2);
                matrixB[j][i] = (random() %2);
            }
        }

        // populateMatrix(rows, columns, matrixA);
        // populateMatrix(columns, rows, matrixB);

        pthread_t* tid = malloc(sizeof(pthread_t)* number_of_threads);
        pthread_mutex_t lock;
        pthread_mutex_init(&lock, NULL);
        Thread_struct* ts_table = malloc(sizeof(Thread_struct) * number_of_threads);

        for(int i = 0; i < number_of_threads; i++){
            ts_table[i].id = i;
            ts_table[i].lock = &lock;

            pthread_create(tid +i, NULL, threadRun, ts_table+i);
        }

        for(int i = 0; i < number_of_threads; i++){
            pthread_join(tid[i],NULL);
        }

        for(int i = 0; i < rows; i++){
            for(int j = 0; j < columns; j++){

                printf("%d\t", matrixA[i][j]);
            }
            printf("\n");
        }        
        printf("\n");
        for(int i = 0; i < columns; i++){
            for(int j = 0; j < rows; j++){

                printf("%d\t", matrixB[i][j]);
            }
            printf("\n");
        }
        printf("\n");
        for(int i = 0; i < rows; i++){
            for(int j = 0; j < rows; j++){

                printf("%d\t", matrixK[i][j]);
            }
            printf("\n");
        }

    }
    else{
        printf("You typed arguments out of logival bounds");
        exit(1);
    }

return 0;
}