%{
#include<math.h>
#include <stdarg.h>
#include <string.h>

#include <stdio.h>
int numID=0; 
int errlx=0;
%}

%option yylineno
PRINT [Pp][Rr][Ii][Nn][Tt]
CREATE [Cc][Rr][Ee][Aa][Tt][Ee]
TABLE [Tt][Aa][Bb][Ll][Ee]
SELECT [Ss][Ee][Ll][Ee][Cc][Tt]
DELETE [Dd][Ee][Ll][Ee][Tt][Ee]
UPDATE [Uu][Pp][Dd][Aa][Tt][Ee]
INSERT [Ii][Nn][Ss][Ee][Rr][Tt]
INTO [Ii][Nn][Tt][Oo]
SET [Ss][Ee][Tt]
FROM [Ff][Rr][Oo][Mm]
WHERE [Ww][Hh][Ee][Rr][Ee]
GROUP [Gg][Rr][Oo][Uu][Pp]
ORDER [Oo][Rr][Dd][Ee][Rr]
BY [Bb][Yy]
ASC [Aa][Ss][Cc]
DESC [Dd][Ee][Ss][Cc]
STRING [Ss][Tt][Rr][Ii][Nn][Gg]
NUMBER [Nn][Uu][Mm][Bb][Ee][Rr]
VALUES [Vv][Aa][Ll][Uu][Ee][Ss]
AND [Aa][Nn][Dd]
OR [Oo][Rr]
LESSorEQUAL ("<=")
GREATERorEQUAL (">=")
DISTINCT ("!=")
GREATER \>
LESSER \<
EQUAL \=
PAR_OUV \(
PAR_FER \)
PT_VIR \;
VIR \,
PT \.
COTE \' 
DOUBLECOTE \"
ETOILE \*
Chiffre [0-9]+
ID [A-Za-z][A-Za-z0-9]*
WHITESPACE  [ \t]
QUIT [Qq][Uu][Ii][Tt]


%%
{QUIT}	{ return 0;}


{PRINT}   	{printf("\n Nombre des champs : %d ", numID);}
{AND}		{printf(" AND %s\n", yytext); }
{OR}		{printf(" OR: %s\n", yytext); }
{PAR_OUV}	    {printf(" PAR_OUV: %s\n", yytext);}
{PAR_FER}	    {printf(" PAR_FER: %s\n", yytext);}
{PT_VIR}	    {printf(" PT_VIR: %s\n", yytext);}
{VIR}		    {printf(" VIR: %s\n", yytext);  }
{PT}		    {printf(" PT: %s\n", yytext); }
{COTE}	        {printf(" COTE: %s\n", yytext); }
{DOUBLECOTE}	{printf(" DOUBLECOTE: %s\n", yytext); }
{ETOILE}		{printf(" ETOILE: %s\n", yytext); }
{GREATERorEQUAL}	{printf(" GREATERorEQUAL: %s\n", yytext); }
{LESSorEQUAL}		{printf(" LESSorEQUAL: %s\n", yytext);}
{DISTINCT}	    {printf(" DISTINCT: %s\n", yytext); }
{LESSER}	    {printf(" LESSER: %s\n", yytext); }
{GREATER}	    {printf(" GREATER: %s\n", yytext); }
{EQUAL}		    {printf(" EQUAL: %s\n", yytext); }
{CREATE}	    {printf(" CREATE: %s\n", yytext); }
{TABLE}		    {printf(" TABLE: %s\n", yytext); }
{SELECT}	    {printf(" SELECT: %s\n", yytext); }
{SET}	    {printf(" SET: %s\n", yytext); }
{UPDATE}	    {printf(" UPDATE: %s\n", yytext); }
{DELETE}	{printf(" DELETE: %s\n", yytext); }
{INSERT}	{printf(" INSERT: %s\n", yytext); }
{INTO}		{printf(" INTO: %s\n", yytext); }
{VALUES} 	{printf(" VALUES: %s\n", yytext); }
{FROM}		{printf(" FROM: %s\n", yytext);  }
{WHERE}		{printf(" WHERE: %s\n", yytext);  }
{GROUP}		{printf(" GROUP: %s\n", yytext); }
{ORDER}		{printf(" ORDER: %s\n", yytext);  }
{BY}		{printf(" BY: %s\n", yytext); }
{ASC}		{printf(" ASC: %s\n", yytext); }
{DESC}		{printf(" DESC: %s\n", yytext); }
{NUMBER}	{printf(" NUMBER: %s\n", yytext) ; }
{STRING}	{printf(" STRING: %s\n", yytext) ; }
{ID}		{printf(" ID: %s\n", yytext);++numID;  }             
{Chiffre}	{printf(" NUM: %s\n", yytext); }
[ \t\n]+  { /* ignore whitespace */ }
\n          { /* end of line, do nothing */printf("new line"); }
.		    {printf("Caractere non reconnu: %s\n", yytext);  ++errlx;}
%%

int yywrap()
 {
    return 0    ;
    }
void main(){
    printf(" debut de l'analye lexicale \n ");
    yylex();
    printf("FIN de L'analyse lexical");
    printf("lex errro : %d",errlx);
    //getchar();
    }