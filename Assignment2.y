%{
#include <bits/stdc++.h>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
extern "C" FILE *outfile;

void yyerror(const char *s);
 %}


%union
{
	int int_val;
	float f_val;
	char *str;
}

%token <str> INT
%token <str> FLOAT
%type  <str> AddOp
%type  <str> MulOp
%token <str> BOOLEAN
%token <str> KEYWORD
%token <str> IDENTIFIER
%token <str> PLUS
%token <str> SUB
%token <str> MUL
%token <str> DIV
%token <str> MOD
%token <str> EQ
%token <str> EQEQ
%token <str> LT
%token <str> GT
%token <str> LTE
%token <str> GTE
%token <str> OPCUR
%token <str> CLCUR
%token <str> OPBR
%token <str> CLBR
%token <str> OPAR
%token <str> CLAR
%token <str> SCOLON

%%
program:
       KEYWORD IDENTIFIER OPBR CLBR OPCUR typelines CLCUR { fprintf( outfile,"Program encountered\n");}
       ;
typelines:
         typelines typeline
         |
         typeline
typeline:
         declaration
         |
         Assignment
         ;

declaration:
        KEYWORD IDENTIFIER SCOLON
	{
		if (strcmp ($1, "int") == 0)
			fprintf( outfile,"Int declaration encountered\n");
		else if(strcmp ($1, "bool") == 0)
			fprintf( outfile,"Boolean declaration encountered\n");
		fprintf( outfile,"Id=%s\n", $2);
	}
        |
	KEYWORD IDENTIFIER OPAR INT CLAR SCOLON
	{
		if (strcmp ($1, "int") == 0)
			fprintf( outfile,"Int declaration encountered\n");
		else if(strcmp ($1, "bool") == 0)
			fprintf( outfile,"Boolean declaration encountered\n");
		fprintf( outfile,"Id=%s\nSize=%s\n", $2, $4);
	}
        ;

Assignment:
        Assignee EQ Expression SCOLON
	{
		fprintf( outfile,"Assignment operation encountered\n");
	}

Assignee:
        IDENTIFIER
        |
	IDENTIFIER OPAR Expression CLAR
        ;

Expression:
        Term
        |
	Expression AddOp Term
	{
		fprintf( outfile,"%s\n", $2);
	}
        ;

Term:
        Factor
        |
	Factor MulOp Term
	{
		fprintf( outfile,"%s\n", $2);
	}
        ;

Factor:
        IDENTIFIER
        |
	IDENTIFIER OPAR Expression CLAR
        |
	Literal
        |
	OPBR Expression CLBR
        ;

Literal:
        INT
	{
		fprintf( outfile,"Integer literal encountered\nValue=%s\n", $1);
	}
        |
        BOOLEAN
	{
		fprintf( outfile,"Boolean literal encountered\nValue=%s\n", $1);
	}
        ;

AddOp:
        PLUS
	{
		$$ = "Addition expression encountered";
	}
        |
        SUB
	{
		$$ = "Subtraction expression encountered";
	}
        ;

MulOp:
        DIV
	{
		$$ = "Division expression encountered";
	}
        |
        MUL
	{
		$$ = "Multiplication expression encountered";
	}
        |
        MOD
	{
		$$ = "Modulus expression encountered";
	}
        ;

%%

int main(int argc, char **argv)
{
	outfile = fopen("bison_output.txt", "w");
	if (argc > 0)
		yyin = fopen(argv[1], "r");
	else
		yyin = stdin;
	while (!feof(yyin))
		yyparse();
	cout << "Success" << endl;
}

void yyerror(const char *s)
{
	cout << "Syntax error" << endl;
	exit(-1);
}
