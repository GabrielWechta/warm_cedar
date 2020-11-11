%{
#include <stdio.h>
int yywrap();
int yylex();
int NEWLINES = 0;
int NUMBER_OF_WORDS = 0;
%}
%s qstring
%%
<qstring>["] 	BEGIN(INITIAL);
<qstring>.* 	printf("\"%s",yytext);
<INITIAL>["]		BEGIN(qstring);
<INITIAL>[#].*[\n]? ;
%%

int yywrap() { return 1; }
int main() { return yylex(); }


