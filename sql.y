/*
*/


//Les bibliothéques nécessaires :
%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.c"
int yylex();
int yyerror();
%}


//Declaration des Terminaux (miniscule) utilisés (.l) : 
%locations

%token QUIT; 
%token ID;
%token DELETE;
%token UPDATE;
%token LIMIT;
%token FROM;
%token ORDER;
%token BY;
%token USING;
%token WHERE;
%token FIN;
%token ANDOP;
%token OR;
%token SET;
%left <subtok> COMPARISON /* != < > <= >= <=> */;
%token POINT;
%token INT;
%token SEP;
%token GROUP;
%token INTNUM;
%token EQUALS;
%token POSTROFE;
%token ETOILE;
%token SELECT;
%token AVG;
%token SUM;
%token COUNT;
%token INSERT;
%token INTO;
%token CREATE;
%token TABLE;
%token DATABASE;
%token PARAO;
%token PARAF;
%token VALUES;
%token DROP;
%left <subtok> TP ;
%left <subtok> CONDITION ;



//Régles de production de grammaire : nT -> nT | T | nT ... 

%start grammaire
%%
grammaire : Axiome;
Axiome	: requete PT_VIR loop;
loop	: Axiome | /*epsilon*/ ;
requete	: creer | selectionner | delete | insertion;
creer	: CREATE TABLE newTable;
newTable : ID PARAO Colonne PAR_FER | ID ;
selectionner : SELECT id FROM table options;
options	: opt1 | opt2 | opt3 | /*epsilon*/ ;
opt1	: WHERE exp opt4;
opt2	: ORDER BY table ASC  opt5 | ORDER BY table DESC opt5;
opt3	: GROUP BY ID;
opt4 	: opt2 | opt3 | /*epsilon*/;
opt5 	: opt3 | /*epsilon*/;
delete 	: DELETE FROM table opt1 { printf("Suppression de toutes les lignes de la table \n");};;
update : UPDATE table SET Colonne operateur type WHERE Colonne operateur type;
insertion : INSERT INTO table VALUES PARAO ident1 PAR_FER ;
ident1	: ident2 | COTE text COTE | NUM | DOUBLECOTE text DOUBLECOTE ;
ident2	: ID | ID PT ID;
id	: identificatuers | ETOILE;
exp	: ident1 operateur ident1 opcexp  | PARAO ident1 operateur ident1 opcexp PAR_FER opcexp;
opcexp	: /*epsilon*/ | logique exp;
text	: Ponct | Ponct text;
Ponct	: ID | VIR | PT | NUM;
identificatuers	: ident2 | ident2 VIR identificatuers;
Colonne	: ID type | ID type VIR Colonne;
type	: NUMBER | STRING;
table   : ID | ID VIR table;
operateur : GREATERorEQUAL | LESSorEQUAL | GREATER | LESSER | DISTINCT | EQUAL;
logique	  : AND | OR;

%%

int yyerror(const char *str)
{
    if (errlx>0) 
	{
   	fprintf(stderr,"Erreur lexicale | Ligne: %d\n%s\n",yylineno,str);
    }
    else 
	{
    	fprintf(stderr,"Erreur syntaxique | Ligne: %d\n%s\n",yylineno,str);
    }
    int a;
    scanf("%d",&a);
}

int main (int argc, char *argv[])
{++argv,--argc;
printf("SQL requete , line 1 \n");
	/*if ( argc >= 0 && argc!=NULL ){
	yyin = fopen (argv[1], "r");
	if (yyin == NULL)
		{
		printf ("Impossible d'ouvrir le fichier %s\n", argv[1]);
		exit (-1);
		}
	}
	else
	yyin = stdin;
	*/
	yyparse();
	printf("");
	    getchar();

	return 0;
}; 
