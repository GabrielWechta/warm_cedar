#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>


void error(const char * msg){
    perror(msg);
    exit(1);    
}

int main(int argc, char* argv[]){

    if(argc < 2){ //wrong arguments error
        fprintf(stderr, "Port number not provided. Program terminated\n");
        exit(1);
    }

    int sockfd, newsockfd, portno, n;
    char buffer[255];

    struct sockaddr_in serv_addr, cli_addr;
    socklen_t clilen;

    sockfd = socket(AF_INET, SOCK_STREAM, 0);

    if(sockfd < 0){ //error
        error("Error opening socket. \n");
    }

    bzero((char* ) &serv_addr, sizeof(serv_addr)); //cleaning 

    portno = atoi(argv[1]); //chaning string port input to int.

    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);

    if(bind(sockfd, (struct sockaddr* ) &serv_addr, sizeof(serv_addr)) < 0 ){
        error("Binding failed");
    }

    listen(sockfd, 5); //giving file avalible queued clients
    clilen = sizeof(cli_addr);

    newsockfd = accept(sockfd, (struct sockaddr* ) &cli_addr, &clilen);
    
    if(newsockfd < 0){
        error("Error on accept");
    }

    //where talk starts
    int num1, num2, answer, choice;

    n = write(newsockfd, "Enter number 1: ", strlen("Enter number 1: ")); //asking number 1
    if(n < 0){
        error("Error writing to socket");
    }

    read(newsockfd, &num1, sizeof(int));
    printf("Client's number 1 is: %d\n", num1);

    n = write(newsockfd, "Enter number 2: ", strlen("Enter number 2: ")); //asking number 2
    if(n < 0){
        error("Error writing to socket");
    }

    read(newsockfd, &num2, sizeof(int));
    printf("Client's number 2 is: %d\n", num2);


    n = write(newsockfd, "Choose operation: \n 1: +\n 2: -\n 3: *\n 4: \\ \n5: exit\n", strlen("Choose operation: \n 1: +\n 2: -\n 3: *\n 4: \\ \n5: exit\n")); //asking choice
    if(n < 0){
        error("Error writing to socket");
    }

    read(newsockfd, &choice, sizeof(int));
    printf("Client's choice is: %d\n", choice);

    switch(choice){
        case 1: answer = num1+num2;
            break;
        case 2: answer = num1-num2;
            break;
        case 3: answer = num1*num2;
            break;
        case 4: answer = num1/num2;
            break;
        default: 
            break;
    }

    write(newsockfd, &answer, sizeof(int));

    close(newsockfd);
    close(sockfd);
    return 0;


}