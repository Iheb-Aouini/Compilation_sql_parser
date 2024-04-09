%{
#include <stdio.h>
#include "sql.tab.h"
int numID=0; 
int errlx=0;

int oldstate;
int numTOK=0;

 int numNUM=0; 
 int numOP=0; 
 int numCAR=0;
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
CHIFFRE [0-9]+
ID [A-Za-z][A-Za-z0-9]*
IGNORE (" "|\t|\n)* 
QUIT [Qq][Uu][Ii][Tt]

%%
{QUIT}	{printf("\nLa phase d'analyse lexical est terminé -> Resultat de l'analyseur lexical : \n\t - Nombres d'erreurs Lexical(Caracteres inconnus ) : %d\n\t - Mots cle: %d\n\t - IDs: %d\n\t - Numeros: %d\n\t - Operateurs: %d\n\t - Caracteres speciaux(*,;): %d\n", errlx,numTOK,numID,numNUM,numOP, numCAR); return 0;}

{PRINT}   	{printf("\n Nombre des champs : %d ", numID); return 0;}
{AND}		{printf(" AND %s\n", yytext); ++numTOK; return AND;}
{OR}		{printf(" OR: %s\n", yytext); ++numTOK; return OR;}
{PAR_OUV}	    {printf(" PAR_OUV: %s\n", yytext); ++numTOK; return PAR_OUV;}
{PAR_FER}	    {printf(" PAR_FER: %s\n", yytext); ++numTOK; return PAR_FER;}
{PT_VIR}	    {printf(" PT_VIR: %s  \n===> SQL requete , line %d : ", yytext,yylineno); ++numTOK; return PT_VIR;}
{VIR}		    {printf(" VIR: %s\n", yytext); ++numTOK; ; return VIR;}
{PT}		    {printf(" PT: %s\n", yytext); ++numTOK; return PT;} 
{COTE}	        {printf(" COTE: %s\n", yytext); ++numTOK; return COTE;}
{DOUBLECOTE}	{printf(" DOUBLECOTE: %s\n", yytext); ++numTOK; return DOUBLECOTE;}
{ETOILE}		{printf(" ETOILE: %s\n", yytext); ++numTOK; return ETOILE;}
{GREATERorEQUAL}	{printf(" GREATERorEQUAL: %s\n", yytext); ++numTOK; return GREATERorEQUAL;}
{LESSorEQUAL}		{printf(" LESSorEQUAL: %s\n", yytext);++numTOK;return LESSorEQUAL;}
{DISTINCT}	    {printf(" DISTINCT: %s\n", yytext); ++numTOK; return DISTINCT;}
{LESSER}	    {printf(" LESSER: %s\n", yytext); ++numTOK; return LESSER;}
{GREATER}	    {printf(" GREATER: %s\n", yytext); ++numTOK; return GREATER;}
{EQUAL}		    {printf(" EQUAL: %s\n", yytext); ++numTOK; return EQUAL;}
{CREATE}	    {printf(" CREATE: %s\n", yytext); ++numTOK; return CREATE;}
{TABLE}		    {printf(" TABLE: %s\n", yytext); ++numTOK; return TABLE;}
{SELECT}	    {printf(" SELECT: %s\n", yytext); ++numTOK; return SELECT;}
{SET}	    {printf(" SET: %s\n", yytext); ++numTOK; return SET;}
{UPDATE}	    {printf(" UPDATE: %s\n", yytext); ++numTOK; return UPDATE;}
{DELETE}	{printf(" DELETE: %s\n", yytext); ++numTOK; return DELETE;}
{INSERT}	{printf(" INSERT: %s\n", yytext); ++numTOK; return INSERT;}
{INTO}		{printf(" INTO: %s\n", yytext); ++numTOK; return INTO;}
{VALUES} 	{printf(" VALUES: %s\n", yytext); ++numTOK; return VALUES;}
{FROM}		{printf(" FROM: %s\n", yytext); ++numTOK; return FROM;}
{WHERE}		{printf(" WHERE: %s\n", yytext); ++numTOK; return WHERE;}
{GROUP}		{printf(" GROUP: %s\n", yytext); ++numTOK; return GROUP;}
{ORDER}		{printf(" ORDER: %s\n", yytext); ++numTOK;  return ORDER;}
{BY}		{printf(" BY: %s\n", yytext); ++numTOK; return BY;}
{ASC}		{printf(" ASC: %s\n", yytext); ++numTOK; return ASC;}
{DESC}		{printf(" DESC: %s\n", yytext); ++numTOK; return DESC;}
{NUMBER}	{printf(" NUMBER: %s\n", yytext) ; ++numTOK; return NUMBER;}
{STRING}	{printf(" STRING: %s\n", yytext) ; ++numTOK; return STRING;}
{ID}		{printf(" ID: %s\n", yytext); ++numID; ++numTOK; return ID; return numTOK;}
{CHIFFRE}	{printf(" NUM: %s\n", yytext); ++numTOK; return NUM;}
.		    {

   	fprintf(stderr,"Erreur lexicale | Ligne: %d , What do you mean by : '%s' !\n",yylineno,yytext); exit(1);
   }
%%

int yywrap()
 {
    return 0    ;
    }