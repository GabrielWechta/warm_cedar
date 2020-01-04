#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <netinet/in.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>

#define SERVER_PORT  12345

#define TRUE             1
#define FALSE            0

int putFilesCount = 0;

void removeWhiteSpace(char* buf){
	if(buf[strlen(buf)-1]==' ' || buf[strlen(buf)-1]=='\n')
	buf[strlen(buf)-1]='\0';
	if(buf[0]==' ' || buf[0]=='\n') memmove(buf, buf+1, strlen(buf));
}

void tokenize_buffer(char** param,int *nr,char *buf,const char *c){
	char *token;
	token=strtok(buf,c);
	int pc=-1;
	while(token){
		param[++pc]=malloc(sizeof(token)+1);
		strcpy(param[pc],token);
		removeWhiteSpace(param[pc]);
		token=strtok(NULL,c);
	}
	param[++pc]=NULL;
	*nr=pc;
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

void executeBasic(char** argv, int fd){
   if(strstr(argv[0],"cd")){//cd builtin command
	   chdir(argv[1]);
      send(fd, "dir changed\n", 13, 0);
	}
   else{
      if(fork()>0){
         wait(NULL);
      }
      else{
         dup2(fd,1);
         dup2(fd,2);
         execvp(argv[0],argv);
         perror("invalid input\n");
         exit(1);
      }
   }

}

void putProtocol(int newsockfd){
   FILE* fp;
   char buffer[255];

   int transferedBytes = 0;
   fp = fopen("received.txt", "a");
   char bytes_in_str[12];
   int bytesAmount = 0;

   read(newsockfd, bytes_in_str, sizeof(bytes_in_str));

   bytesAmount = atoi(bytes_in_str);
   
   write(1, "in put protocol\n", 17);
   printf("bytesAmount = %d\n", bytesAmount);
   write(1, bytes_in_str, strlen(bytes_in_str));

   while(transferedBytes != bytesAmount){
      bzero(buffer, 255);
      read(newsockfd, buffer, 1);
      fprintf(fp, "%s", buffer);
      transferedBytes++;
   }
   bzero(buffer, 255);
   fclose(fp);
}

void getProtocol(int sockfd){
         char tmp_file_name[20], file_name[20];
        read(sockfd, tmp_file_name, sizeof(tmp_file_name));
        memcpy(file_name, tmp_file_name, strlen(tmp_file_name));
        write(1, file_name, strlen(file_name));
        write(1,"\n",2);

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
           //sleep(1);
            write(sockfd, &ch, 1);
            ch = fgetc(f);
        }

        printf("The file has been send.");
        bzero(buffer, 255);
        fclose(f);
}

int main (int argc, char *argv[])
{
   int    i, len, rc, on = 1;
   int    listen_sd, max_sd, new_sd;
   int    desc_ready, end_server = FALSE;
   int    close_conn;
   int logged[30];
   char   buffer[80];
   struct sockaddr_in6 addr;
   struct timeval      timeout;
   fd_set              master_set, working_set;

   listen_sd = socket(AF_INET6, SOCK_STREAM, 0);
   if (listen_sd < 0)
   {
      perror("socket() failed");
      exit(-1);
   }

   rc = setsockopt(listen_sd, SOL_SOCKET,  SO_REUSEADDR,
                   (char *)&on, sizeof(on));
   if (rc < 0)
   {
      perror("setsockopt() failed");
      close(listen_sd);
      exit(-1);
   }

   rc = ioctl(listen_sd, FIONBIO, (char *)&on);
   if (rc < 0)
   {
      perror("ioctl() failed");
      close(listen_sd);
      exit(-1);
   }

   memset(&addr, 0, sizeof(addr));
   addr.sin6_family = AF_INET6;
   memcpy(&addr.sin6_addr, &in6addr_any, sizeof(in6addr_any));
   addr.sin6_port = htons(SERVER_PORT);
   rc = bind(listen_sd,(struct sockaddr *)&addr, sizeof(addr));
   if (rc < 0)
   {
      perror("bind() failed");
      close(listen_sd);
      exit(-1);
   }

   rc = listen(listen_sd, 32);
   if (rc < 0)
   {
      perror("listen() failed");
      close(listen_sd);
      exit(-1);
   }

   FD_ZERO(&master_set);
   max_sd = listen_sd;
   FD_SET(listen_sd, &master_set);

   timeout.tv_sec  = 3 * 60;
   timeout.tv_usec = 0;

   do
   {
      memcpy(&working_set, &master_set, sizeof(master_set));
      sleep(1);
      printf("Waiting on select()...\n");
      rc = select(max_sd + 1, &working_set, NULL, NULL, &timeout);
      if (rc < 0)
      {
         perror("  select() failed");
         break;
      }
      if (rc == 0)
      {
         printf("  select() timed out.  End program.\n");
         break;
      }

      desc_ready = rc;
      for (i=0; i <= max_sd  &&  desc_ready > 0; ++i)
      {
         if (FD_ISSET(i, &working_set))
         {
            desc_ready -= 1;

            if (i == listen_sd)
            {
               printf("  Listening socket is readable\n");

               do
               {
                  new_sd = accept(listen_sd, NULL, NULL);
                  if (new_sd < 0)
                  {
                     if (errno != EWOULDBLOCK)
                     {
                        perror("  accept() failed");
                        end_server = TRUE;
                     }
                     break;
                  }

                  printf("  New incoming connection - %d\n", new_sd);
                  FD_SET(new_sd, &master_set);
                  if (new_sd > max_sd)
                     max_sd = new_sd;

               } while (new_sd != -1);
            }
            else
            {
               printf("  Descriptor %d is readable\n", i);
               close_conn = FALSE;
               
               //receive all incoming data on this socket
               //do
              // {
                  bzero(buffer,255);
                  if(logged[i] == TRUE){
                        rc = recv(i, buffer, sizeof(buffer), 0);
                        if(rc>0){
                           write(1, buffer, rc);
                           if(strncmp(buffer, "putProtocol", 12) == 0){ 
                              printf("starting put protocol\n");
                              putProtocol(i);
                           }

                              if(strncmp(buffer, "getProtocol", 12) == 0){ 
                              printf("starting get protocol\n");
                              getProtocol(i);
                           }
                           len = rc;
                           printf("  %d bytes received\n", len);
                           char* params[80];
                           char* temp_buf;
                           memcpy(temp_buf, buffer, len);
                           temp_buf[len] = '\0';

                           params_from_buffer(params, temp_buf);
                           executeBasic(params, i);
                        }
                        if (rc < 0)
                        {
                           if (errno != EWOULDBLOCK)
                           {
                              perror("  recv() failed");
                              close_conn = TRUE;
                           }
                           break;
                        }

                        if (rc == 0)
                        {
                           printf("  Connection closed\n");
                           close_conn = TRUE;
                           break;
                        }

                  }
                  else {
                     rc = recv(i, buffer, sizeof(buffer), 0);
                     if (rc < 0)
                     {
                        if (errno != EWOULDBLOCK)
                        {
                           perror("  recv() failed");
                           close_conn = TRUE;
                        }
                        break;
                     }

                     if (rc == 0)
                     {
                        printf("  Connection closed\n");
                        close_conn = TRUE;
                        break;
                     }

                     len = rc;
                     printf("  %d bytes received\n", len);

                     if(strncmp(buffer, "okon", 4) == 0){ //checking password
                        rc = send(i,"You logged\n", 12, 0);
                        if (rc < 0)
                        {
                              perror("  send() failed");
                              close_conn = TRUE;
                              break;
                        }
                        logged[i] = TRUE;
                        }
                     else{
                        rc = send(i, "Incorrect password\n", 19, 0);
                        if (rc < 0)
                        {
                              perror("  send() failed");
                              close_conn = TRUE;
                              break;
                        }
                     }
                  }


               //} while (TRUE);

               if (close_conn)
               {
                  close(i);
                  FD_CLR(i, &master_set);
                  if (i == max_sd)
                  {
                     while (FD_ISSET(max_sd, &master_set) == FALSE)
                        max_sd -= 1;
                  }
               }
            } /* End of existing connection is readable */
         } /* End of if (FD_ISSET(i, &working_set)) */
      } /* End of loop through selectable descriptors */

   } while (end_server == FALSE);
   //cleaning all left sockets
   for (i=0; i <= max_sd; ++i)
   {
      if (FD_ISSET(i, &master_set))
         close(i);
   }
}