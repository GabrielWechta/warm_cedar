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

    FILE* fp;

    int ch = 0;
    fp = fopen("glad_received.txt", "a");
    int words;

    read(newsockfd, &words, sizeof(int));

    while(ch != words){
        read(newsockfd, buffer, 255);
        fprintf(fp, "%s ", buffer);
        ch++;
    }

    printf("The file has been received");

    close(newsockfd);
    close(sockfd);
    return 0;


}
