%{
#include <string.h>
#include <stdlib.h>
#include <math.h>
#define stack_size 100
static int sp;
static int error_flag;
static char corrupted_char; 
static int stack [stack_size];
static void push(int i) {
    if (++sp< stack_size) {
	//printf("\nin:%d\n",i);;
        stack[sp] = i;
	}
    else {
	//printf ("error: Stack Overflow\n");
	error_flag = 1;
	}
}
static int pop(void) {
    if (sp >= 0) {
        return stack[sp--];
	}
    else {
        //printf ("error: Not enough operators\n");
	error_flag = 2;
	}
}


%}
%x ERROR
digit [0-9]
integer [-]?{digit}+

%%
		
		
<INITIAL>{integer} 		{ECHO; push(atoi(yytext));} 
<INITIAL>"+"                     {ECHO; int poped = pop(); push(pop() + poped);if ( error_flag > 0 ) BEGIN(ERROR);}
<INITIAL>"*"                     {ECHO; int poped = pop(); push(pop() * poped);if ( error_flag > 0 ) BEGIN(ERROR);}
<INITIAL>"-"			{ECHO; int poped = pop(); push(pop() - poped);if ( error_flag > 0 ) BEGIN(ERROR);}
<INITIAL>"/"			{ECHO; int poped = pop(); push(pop() / poped);if ( error_flag > 0 ) BEGIN(ERROR);}
<INITIAL>"%"			{ECHO; int poped = pop(); push(pop() % poped);if ( error_flag > 0 ) BEGIN(ERROR);}
<INITIAL>"^"			{ECHO; int poped = pop(); push(pow(pop(), poped));}
<INITIAL>"\n"			{if(sp != 0) {
					 printf("\nerror: Not enough operators\n");
					 sp = -1;
					}
				else {
					int answer = pop();
			 		printf("\n= %d\n", answer);
					}
				}
<INITIAL>[ \t\n]                 {ECHO;}
<INITIAL>[^-0-9+*/%\^ \t\n]+	{ECHO; BEGIN(ERROR);
			 error_flag = 3;
			corrupted_char = yytext[0];
			}

<ERROR>.		ECHO;
<ERROR>"\n"		{if(error_flag == 1) printf("\nerror: Stack Overflow\n");
			 if(error_flag == 2) printf("\nerror: Not enough numbers\n");
			 if(error_flag == 3) printf("\nerro: Invalid character '%c'\n", corrupted_char);
			 sp = -1;
			 error_flag = 0;
			 BEGIN(INITIAL);
			}
%%

int main(void) {
	sp = -1; 
	error_flag = 0;
	yylex();
	return 0; }
int yywrap(void) {return 1;}


