#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "midcode.h"


char MID_code[29][6]={
    "=",
    "[]=",
    "const",
    "int",
    "char",
    "set",
    "call",
    "Lable",
    "func",
    "para",
    "endf",
    ">=",
    "!=",
    "==",
    "<=",
    "<",
    ">",
    "jne",
    "jmp",
    "ret",
    "scaf",
    "prtf",
    "aassi",
    "+",
    "-",
    "*",
    "/",
    "STR",
    "    ",
};
extern int ifnum,whilenum,switchnum,varnum,stringnum,casenum;//varnum:¡Ÿ ±±‰¡ø
extern MID_T midtab;
extern caseT3 caseTab;
extern char lab[25];
extern char varn[10];

void emit(int opx){
    midtab.Midcod[midtab.midcodeptr].midop=opx;
    midtab.midcodeptr=midtab.midcodeptr+1;
}

void gejcase(int k,int defsy,char endswi[]){
    int i=0;
    casenum=0;
    char str1[15],str2[15],str3[15],str_case[15];
    strcpy(str1,"swi");
    itoa(k,str2,10);
    strcat(str2,"cs");
    strcat(str1,str2);
    strcpy(str3,str1);
    //caseTab.sw[k].casens[0].casename
    itoa(casenum,str_case,10);
    strcat(str1,str_case);
    strcpy(midtab.Midcod[caseTab.sw[k].casens[0].casedes-2].res,str1);
    casenum=casenum+1;
    for(i=1;i<caseTab.sw[k].caseptr;i++){
    char str4[15];
    strcpy(str4,str3);
    //caseTab.sw[k].casens[i].casename
    itoa(casenum,str_case,10);
    strcat(str4,str_case);
    strcpy(midtab.Midcod[caseTab.sw[k].casens[i-1].casedes].res,str4);
    strcpy(midtab.Midcod[caseTab.sw[k].casens[i].casedes-2].res,str4);
    casenum=casenum+1;
    }
    char str5[15];
    if(defsy == 1){
    strcpy(str5,"swi");
    strcat(str5,str2);
    strcat(str5,"def");}
    else{
        strcpy(str5,endswi);
    }
    strcpy(midtab.Midcod[caseTab.sw[k].casens[i-1].casedes].res,str5);
}
char *genlab(int sww){
    char str[13];
    switch(sww){
        case 1://if
            strcpy(lab,"if");
            itoa(ifnum,str,10);
            strcat(lab,str);
            break;
        case 2://endif
            strcpy(lab,"endif");
            itoa(ifnum,str,10);
            strcat(lab,str);
            ifnum=ifnum+1;
            break;
        case 3://while
            strcpy(lab,"while");
            itoa(whilenum,str,10);
            strcat(lab,str);
            break;
        case 4://endwhile
            strcpy(lab,"endwhile");
            itoa(whilenum,str,10);
            strcat(lab,str);
            whilenum=whilenum+1;
            break;
        case 5://switch
            strcpy(lab,"switch");
            itoa(switchnum,str,10);
            strcat(lab,str);
            break;
        case 6://endswitch
            strcpy(lab,"endswitch");
            itoa(switchnum,str,10);
            strcat(lab,str);
            switchnum=switchnum+1;
            break;
        default:
            break;
    }
    return lab;
}
char *genvar(){
    char vnums[15];
    itoa(varnum,vnums,10);
    strcpy(varn,"t");
    strcat(varn,vnums);
    varnum=varnum+1;
    return varn;
}
void genstr(int k){
    char strn[15],str1[10];
    strcpy(strn,"Str");
    itoa(stringnum,str1,10);
    strcat(strn,str1);
    strcpy(midtab.Midcod[k].src1,strn);
     //strcpy(midtab.Midcod[prtdes].src1,strn);
    stringnum=stringnum+1;
}
void print_midcode(){
    int i=0;
    for(;i<midtab.midcodeptr;i++){
        printf("%s %s %s %s\n",MID_code[midtab.Midcod[i].midop-1],midtab.Midcod[i].src1,midtab.Midcod[i].src2,midtab.Midcod[i].res);
    }
}
