#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <netinet/in.h>


void error(const char * msg){
    perror(msg);
    exit(1);    
}

int login(const char* password){
    if(strcmp("okon",password)) return 1;
    else return 0;
}

int main(int argc, char* argv[]){

    if(argc < 2){ //wrong arguments error
        fprintf(stderr, "Port number not provided. Program terminated\n");
        exit(1);
    }

    int sockfd, newsockfd, portno, n;
    int max_clients = 30, client_socket[30];
    char buffer[255];

    struct sockaddr_in serv_addr, cli_addr;
    socklen_t clilen;

    //set of socket descriptors
    fd_set readfds;
    char* message = "We are connected";

    for (int i = 0; i < max_clients; i++){
        client_socket[i] = 0;
    }
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

    //while(1){
        do{
            bzero(buffer, 256);
            n = read(newsockfd, buffer, 255);
            if(n < 0){
                error("Error on reading password");
            }
            printf("%s",buffer);
        } while(strncmp("okon", buffer,4) != 0);
       
        printf("Client logged in\n");
        bzero(buffer, 255);
        n = write(newsockfd, "welcome", strlen(buffer));

        if(n < 0){
            error("Error on writing");
        }
    //}

    close(newsockfd);
    close(sockfd);
    return 0;


}