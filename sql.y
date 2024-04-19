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
int nb_champ=1;
int is_select_all=0;
%}


//Declaration des Terminaux (miniscule) utilisés (.l) : 
%locations

//les Tokens 
%token AND 
%token OR 
%token LESSorEQUAL 
%token GREATERorEQUAL 
%token DISTINCT 
%token GREATER 
%token LESSER
%token EQUAL 
%token CREATE
%token TABLE 
%token SELECT 
%token UPDATE
%token SET

%token DELETE 
%token INSERT 
%token INTO 
%token FROM 
%token WHERE 
%token GROUP 
%token ORDER 
%token BY 
%token ASC 
%token DESC 
%token STRING 
%token NUMBER 
%token VALUES 
%token PAR_OUV 
%token PAR_FER 
%token PT_VIR 
%token VIR 
%token PT 
%token COTE 
%token DOUBLECOTE 
%token ETOILE 
%token ID 
%token NUM
%token IGNORE 
%token ERROR
%token QUIT


//Régles de production de grammaire : nT -> nT | T | nT ... 

%start grammaire
%%
grammaire : Axiome;
Axiome	: requete PT_VIR loop | QUIT PT_VIR | QUIT;
loop	: Axiome | /*epsilon*/ ;
requete	: creer | selectionner | delete | insertion | update ;
creer	: CREATE TABLE newTable {printf(" Creation de la table \n\n");};
newTable : ID PAR_OUV Colonne PAR_FER | ID ;
selectionner : SELECT id FROM table options{printf(" Affichage de(s) ligne(s) de la table ") ; if (is_select_all==0) {printf("\n Nombre de champ de cet requete : %d\n\n",nb_champ) ;} else {printf("\n Nombre de champ de cet requete :Selection de Tous les champs (Etoile) \n\n") ;} nb_champ=1;is_select_all=0;};
options	: opt1 | opt2 | opt3 | /*epsilon*/ ;
opt1	: WHERE exp opt4 | /*epsilon*/;
opt2	: ORDER BY table ASC  opt5 | ORDER BY table DESC opt5;
opt3	: GROUP BY ID;
opt4 	: opt2 | opt3 | /*epsilon*/;
opt5 	: opt3 | /*epsilon*/;
delete 	: DELETE FROM table opt1 { printf("Suppression de(s) ligne(s) de la table \n\n");};

update : UPDATE table SET Colonne operateur type WHERE Colonne operateur type {printf("Mise a jour effectué avec succes \n\n");};

insertion : INSERT INTO table VALUES PAR_OUV ident1 PAR_FER {printf("Insertion d'une ligne dans la table \n\n");};
ident1	: ident2 | COTE text COTE | NUM | DOUBLECOTE text DOUBLECOTE ;
ident2	: ID | ID PT ID;
id	: identificatuers | ETOILE {is_select_all=1;}  ;
exp	: ident1 operateur ident1 opcexp  | PAR_OUV ident1 operateur ident1 opcexp PAR_FER opcexp;
opcexp	: /*epsilon*/ | logique exp;
text	: Ponct | Ponct text;
Ponct	: ID | VIR | PT | NUM;
identificatuers	: ident2 | ident2 VIR identificatuers {nb_champ++;};
Colonne	: ID | ID VIR Colonne;
type	: NUM | STRING;
table   : ID | ID VIR table;
operateur : GREATERorEQUAL | LESSorEQUAL | GREATER | LESSER | DISTINCT | EQUAL;
logique	  : AND | OR;

%%

int yyerror(const char *str)
{	
    	fprintf(stderr,"Erreur syntaxique | Ligne: %d\n%s\n",yylineno,str);   
    int a;
    scanf("%d",&a);
}

int main (int argc, char *argv[])
{++argv,--argc;
printf("Debut de l'analyse\n\n");

	yyparse();
	printf("");
	    getchar();
	printf("\n\nFin de l'analyse \n \n");

    freopen("/dev/tty", "r", stdin); // to redirect input to the terminal

   char str[5]; 
  printf("Do you want to scan another sql script [Y|N] : ");
  scanf("%s", str);
  if (str[0]=='Y'){
    printf("\033[2J"); // Clear the screen using ANSI escape sequence
    printf("\033[1;1H"); // Move cursor to top-left corner       

	char filename[100];
	printf("\n Enter filename of the sql script : ");
	scanf("%s", filename);
	char command[115];  
    sprintf(command, "./sql < %s", filename);
	system(command);
  }
  else {
	printf("\n Bye \n");
  }
	return 0;
}; 