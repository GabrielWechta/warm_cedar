#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <signal.h>
#include <errno.h>

#define ANSI_COLOR_GREEN   "\x1b[38;5;10m"
#define ANSI_COLOR_RED     "\x1b[38;5;196m"
#define ANSI_COLOR_BLUE    "\x1b[36m"
#define ANSI_COLOR_NICE_BLUE    "\x1b[38;5;51m"
#define ANSI_COLOR_RESET   "\x1b[0m"

#define INPUT 0 // <
#define OUTPUT 1 // >
#define ERROR 2 // >
#define APPEND 3 // >>

void removeWhiteSpace(char* buf){
	if(buf[strlen(buf)-1]==' ' || buf[strlen(buf)-1]=='\n')
	buf[strlen(buf)-1]='\0';
	if(buf[0]==' ' || buf[0]=='\n') memmove(buf, buf+1, strlen(buf));
}

/* giving buf[] and separator c returns string divided by separator = param and number
of word in nr*/ 
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

void print_params(char** param){
	while(*param){
		printf("param= %s..\n",*param++);
	}
}

void executeBasic(char** argv){
	if(fork()>0){
		wait(NULL);
	}
	else{
		execvp(argv[0],argv);
		perror(ANSI_COLOR_RED   "invalid input"   ANSI_COLOR_RESET "\n");
		exit(1);
	}
}

/*
loads and executes a series of external commands that are piped together
*/
void executePiped(char** buf,int nr){
	if(nr>10) return;
	
	int fd[10][2],i,pc;
	char *argv[100];

	for(i=0;i<nr;i++){
		tokenize_buffer(argv,&pc,buf[i]," ");
		if(i!=nr-1){ //end of pipes
			if(pipe(fd[i])<0){
				perror("error while creating a pipe\n");
				return;
			}
		}
		if(fork()==0){
			if(i!=nr-1){
				dup2(fd[i][1],1);
				close(fd[i][0]);
				close(fd[i][1]);
			}

			if(i!=0){
				dup2(fd[i-1][0],0);
				close(fd[i-1][1]);
				close(fd[i-1][0]);
			}
			execvp(argv[0],argv);
			perror("invalid input ");
			exit(1);
		}
		
		if(i!=0){
			close(fd[i-1][0]);
			close(fd[i-1][1]);
		}
		wait(NULL);
	}
}

void executeAsync(char** buf,int nr){
	int i,pc;
	char *argv[100];
	int child = fork();

    if (child == 0) {
        tokenize_buffer(argv,&pc,buf[i]," ");
        // print_params(argv);
        execvp(argv[0],argv);
		perror("invalid input ");
	} 
}


void executeRedirect(char** buf,int nr,int mode){
	int pc,fd;
	char *argv[100];
	removeWhiteSpace(buf[1]);
	tokenize_buffer(argv,&pc,buf[0]," ");
	if(fork()==0){

		switch(mode){
		case INPUT:  fd=open(buf[1],O_RDONLY); break;
		case OUTPUT: fd=open(buf[1],O_WRONLY); break;
        case ERROR: fd=open(buf[1],O_WRONLY); break;
		case APPEND: fd=open(buf[1],O_WRONLY | O_APPEND); break;
		default: return;
		}

		if(fd<0){
			perror("cannot open file\n");
			return;
		}

		switch(mode){
		case INPUT:  		dup2(fd,0); break;
		case OUTPUT: 		dup2(fd,1); break;
        case ERROR: 		dup2(fd,2); break;
		case APPEND: 		dup2(fd,1); break;
		default: return;

		}
		execvp(argv[0],argv);
		perror("invalid input ");
		exit(1);//in case exec is not successfull, exit
	}
	wait(NULL);
}

/*
shows the internal help
*/
void showHelp(){
	printf(ANSI_COLOR_GREEN   "HELP:"   ANSI_COLOR_RESET "\n");
	printf(ANSI_COLOR_GREEN   "How nice to be here, in that shell,"   ANSI_COLOR_RESET "\n");
	printf(ANSI_COLOR_GREEN   "this dummy shell uses c to simulate real, cool linux shell."   ANSI_COLOR_RESET "\n");
	printf(ANSI_COLOR_GREEN   "You can do pipes, use background programs with &."   ANSI_COLOR_RESET "\n");
    printf(ANSI_COLOR_GREEN   "Don't be afraid of zombies (I am)."   ANSI_COLOR_RESET "\n");
    printf(ANSI_COLOR_GREEN   "You can dance with a file (<, >, >> and 2>)."   ANSI_COLOR_RESET "\n");
}

void handle_sigchld(int sig) {
  int saved_errno = errno;
  while (waitpid((pid_t)(-1), 0, WNOHANG) > 0) {}
  errno = saved_errno;
}

void handle_sigint(int sig) {
    printf(" killing process %d\n",getpid());
}


int main(char** argv,int argc)
{
	char buf[500],*buffer[100],buf2[500],buf3[500], *params1[100],*params2[100],*token,cwd[1024];
	int nr=0;

    signal(SIGCHLD, handle_sigchld);
    signal(SIGINT, handle_sigint);

    printf(ANSI_COLOR_BLUE   "--lsh dummy shell--"   ANSI_COLOR_RESET "\n");
    printf(ANSI_COLOR_NICE_BLUE   "built in commands:"   ANSI_COLOR_RESET "\n");
    printf(ANSI_COLOR_NICE_BLUE   "'exit' for exit"   ANSI_COLOR_RESET "\n");
    printf(ANSI_COLOR_NICE_BLUE   "'cd' for cd"   ANSI_COLOR_RESET "\n");
    printf(ANSI_COLOR_NICE_BLUE   "'help' for help (duh)"   ANSI_COLOR_RESET "\n");

	while(1){
		
		if (getcwd(cwd, sizeof(cwd)) != NULL)
		printf(ANSI_COLOR_GREEN "%s: " ANSI_COLOR_RESET, cwd);
		else 	perror("getcwd failed\n");

		fgets(buf, 500, stdin);

		if(strchr(buf,'|')){//pipe
			tokenize_buffer(buffer,&nr,buf,"|");
			executePiped(buffer,nr);
		}
		else if(strchr(buf,'&')){//background
			tokenize_buffer(buffer,&nr,buf,"&");
			executeAsync(buffer,nr);
		}
        else if(strstr(buf,"2>")){//redirect error
			tokenize_buffer(buffer,&nr,buf,"2>");
			if(nr==2)executeRedirect(buffer,nr, ERROR);
			else printf("Incorrect input redirection!(has to to be in this form: command 2> file)");
		}
		else if(strstr(buf,">>")){//append
			tokenize_buffer(buffer,&nr,buf,">>");
			if(nr==2)executeRedirect(buffer,nr,APPEND);
			else printf("Incorrect output redirection!(has to to be in this form: command >> file)");
		}
		else if(strchr(buf,'>')){//redirect out
			tokenize_buffer(buffer,&nr,buf,">");
			if(nr==2)executeRedirect(buffer,nr, OUTPUT);
			else printf("Incorrect output redirection!(has to to be in this form: command > file)");
		}
		else if(strchr(buf,'<')){//redirect in
			tokenize_buffer(buffer,&nr,buf,"<");
			if(nr==2)executeRedirect(buffer,nr, INPUT);
			else printf("Incorrect input redirection!(has to to be in this form: command < file)");
		}
		else{
			tokenize_buffer(params1,&nr,buf," ");
			if(strstr(params1[0],"cd")){//cd builtin command
				chdir(params1[1]);
			}
			else if(strstr(params1[0],"help")){//help builtin command
				showHelp();
			}
			else if(strstr(params1[0],"exit")){//exit builtin command
				exit(0);
			}
			else executeBasic(params1);
		}
	}

	return 0;
}