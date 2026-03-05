%option noyywrap nodefault yylineno
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

struct symbol {
    char *name;
    int count;
};

#define NHASH 9997
struct symbol symtab[NHASH];

static unsigned symhash(char *sym) {
    unsigned int hash = 0;
    unsigned c;
    while((c = *sym++)) hash = hash*9 ^ tolower(c);
    return hash;
}

struct symbol *lookup(char* sym) {
    struct symbol *sp = &symtab[symhash(sym)%NHASH];
    int scount = NHASH;
    while(--scount >= 0) {
        if(sp->name && !strcasecmp(sp->name, sym)) {
            sp->count++;
            return sp;
        }
        if(!sp->name) {
            sp->name = strdup(sym);
            sp->count = 1;
            return sp;
        }
        if(++sp >= symtab+NHASH) sp = symtab;
    }
    abort();
}

void imprimir_resultados() {
    printf("\n--- Conteo de palabras (Case Insensitive) ---\n");
    for(int i = 0; i < NHASH; i++) {
        if(symtab[i].name) {
            printf("%s: %d\n", symtab[i].name, symtab[i].count);
        }
    }
}
%}

%%
[a-zA-Z]+ { lookup(yytext); }
.|\n      { /* ignorar */ }
%%

int main() {
    yylex();
    imprimir_resultados();
    return 0;
}
