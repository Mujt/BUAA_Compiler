#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Lexical.h"
#include "syn.h"
#include "midcode.h"
#include "asm.h"
extern FILE *fp;
int main()
{
    setinial();
    char inn[5];
    //scanf("%s",&inn);
    if((fp=fopen("in.txt","r"))==NULL){
    printf("无法打开文件in.txt\n");
    exit(0);
    }
    program();
    //print_tab();
    //print_midcode();
    new_fun();
    //print_tab();
    //print_midcode();
    fclose(fp);
    printf("Compiler process over!\n");
    run();
    return 0;
}
