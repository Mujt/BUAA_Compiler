#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Lexical.h"
#include "syn.h"
#include "midcode.h"
#include "asm.h"
#include "error.h"
#include "optimize.h"
extern FILE *fp,*out;
extern int errorjud;
int main()
{
    setinial();
    char inn[100];
    scanf("%s",&inn);
    if((fp=fopen(inn,"r"))==NULL){
    printf("�޷����ļ�in.txt\n");
    exit(0);
    }
    //if((out=fopen("out.txt","w"))==NULL){
    //printf("�޷����ļ�out.txt\n");
    //exit(0);
    //}
    program();
    new_fun();
   // print_tab();

    //print_midcode();//�Ż�ǰ
    del_pubexp();
    //print_midcode();//�Ż���
    fclose(fp);
    if(errorjud != 1)
     run();
    //fclose(out);
    //printf("\nCompiler process over!");
    return 0;
}
