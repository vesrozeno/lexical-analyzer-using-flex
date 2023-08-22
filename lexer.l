NUMERO [0-9]+
IDENTIFICADOR [a-zA-Z][a-zA-Z0-9_]*
ESPACO [ ]+
QUEBRA_DE_LINHA [\n]
TAB [\t]+
CARRIAGE_RETURN [ \t\r]
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

%option yylineno
%x COMMENT


%%

"/*" {BEGIN(COMMENT);}
<COMMENT>"*/" { BEGIN(INITIAL); }
<COMMENT>.|\n

<COMMENT><<EOF>> {fprintf(yyout, "\t(ERRO - COMENTARIO SEM FIM)\n");return 0;}

"//".*                 { /* Ignorar comentários de linha */ }

{IDENTIFICADOR}		   {fprintf(yyout, "(linha: %d, IDENTIFICADOR: %s)\n", yylineno, yytext); }
{NUMERO}               {fprintf(yyout, "(linha: %d, NUMERO: %s)\n", yylineno, yytext); }
{OPERADOR_ARITMETICO}  {fprintf(yyout, "(linha: %d, OP. ARITMETICO: %s)\n", yylineno, yytext); }
{OPERADOR_RELACIONAL}  {fprintf(yyout, "(linha: %d, OP. RELACIONAL: %s)\n", yylineno, yytext); }
{OPERADOR_LOGICO}	   {fprintf(yyout, "(linha: %d, OP. LOGICO: %s)\n", yylineno, yytext); }
{OPERADOR_ATRIBUICAO}  {fprintf(yyout, "(linha: %d, OP. ATRIBUICAO: %s)\n", yylineno, yytext); }
{SIMBOLO}	 		   {fprintf(yyout, "(linha: %d, SIMBOLO: %s)\n", yylineno, yytext); }
{TAB}			 	   { /* Ignorar tabs */}
{ESPACO}			   { /* Ignorar espaços */ }
{QUEBRA_DE_LINHA}      { /* Ignorar quebras de linha */ }
{CARRIAGE_RETURN}        {/*Ignorar*/}

"_"{IDENTIFICADOR}|{NUMERO}{IDENTIFICADOR}|"_"{NUMERO}{IDENTIFICADOR}|"_"{IDENTIFICADOR}|{NUMERO}"_"{IDENTIFICADOR} {fprintf(yyout, "\t(linha: %d, ERRO - IDENTIFICADOR INVALIDO: %s)\n", yylineno, yytext); }

.                      {fprintf(yyout, "\t(linha: %d, ERRO - CARACTER DESONHECIDO: %s)\n", yylineno, yytext); }

%%


int main(int argc, char *argv[])
{
	extern FILE *yyin, *yyout;
	
    FILE *arquivo = fopen(argv[1],"r");
	
    if(!arquivo){ 
        printf("\nArquivo nao existe.\nInsira o arquivo como parametro na execucao!\n");
        return -1; 
    }
    yyin = arquivo;
	
    yyout = fopen("output.txt","w");
	
    yylex();
	printf("\nArquivo de analise lexica 'output.txt' criado!\n\n\tSaindo . .  .\n\n");
    return 0;
}