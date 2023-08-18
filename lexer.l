ID[a-zA-Z][a-zA-Z0-9_]*
int[0-9]+
real[0-9]+"."?[0-9]+

%option noyywrap
%{
    #include <stdio.h>

%}

%%

[a-zA-Z][a-zA-Z0-9_]*   {printf("NOME_VARIAVEL: %s\n", yytext);                     }
[a-zA-Z]+".h"           {printf("BIBLIOTECA: %s\n", yytext);                        }
[0-9]+                  {printf("NUMERO: %s\n", yytext);                            }
[0-9]+"."?[0-9]+        {printf("REAL: %s\n", yytext);                              }

"\""                    {printf("ASPAS: %s\n", yytext);                             }

"+"                     {printf("OPERADOR_SOMA: %s\n", yytext);                     }
"-"                     {printf("OPERADOR_SUBTRACAO: %s\n", yytext);                }
"*"                     {printf("OPERADOR_MULTIPLICACAO: %s\n", yytext);            }
"/"                     {printf("OPERADOR_DIVISAO: %s\n", yytext);                  }
"="                     {printf("ATRIBUICAO: %s\n", yytext);                        }

">"                     {printf("COMPARADOR_MAIOR_QUE: %s\n", yytext);              }
"<"                     {printf("COMPARADOR_MENOR_QUE: %s\n", yytext);              }
">="                    {printf("COMPARADOR_MAIOR_OU_IGUAL_QUE: %s\n", yytext);     }
"<="                    {printf("COMPARADOR_MENOR_OU_IGUAL_QUE: %s\n", yytext);     }
"=="                    {printf("COMPARADOR_IGUAL: %s\n", yytext);                  }

";"                     {printf("FINAL_LINHA: %s\n", yytext);                       }
","                     {printf("SEPARADOR: %s\n", yytext);                         }
"("                     {printf("ABRE_PARENTESES: %s\n", yytext);                   }
")"                     {printf("FECHA_PARENTESES: %s\n", yytext);                  }
"{"                     {printf("ABRE_CHAVES: %s\n", yytext);                       }
"}"                     {printf("FECHA_CHAVES: %s\n", yytext);                      }
"."                     {printf("SEPARA_DECIMAL: %s\n", yytext);                    }
[ \t]                   {printf("ESPAÇO: %s\n", yytext);                            }
[ \n]                   {printf("QUEBRA_LINHA: %s\n", yytext);                      }
.                       {printf("CARACTER_DESCONHECIDO: %s\n", yytext);             }

{int}{ID}               {printf("ID_NAO_ACEITO: %s\n", yytext);                     }
{real}{ID}              {printf("ID_NAO_ACEITO: %s\n", yytext);                     }


%%


int main(){
    extern FILE *yyin, *yyout;

    yyin = fopen("teste.txt", "r");

    yyout = fopen("Output.txt", "w");
    
    yylex();
    return 0;
}