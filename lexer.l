%{
#include <stdio.h>
%}

%%


[a-zA-Z][a-zA-Z0-9_]*    { printf("NOME_VARIAVEL: %s\n", yytext); }
[0-9]+               { printf("NUMERO: %s\n", yytext); }
"+"                  { printf("OPERADOR_SOMA\n"); }
"-"                  { printf("OPERADOR_SUBTRACAO\n"); }
"*"                  { printf("OPERADOR_MULTIPLICACAO\n"); }
"/"                  { printf("OPERADOR_DIVISAO\n"); }
"="                  { printf("ATRIBUICAO\n"); }
";"					 { printf("FINAL DE COMANDO: %s\n", yytext); }
","				     { printf("SEPARADOR: %s\n", yytext); }
"("					 { printf("ABRE PARENTESES: %s\n", yytext); }
")"					 { printf("FECHA PARENTESES: %s\n", yytext); }
"."					 { printf("BAGULHO DE SEPARAR DECIMAIS: %s\n", yytext); }
[ \t\r""]			 { printf("ESPACO: %s\n", yytext); }
[\n]            	 { /* Ignorar espaços em branco e quebras de linha */ }

.                    { printf("CARACTER_DESCONHECIDO: %s\n", yytext); }


%%

int main() {
    yylex();
    return 0;
}
