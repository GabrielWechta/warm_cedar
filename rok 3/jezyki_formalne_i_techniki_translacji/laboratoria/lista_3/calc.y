/* Infix notation calculator. */
%{

#include <math.h>
#include <stdio.h>
#include <string>
#include <iostream>
using namespace std;

extern int yylex();
extern int yyparse();
extern FILE* yyin;
string rpn = "";

int modexp(int x, int exp, int N){
	if(x == 0) return 0;
	if(exp == 0) return 1;

	long y;
	if(exp % 2 == 0) {
		y = modexp(x, exp / 2, N);
		y = (y * y) % N;
	}
	else {
		y = x % N;
		y = ( y * modexp(x, exp - 1, N) % N) % N;
	}

	return (y + N) % N;
}	

long long mul_inv(int a, int b)
{
	int b0 = b, t, q;
	long long x0 = 0, x1 = 1;
	if (b == 1) return 1;
	while (a > 1) {
		q = a / b;
		t = b;
		b = a % b;
		a = t;
		t = x0;
		x0 = x1 - q * x0;
		x1 = t;
	}
	if (x1 < 0) x1 += b0;
	return x1;
}

void yyerror(const char* s);
//#define p 5
#define p 1234577

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
	| exp '\n' { cout<< rpn<< endl; printf ("Wynik: %d\n", $1); rpn = ""; }
;
exp:
	  exp '+' exp { rpn += "+ "; $$ = ($1 + $3) % p; }
	| exp '-' exp { rpn += "- "; $$ = ((($1 - $3) % p ) + p ) % p; }
	| exp '*' exp { rpn += "* "; $$ = ($1 * $3) % p; }
	| exp '/' exp { rpn += "/ "; long long tmp = ((long long)$1 * mul_inv($3, p)) % (long long)p; $$ = tmp; }
	//| '-' exp %prec NEG { $$ = ((-$2 % p) + p) % p; }
	| exp '^' exp { rpn += "^ "; $$ = modexp($1, $3, p); }
	| '(' exp ')' { $$ = $2; }
	| num		{ $$ = $1; }
;
num:	
	NUM { $$ = (($1 % p) + p) % p; rpn += to_string($$) + " ";}
	| '-' NUM %prec NEG { $$ = ((-$2 % p) + p) % p; rpn += to_string($$) + " ";}

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
