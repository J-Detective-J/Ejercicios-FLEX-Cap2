%option noyywrap yylineno

%{
#include <stdio.h>
%}

%%

[^\n]+  { fprintf(yyout, "%s", yytext); }
\n      { fprintf(yyout, "\n"); }

%%

int main(int argc, char **argv) {
    if(argc > 1) {
        if(!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return 1;
        }
    }
    yylex();
    return 0;
}
