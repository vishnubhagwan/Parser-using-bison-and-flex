%{
#include <bits/stdc++.h>
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "tok.h"  // to get the token types that we return

%}

            FILE *outfile;
%%
[0-9]+                                      {yylval.str     = strdup(yytext); return INT;}
[0-9]+"."[0-9]+                             {yylval.str     = strdup(yytext); return FLOAT;}
true|false                                  {yylval.str     = strdup(yytext); return BOOLEAN;}
int|bool                                    {yylval.str     = strdup(yytext); return KEYWORD;}
[a-zA-Z][a-zA-Z0-9_]*                       {yylval.str     = strdup(yytext); return IDENTIFIER;}
"+"                                         {yylval.str     = strdup(yytext); return PLUS;}
"-"                                         {yylval.str     = strdup(yytext); return SUB;}
"*"                                         {yylval.str     = strdup(yytext); return MUL;}
"/"                                         {yylval.str     = strdup(yytext); return DIV;}
"%"                                         {yylval.str     = strdup(yytext); return MOD;}
"="                                         {yylval.str     = strdup(yytext); return EQ;}
"=="                                        {yylval.str     = strdup(yytext); return EQEQ;}
"<"                                         {yylval.str     = strdup(yytext); return LT;}
">"                                         {yylval.str     = strdup(yytext); return GT;}
"<="                                        {yylval.str     = strdup(yytext); return LTE;}
">="                                        {yylval.str     = strdup(yytext); return GTE;}
"{"                                         {yylval.str     = strdup(yytext); return OPCUR;}
"}"                                         {yylval.str     = strdup(yytext); return CLCUR;}
"("                                         {yylval.str     = strdup(yytext); return OPBR;}
")"                                         {yylval.str     = strdup(yytext); return CLBR;}
";"                                         {yylval.str     = strdup(yytext); return SCOLON;}
"["                                         {yylval.str     = strdup(yytext); return OPAR;}
"]"                                         {yylval.str     = strdup(yytext); return CLAR;}
\/\/.*                                      /* Ignore one line commments */
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]         /* Ignore multi line comments */
[/][*]                                      /* Handling the case where slash* is present only */
[ \t]*                                      {}
[\n]                                        {yylineno++;}
.                                           {/*printf("Error by lexical analyser"); exit(1);*/}
%%
