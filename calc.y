%{
#include<stdio.h>
#include<math.h>
#include "global.h"
int yyerror(char *s);
int yylex();
%}
%token FIN NOMBRE PO PF RACINE
%left PLUS MOINS 
%left FOIS DIV
%left SINUS ABSOLUE COSINUS LOGARITHME TANGENTE //trigonometric functions have higher priority
%nonassoc POS NEG
%start R
%%
R: E FIN {printf("Resultat= %f" ,$1);return 0;}
;
E: E PLUS T {$$=$1 + $3;}
 | E MOINS T {$$=$1 - $3;}
 | T {$$=$1;}
 ;
T: T FOIS F {$$=$1 * $3;}
 | T DIV F {if($3==0){printf("division par zero interdite");return 1;}
 		    else $$=$1/$3;}
 | F {$$=$1;}
 ;
F: NOMBRE
 | PO E PF {$$=$2;}
 | MOINS F %prec NEG{$$=-$2;}
 | PLUS  F %prec POS{$$=+$2;}
 | SINUS PO F PF {$$=sin($3);}
 | ABSOLUE PO F PF {$$=fabs($3);} //we are working with floats therefor we need fabs to calculate the absolute value
 | COSINUS PO F PF {$$=cos($3);}
 | LOGARITHME PO F PF {if($3<0){printf("Impossible to apply log in a negative number");return 1;}else $$=log($3);}
 | TANGENTE PO F PF {$$=tan($3);}
 | RACINE PO F PF {$$=sqrt($3);}
 ;
%%
int yyerror(char *s){
  printf("%s",s);
  return 1;
}
int main (){
	printf("Enter your mathematical expression :");
	yyparse();
	return 0; 
}