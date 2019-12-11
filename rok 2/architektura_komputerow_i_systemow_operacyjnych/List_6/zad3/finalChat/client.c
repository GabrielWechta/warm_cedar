#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <netinet/in.h>
#include <netdb.h>


void error(const char * msg){
    perror(msg);
    exit(0);    
}

void removeWhiteSpace(char* buf){
	if(buf[strlen(buf)-1]==' ' || buf[strlen(buf)-1]=='\n')
	buf[strlen(buf)-1]='\0';
	if(buf[0]==' ' || buf[0]=='\n') memmove(buf, buf+1, strlen(buf));
}

void params_from_buffer(char** param,char* buf){
	char *token;
	token=strtok(buf," ");
	int pc=-1;
	while(token){
		param[++pc]=malloc(sizeof(token)+1);
		strcpy(param[pc],token);
		removeWhiteSpace(param[pc]);
		token=strtok(NULL," ");
	}
	param[++pc]=NULL;
}

void putProtocol(int sockfd, char* file_name){
        write(sockfd, "putProtocol", 12);
        char buffer[255];
        bzero(buffer, 255);
        FILE* f;
        int bytes = 0;
        char bytes_str[12];
        char c;

        f = fopen(file_name, "r");

        while((c = getc(f)) != EOF){
            bytes++;
        }

        sprintf(bytes_str, "%d", bytes);

        printf("File has %s bytes.\n", bytes_str);

        write(sockfd, bytes_str, strlen(bytes_str));
        sleep(2);
        rewind(f);

        char ch;
        ch = fgetc(f);
        while(ch != EOF){
            write(sockfd, &ch, 1);
            ch = fgetc(f);
        }

        printf("The file has been send.");
        bzero(buffer, 255);
        fclose(f);
}

void getProtocol(int sockfd, char* file_name){
   FILE* fp;
   char buffer[255];
    bzero(buffer, 255);
    write(sockfd, "getProtocol", 12);
    sleep(1);
    write(1, file_name, strlen(file_name));
    write(1, "|\n", 3);
    write(sockfd, file_name, strlen(file_name));
   int transferedBytes = 0;
   fp = fopen("idk.txt", "a");
   char bytes_in_str[12];
   int bytesAmount = 0;

   read(sockfd, bytes_in_str, sizeof(bytes_in_str));

   bytesAmount = atoi(bytes_in_str);
   
   write(1, "in get protocol\n", 17);
   printf("bytesAmount = %d\n", bytesAmount);
   write(1, bytes_in_str, strlen(bytes_in_str));

   while(transferedBytes != bytesAmount){
      bzero(buffer, 255);
      read(sockfd, buffer, 1);
      //write(1,"i got \n", 8);
      //write(1, buffer, strlen(buffer));

      sleep(1);

      fprintf(fp, "%s", buffer);
      transferedBytes++;
   }
   bzero(buffer, 255);
   fclose(fp);
}

int main(int argc, char* argv[]){

    int sockfd, newsockfd, portno, n;
    struct sockaddr_in serv_addr;
    struct hostent* server;
    char buffer[255];

    fd_set readfds;
    char *message = "We are connected";

    if(argc < 3){ //wrong arguments error
        fprintf(stderr, "usage %s hostanme port\n", argv[0]);
        exit(0);
    }

    portno = atoi(argv[2]);
    sockfd = socket(AF_INET, SOCK_STREAM, 0);

    if(sockfd < 0){
        error("Error opening socket");
    }

    server = gethostbyname(argv[1]);
    if(server == NULL){
        fprintf(stderr, "Error, no such host");
    }

    bzero((char* ) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char* ) server->h_addr_list[0], (char* ) &serv_addr.sin_addr.s_addr, server->h_length);
    serv_addr.sin_port = htons(portno);

    if(connect(sockfd, (struct sockaddr* ) &serv_addr, sizeof(serv_addr)) < 0){
        error("Connection failed");
    }

    while(1){
        bzero(buffer, 255);
        fgets(buffer, 255, stdin);
        char* params[80];
        char temp_buffer[255];
        memcpy(temp_buffer,buffer, sizeof(buffer));
        params_from_buffer(params, temp_buffer);

        printf("params = %s|\n", params[0]);
        printf("params2 = %s|\n", params[1]);

        if(strcmp(params[0], "get") == 0){
            printf("GET\n");
            getProtocol(sockfd, params[1]);
            //najpeirw dlugosc sprintf
            //lepiej tekstowo 
        }
        else if (strcmp(params[0], "put") == 0){
            printf("PUT\n");
            putProtocol(sockfd, params[1]);
        }
        else {
            n = write(sockfd, buffer, strlen(buffer));
            if(n < 0){
                error("Error on writing");
            }

            bzero(buffer, 255);
            n = read(sockfd, buffer, 255);
            if(n < 0){
                error("Error on reading");
            }
            
            printf("Server: %s", buffer);
        }
    }
    close(sockfd);
    return 0;
}



