%{
#include <stdio.h>
int yywrap();
int yylex();
int NEWLINES = 0;
int NUMBER_OF_WORDS = 0;
%}
%%
^[\t" "\n]+ ; 
[\t" "]+$ ;
[\t" "]+ printf(" ");
\\\n	;
\n	{ ECHO; NEWLINES += 1; }		
	
[^\n\t" "\\]+ { 	printf("%s",yytext);
		NUMBER_OF_WORDS++;
		}
%%

int yywrap() 
{ 
	printf("\n---\nlines = %d\nwords = %d\n", NEWLINES, NUMBER_OF_WORDS); 
	return 1;
}
int main() { return yylex(); }

//co z "\\n"?
