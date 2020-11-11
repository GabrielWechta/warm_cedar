%{
#include <stdio.h>
int yywrap();
int yylex();
int NL = 0;
%}

%%
\n { NL++ ;}
%%

int yywrap() 
{ 
	printf("---\n%d", NL); 
	return 1;
}
int main() { return yylex(); }
