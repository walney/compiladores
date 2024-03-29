/*
    Exercicio 2a
*/

%option noyywrap
%{
int uppers = 0;
%}

%%
[A-Z][a-zA-Z]+   { uppers++; }

%%
int main(int argc, char **argv) {
    if (argc > 1) {
        if (!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return 1;
        }
    }

    yylex();
    printf("%d palavras maiusculas\n", uppers);

    return 0;
}