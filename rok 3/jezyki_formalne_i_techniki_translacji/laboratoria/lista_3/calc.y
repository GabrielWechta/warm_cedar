/* Infix notation calculator. */
%{

#include <math.h>
#include <stdio.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%token NUM
%left '-' '+'
%left '*' '/'
%precedence NEG 
%right '^' 

%start input

%%

input:
	| input line
;
line:
	'\n'
	| exp '\n' { printf ("\t%d\n", $1); }
;
exp:
	NUM
	| exp '+' exp { $$ = $1 + $3; }
	| exp '-' exp { $$ = $1 - $3; }
	| exp '*' exp { $$ = $1 * $3; }
	| exp '/' exp { $$ = $1 / $3; }
	| '-' exp %prec NEG { $$ = -$2; }
	| exp '^' exp { $$ = pow($1, $3); }
	| '(' exp ')' { $$ = $2; }
;
%%

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	return ;
}
