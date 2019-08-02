#ifndef SYN_H_
#define SYN_H_
#include "Lexical.h"
#define Tabsize 1000
#define lmax  20
#define Const 0
#define Var 1
#define Func 2
#define Para 3
#define INT 0
#define CHAR 1
#define VOID 2

typedef struct{
    char name[10];
    int obj;
    int typ;
    int value;
    int addr;
    int arrayv[100];
    int paranum;
}symTab;
typedef struct{
    symTab Tab[Tabsize];
    int tabindex;
    int num;
    int display[lmax];
}mainTab;
mainTab MTable;
void print_tab();
void enter(char nm[],int obj1,int typ1);
int loc(char name[]);
void factor(int *re);
void term(int *re);
void expression(int *re);
void condiexpr(int *re);
void constdef();
void conststate();
void vardef();
void varstate();
void parastate();
void ifstate();
void whilestate();
void casetab();
void onecase();
void defaultcase();
void switchstate();
void scanstate();
void prtfstate();
void assignment(int adr);
void retstate();
void statement();
void statelist();
void funcstate();
void mainstate();
void program();
void call();
#endif
