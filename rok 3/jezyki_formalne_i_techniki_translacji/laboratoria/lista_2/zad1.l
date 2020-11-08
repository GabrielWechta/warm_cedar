%{
#include <stdio.h>
int yywrap();
int yylex();
int NEWLINES = 0;
int NUMBER_OF_WORDS = 0;
%}
%%
^[\t" "]+ ;
[\t" "]+$ ;
[\t" "]+ printf(" ");
\n	{ NEWLINES += 1; }		
	
[a-zA-Z0-9]+ { 	printf("%s",yytext);
		NUMBER_OF_WORDS++;
		}
%%

int yywrap() 
{ 
	printf("\n---\nlines = %d\nwords = %d\n", NEWLINES, NUMBER_OF_WORDS); 
	return 1;
}
int main() { return yylex(); }


