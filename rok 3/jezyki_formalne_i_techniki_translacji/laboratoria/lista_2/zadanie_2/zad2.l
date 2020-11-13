%{
#include <stdio.h>
int yywrap();
int yylex();
%}
%x ONE_Q
%x ONE_A
%x THREE_Q
%x THREE_A
%%

<INITIAL>{
'{3}		{ECHO; BEGIN(THREE_A);}
\"\"\"		{ECHO; BEGIN(THREE_Q);}
'		{ECHO; BEGIN(ONE_A);}
\"		{ECHO; BEGIN(ONE_Q);}
#.*\n		printf("\n");
} 

<THREE_A>{
'{3}		{ECHO; BEGIN(INITIAL);}
\\\\		{ECHO;}
\\'{3}		ECHO;
} 

<THREE_Q>{
\"\"\"		{ECHO; BEGIN(INITIAL);}
\\\\		{ECHO;}
\\\"\"\"	ECHO;
} 

<ONE_A>{
'		{ECHO; BEGIN(INITIAL);}
\\\\		{ECHO;}
\\'		ECHO;
} 

<ONE_Q>{
\"		{ECHO; BEGIN(INITIAL);}
\\\\		{ECHO;}
\\\"		ECHO;
} 

%%

int yywrap() { return 1; }
int main() { return yylex(); }


