#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Lexical.h"
#include "syn.h"
extern FILE *fp;
int main()
{
    setinial();
    char inn[5];
    scanf("%s",&inn);
    if((fp=fopen(inn,"r"))==NULL){
    printf("无法打开文件in.txt\n");
    exit(0);
    }
    program();
    print_tab();
    fclose(fp);
    return 0;
}
