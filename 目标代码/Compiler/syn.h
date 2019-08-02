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
    int spsize;
}symTab;
typedef struct{
    symTab Tab[Tabsize];
    int tabindex;
    int num;
    int display[lmax];
    int var_num[lmax];
}mainTab;
mainTab MTable;
void print_tab();
void new_fun();
void enter(char nm[],int obj1,int typ1);
int loc(char name[]);
void factor(char re[],int *vtyp);
void term(char re[],int *vtyp);
void expression(char re[],int *vtyp);
void condiexpr(char re[]);
void constdef();
void conststate();
void vardef();
void varstate();
void parastate();
void ifstate();
void whilestate();
void casetab(char elab[],int sn,char e[]);
void onecase(int swn,char e[]);
void defaultcase(int swn);
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
void call(int adr,int *jud);
#endif
