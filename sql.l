%{
#include <stdio.h>
#include "sql.tab.h"
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
IGNORE (" "|\t|\n)* 
QUIT [Qq][Uu][Ii][Tt]

%%
{QUIT}	{ return 0;}
{PRINT}   	{printf("\n Nombre des champs : %d ", numID); return 0;}
{AND}		{printf(" AND %s\n", yytext); return AND;}
{OR}		{printf(" OR: %s\n", yytext); return OR;}
{PAR_OUV}	    {printf(" PAR_OUV: %s\n", yytext); return PAR_OUV;}
{PAR_FER}	    {printf(" PAR_FER: %s\n", yytext); return PAR_FER;}
{PT_VIR}	    {printf(" PT_VIR: %s\nSQL requete , line %d : \n", yytext,yylineno+1); return PT_VIR;}
{VIR}		    {printf(" VIR: %s\n", yytext); ; return VIR;}
{PT}		    {printf(" PT: %s\n", yytext); return PT;}
{COTE}	        {printf(" COTE: %s\n", yytext); return COTE;}
{DOUBLECOTE}	{printf(" DOUBLECOTE: %s\n", yytext); return DOUBLECOTE;}
{ETOILE}		{printf(" ETOILE: %s\n", yytext); return ETOILE;}
{GREATERorEQUAL}	{printf(" GREATERorEQUAL: %s\n", yytext); return GREATERorEQUAL;}
{LESSorEQUAL}		{printf(" LESSorEQUAL: %s\n", yytext);return LESSorEQUAL;}
{DISTINCT}	    {printf(" DISTINCT: %s\n", yytext); return DISTINCT;}
{LESSER}	    {printf(" LESSER: %s\n", yytext); return LESSER;}
{GREATER}	    {printf(" GREATER: %s\n", yytext); return GREATER;}
{EQUAL}		    {printf(" EQUAL: %s\n", yytext); return EQUAL;}
{CREATE}	    {printf(" CREATE: %s\n", yytext); return CREATE;}
{TABLE}		    {printf(" TABLE: %s\n", yytext); return TABLE;}
{SELECT}	    {printf(" SELECT: %s\n", yytext); return SELECT;}
{SET}	    {printf(" SET: %s\n", yytext); return SET;}
{UPDATE}	    {printf(" UPDATE: %s\n", yytext); return UPDATE;}
{DELETE}	{printf(" DELETE: %s\n", yytext); return DELETE;}
{INSERT}	{printf(" INSERT: %s\n", yytext); return INSERT;}
{INTO}		{printf(" INTO: %s\n", yytext); return INTO;}
{VALUES} 	{printf(" VALUES: %s\n", yytext); return VALUES;}
{FROM}		{printf(" FROM: %s\n", yytext);  return FROM;}
{WHERE}		{printf(" WHERE: %s\n", yytext);  return WHERE;}
{GROUP}		{printf(" GROUP: %s\n", yytext); return GROUP;}
{ORDER}		{printf(" ORDER: %s\n", yytext);  return ORDER;}
{BY}		{printf(" BY: %s\n", yytext); return BY;}
{ASC}		{printf(" ASC: %s\n", yytext); return ASC;}
{DESC}		{printf(" DESC: %s\n", yytext); return DESC;}
{NUMBER}	{printf(" NUMBER: %s\n", yytext) ; return NUMBER;}
{STRING}	{printf(" STRING: %s\n", yytext) ; return STRING;}
{ID}		{printf(" ID: %s\n", yytext);++numID; return ID; return numID;}             
{Chiffre}	{printf(" NUM: %s\n", yytext); return NUM;}
{IGNORE}	{}
.		    {printf("Caractere non reconnu: %s\n", yytext); return ERROR;}
%%

int yywrap()
 {
    return 0    ;
    }