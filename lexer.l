NUMERO [0-9]+
IDENTIFICADOR [a-zA-Z][a-zA-Z0-9_]*
ESPACO [ ]+
QUEBRA_DE_LINHA [\n]
TAB [\t]+
OPERADOR_ARITMETICO "+"|"-"|"*"|"/"|"%"|"++"|"--"
OPERADOR_RELACIONAL "=="|"<"|">"|"<="|">="|"!="
OPERADOR_LOGICO "&&"|"||"|"!"
OPERADOR_ATRIBUICAO "="
SIMBOLO "\""|"'"|":"|"("|")"|"{"|"}"|","|";"|"."|"'"|"&"|"["|"]"

ID[a-zA-Z][a-zA-Z0-9_]*
int[0-9]+
real[0-9]+"."?[0-9]+

%option noyywrap
%{
    #include <stdio.h>

%}

%x COMMENT


%%

"/*" {BEGIN(COMMENT);}
<COMMENT>"*/" { BEGIN(INITIAL); }
<COMMENT>.|\n

<COMMENT><<EOF>> {printf("\nERRO - COMENTÁRIO SEM FIM\n\n"); return 0;}

"//".*                                    { /* Ignorar comentários de linha */ }

{IDENTIFICADOR}		{ printf("IDENTIFICADOR: %s\n", yytext); }
{NUMERO}               { printf("NUMERO: %s\n", yytext); }
{OPERADOR_ARITMETICO}  { printf("OPERADOR ARITMETICO: %s\n", yytext); }
{OPERADOR_RELACIONAL}  { printf("OPERADOR RELACIONAL: %s\n", yytext); }
{OPERADOR_LOGICO}		 { printf("OPERADOR LOGICO: %s\n", yytext); }
{OPERADOR_ATRIBUICAO}	 { printf("OPERADOR ATRIBUICAO: %s\n", yytext); }
{SIMBOLO}	 			 { printf("SIMBOLO: %s\n", yytext); }
{TAB}			 	     { /* Ignorar tabs */}
{ESPACO}			 	 { /* Ignorar espaços */ }
{QUEBRA_DE_LINHA}      { /* Ignorar quebras de linha */ }

"_"{IDENTIFICADOR}|{NUMERO}{IDENTIFICADOR}|"_"{NUMERO}{IDENTIFICADOR}|"_"{IDENTIFICADOR}|{NUMERO}"_"{IDENTIFICADOR} { printf("\nERRO - VARIAVEL NAO PERMITIDA: %s\n\n", yytext); }

.                    { printf("\nERRO - CARACTER_DESCONHECIDO: %s\n\n", yytext); }

%%

int main(){

    extern FILE *yyin, *yyout;

    yyin = fopen("teste.txt", "r");

    yyout = fopen("Output.txt", "w");
    
    yylex();
    return 0;
}