%{
#include <string.h>
#include <stdlib.h>
static int show_doc = 0;
%}

%x MULTI_LINE_D
%x MULTI_LINE_N
%x LINE_D
%x LINE_N
%x STRING

%%
<INITIAL>"//" 		BEGIN(LINE_N);
<INITIAL>"//!"|"///"	{if(show_doc) ECHO; BEGIN(LINE_D);}
<INITIAL>"/*"		BEGIN(MULTI_LINE_N);
<INITIAL>"/**"|"/*!" 	{if(show_doc) ECHO; BEGIN(MULTI_LINE_D);}
<INITIAL>\" 		{ECHO; BEGIN(STRING);}

<STRING>[^\\"] ECHO;
<STRING>"\\\\" ECHO;
<STRING>\\\" ECHO;
<STRING>\" {ECHO; BEGIN(INITIAL);}


<LINE_N>[^\\\n]+ ;
<LINE_N>\\ ;
<LINE_N>\\\n ;
<LINE_N>\n {ECHO; BEGIN(INITIAL);}

<LINE_D>[^\\\n]+ 	{if(show_doc) ECHO;}
<LINE_D>\\ 		{if(show_doc) ECHO;}
<LINE_D>\\\n 		{if(show_doc) ECHO;}
<LINE_D>\n 		{ECHO; BEGIN(INITIAL);}

<MULTI_LINE_N>[^*\n]+   ;
<MULTI_LINE_N>"*"	;
<MULTI_LINE_N>"*/" BEGIN(INITIAL);
<MULTI_LINE_N>\n        ;

<MULTI_LINE_D>[^*\n]+   {if(show_doc) ECHO;}
<MULTI_LINE_D>"*"	{if(show_doc) ECHO;}
<MULTI_LINE_D>"*/" 	{if(show_doc) ECHO; BEGIN(INITIAL);}
<MULTI_LINE_D>\n        {if(show_doc) ECHO;}
%%

int main(int argc, char* argv[]) {
	if(argc > 1){	
		if (strcmp(argv[1], "--show_doc_comments") == 0){
		show_doc = 1;
		}
	}
	yylex();
	return 0; }
int yywrap(void) {return 1;}

//Zacząć od dodania wypisywania " w stringach.
