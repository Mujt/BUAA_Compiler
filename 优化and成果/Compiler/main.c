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
    printf("无法打开文件in.txt\n");
    exit(0);
    }
    //if((out=fopen("out.txt","w"))==NULL){
    //printf("无法打开文件out.txt\n");
    //exit(0);
    //}
    program();
    new_fun();
   // print_tab();

    //print_midcode();//优化前
    del_pubexp();
    //print_midcode();//优化后
    fclose(fp);
    if(errorjud != 1)
     run();
    //fclose(out);
    //printf("\nCompiler process over!");
    return 0;
}
