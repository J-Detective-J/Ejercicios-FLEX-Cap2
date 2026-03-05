%option noyywrap nodefault yylineno
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct symbol {
    char *name;
    int count;
};

int nhash = 9997;
int symcount = 0;
struct symbol *symtab = NULL;

static unsigned symhash(char *sym) {
    unsigned int hash = 0;
    unsigned c;
    while((c = *sym++)) hash = hash*9 ^ c;
    return hash;
}

void rehash() {
    int old_nhash = nhash;
    struct symbol *old_symtab = symtab;
    nhash = old_nhash * 2;
    symtab = calloc(nhash, sizeof(struct symbol));
    for (int i = 0; i < old_nhash; i++) {
        if (old_symtab[i].name) {
            struct symbol *sp = &symtab[symhash(old_symtab[i].name) % nhash];
            while (sp->name) {
                if (++sp >= symtab + nhash) sp = symtab;
            }
            *sp = old_symtab[i];
        }
    }
    free(old_symtab);
}

struct symbol *lookup(char* sym) {
    if (!symtab) symtab = calloc(nhash, sizeof(struct symbol));
    if (symcount >= nhash / 2) rehash();
    struct symbol *sp = &symtab[symhash(sym) % nhash];
    while (1) {
        if (sp->name && !strcmp(sp->name, sym)) {
            sp->count++;
            return sp;
        }
        if (!sp->name) {
            sp->name = strdup(sym);
            sp->count = 1;
            symcount++;
            return sp;
        }
        if (++sp >= symtab + nhash) sp = symtab;
    }
}

void imprimir_resultados() {
    printf("\n--- Resultados Tabla Dinámica ---\n");
    for(int i = 0; i < nhash; i++) {
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
