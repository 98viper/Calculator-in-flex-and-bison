%{
	#include<math.h>
	#include<stdlib.h>
	#include "global.h"
	#include "calc.tab.h"
%}
nombre   [0-9]+(\.[0-9]+)?((e|E)(\+|\-)?[0-9]+)?
%%
{nombre} {yylval=atoi(yytext);return NOMBRE;}
"\n"	{return FIN;}
"+"	{return PLUS;}
"-"	{return MOINS;}
"*"	{return FOIS;}
"/"	{return DIV;}
"("	{return PO;}
")"	{return PF;}
"sin"	{return SINUS;}
"abs" {return ABSOLUE;}
"cos"	{return COSINUS;}
"log"	{return LOGARITHME;}
"tan"	{return TANGENTE;}
"sqrt"	{return CAREE;}
.	{}
%%
int yywrap(void){
	return 1;
}
