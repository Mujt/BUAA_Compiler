#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "asm.h"
#include "midcode.h"
#include "syn.h"
extern MID_T midtab;
extern datatab DATB;
char blankary[2]=" ";
int varfun;
char dattype[5][10]={
    ".byte",
    ".space",
    ".word",
    ".asciiz",
    ".data",
};
int returnsy=0;
void emitdata(char n[],int typsy,char v[]){
    if(typsy != 5)
     strcat(n,":");
    strcpy(DATB.dataone[DATB.dataptr].dataname,n);
    DATB.dataone[DATB.dataptr].datatyp=typsy;
    strcpy(DATB.dataone[DATB.dataptr].datavalue,v);
    DATB.dataptr=DATB.dataptr+1;
}

void data(){
    int i=0;
    int arysize;
    char arysizestr[10],charvl[4],strvl[105];
    int midsy=midtab.Midcod[0].midop;
    emitdata(blankary,5,blankary);
    while(midsy != funcsign){
        if(midsy == consts){
            if(strcmp(midtab.Midcod[i].src1,"int") == 0){
                emitdata(midtab.Midcod[i].res,3,midtab.Midcod[i].src2);
            }
            else if(strcmp(midtab.Midcod[i].src1,"char") == 0){
                strcpy(charvl,"'");
                strcat(charvl,midtab.Midcod[i].src2);
                strcat(charvl,"'");
                emitdata(midtab.Midcod[i].res,1,charvl);
            }
        }
        else{
            if(midsy == intsign){
                if(strlen(midtab.Midcod[i].src2)==0){
                    emitdata(midtab.Midcod[i].res,3,"0");
                }
                else {
                    arysize=atoi(midtab.Midcod[i].src2);
                    arysize=4*arysize;
                    itoa(arysize,arysizestr,10);
                    emitdata(midtab.Midcod[i].res,2,arysizestr);
                }
            }
            else if(midsy == charsign){
                if(strlen(midtab.Midcod[i].src2)==0){
                    emitdata(midtab.Midcod[i].res,1," ");
                }
                else {
                    emitdata(midtab.Midcod[i].res,2,midtab.Midcod[i].src2);
                }
            }
        }
        i=i+1;
        midsy=midtab.Midcod[i].midop;
    }
    varfun=i;
    for(;i<midtab.midcodeptr;i++){
            midsy=midtab.Midcod[i].midop;
        if(midsy == strsign){
            strcpy(strvl,"\"");
            strcat(strvl,midtab.Midcod[i].res);
            strcat(strvl,"\"");
            emitdata(midtab.Midcod[i].src1,4,strvl);
        }
    }
    for(i=0;i<DATB.dataptr;i++){
        printf("%s   %s   %s\n",DATB.dataone[i].dataname,dattype[DATB.dataone[i].datatyp-1],DATB.dataone[i].datavalue);
    }
    printf("enter:   .asciiz   %c%c%c%c\n",'\"','\\','n','\"');
}

void stak_sub(int des){
    int total,varnum,parnum,i=0,tabdes;
    total=MTable.var_num[MTable.Tab[des].addr+1];
    parnum=MTable.Tab[des].paranum;
    varnum=total-parnum;
    printf("addi $sp,$sp,-%d\n",MTable.Tab[des].spsize);
    printf("sw $ra,%d($sp)\n",MTable.Tab[des].spsize-4);
    tabdes=MTable.display[MTable.Tab[des].addr]+2;
    for(i=tabdes;i<tabdes+parnum;i++){
        switch(i-tabdes){
        case 0:
            printf("sw $a0,%d($sp)\n",MTable.Tab[i].addr);
            break;
        case 1:
            printf("sw $a1,%d($sp)\n",MTable.Tab[i].addr);
            break;
        case 2:
            printf("sw $a2,%d($sp)\n",MTable.Tab[i].addr);
            break;
        case 3:
            printf("sw $a3,%d($sp)\n",MTable.Tab[i].addr);
            break;
        }
    }
}
int isNum(char inn[],int *Num){
    int i=0;
    int jud=0;
    int isminus=0;
    for(;i<strlen(inn);i++){
        if(i==0 && inn[i]=='-'){
        isminus=1;
        continue;}
        if(inn[i]<'0' || inn[i]>'9'){
            jud=1;
            break;
        }
    }
    //printf("%s\n",inn);
    if(jud == 1) return -1;
    else{
    *Num=atoi(inn);
    return 0;
    }
}
int isC(char n[]){
    if(n[0]=='\''){
        if(n[2]=='\'')return 1;
    }
    return 0;
}
int setpar(int k,int des){
    int count=0,var_des=0,varnum;
    char var_str[10];
    while(midtab.Midcod[k].midop == setsign){
        var_des=tab_des(midtab.Midcod[k].src2,des);
        strcpy(var_str,midtab.Midcod[k].src2);
        if(var_des==0){
            if(isC(midtab.Midcod[k].src2)==1){
                    printf("li $t0,%s\n",midtab.Midcod[k].src2);
                    strcpy(var_str,"$t0");
            }
            else if(isNum(midtab.Midcod[k].src2,&varnum)==0){
                    printf("li $t0,%s\n",midtab.Midcod[k].src2);
                    strcpy(var_str,"$t0");
            }
            else {
            var_des=find_data(midtab.Midcod[k].src2);
                if(MTable.Tab[var_des].typ==0){
                    printf("sw $t0,%s\n",midtab.Midcod[k].src2);
                    strcpy(var_str,"$t0");
                }
                else{
                    printf("sb $t0,%s\n",midtab.Midcod[k].src2);
                    strcpy(var_str,"$t0");
                }
            }
        }else{
            if(MTable.Tab[var_des].typ==0){
                printf("sw $t0,%d($sp)\n",MTable.Tab[var_des].addr);
                strcpy(var_str,"$t0");
            }else{
                printf("sb $t0,%d($sp)\n",MTable.Tab[var_des].addr);
                strcpy(var_str,"$t0");
            }
        }
        switch(count){
        case 0:
            printf("move $a0,%s\n",var_str);
            count=count+1;
            k=k+1;
            break;
        case 1:
            printf("move $a1,%s\n",var_str);
            count=count+1;
            k=k+1;
            break;
        case 2:
            printf("move $a2,%s\n",var_str);
            count=count+1;
            k=k+1;
            break;
        case 3:
            printf("move $a3,%s\n",var_str);
            count=count+1;
            k=k+1;
            break;
        default:
            printf("addi $sp,$sp,-4\n");
            printf("sw %s,0($sp)\n",var_str);
            count=count+1;
            k=k+1;
        }
    }
    printf("jal %s\n",midtab.Midcod[k].src1);
    if(strcmp(midtab.Midcod[k].res,"\0")!=0){
            var_des=tab_des(midtab.Midcod[k].res,des);
            if(MTable.Tab[var_des].typ==0){
                printf("move $t4,$v0\n");
                printf("sw $t4,%d($sp)\n",MTable.Tab[var_des].addr);
            }else{
                printf("move $t4,$v0\n");
                printf("sb $t4,%d($sp)\n",MTable.Tab[var_des].addr);
            }
        }
    k=k+1;
    return k;
}
void ret(int k,int des){
    int var_des,varnum;
    char var_str[10];
    if(strcmp(midtab.Midcod[k].res,"\0")!=0){
        var_des=tab_des(midtab.Midcod[k].res,des);
        strcpy(var_str,midtab.Midcod[k].res);
        if(var_des==0){
            if(isC(midtab.Midcod[k].res)==1){
                printf("li $t0,%s\n",midtab.Midcod[k].res);
                strcpy(var_str,"$t0");
            }
            else if(isNum(midtab.Midcod[k].res,&varnum)==0){
                    printf("li $t0,%s\n",midtab.Midcod[k].res);
                    strcpy(var_str,"$t0");
            }
            else {
                var_des=find_data(midtab.Midcod[k].res);
                if(MTable.Tab[var_des].typ==0){
                    printf("lw $t0,%s\n",midtab.Midcod[k].res);
                    strcpy(var_str,"$t0");
                }
                else{
                    printf("lb $t0,%s\n",midtab.Midcod[k].res);
                    strcpy(var_str,"$t0");
                }
            }
        }else{
            if(MTable.Tab[var_des].typ==0){
                printf("lw $t0,%d($sp)\n",MTable.Tab[var_des].addr);
                strcpy(var_str,"$t0");
            }else{
                printf("lb $t0,%d($sp)\n",MTable.Tab[var_des].addr);
                strcpy(var_str,"$t0");
            }
        }
        printf("move $v0,%s\n",var_str);
        }
        printf("lw $ra,%d($sp)\n",MTable.Tab[des].spsize-4);
        printf("addi $sp,$sp,%d\n",MTable.Tab[des].spsize);
        printf("jr $ra\n");
        returnsy=1;
        return;
}
void prtf_de(int k, int des){
    int var_des,varnum=0;
    char var_str[10];
    var_des=tab_des(midtab.Midcod[k].src2,des);
    if(strcmp(midtab.Midcod[k].res,"strsym")==0){
        printf("la $a0,%s\n",midtab.Midcod[k].src1);
        printf("li $v0,4\nsyscall\n");
    }
    if(var_des==0){
        if(isC(midtab.Midcod[k].src2)==1){
                printf("li $a0,%s\n",midtab.Midcod[k].src2);
            printf("li $v0,11\nsyscall\n");
            }
        else if(isNum(midtab.Midcod[k].src2,&varnum)==0){
            printf("li $a0,%d\n",varnum);
            printf("li $v0,1\nsyscall\n");
        }
        else{
            var_des=find_data(midtab.Midcod[k].src2);
            if(MTable.Tab[var_des].typ==0){
            printf("la $a0,%s\n",midtab.Midcod[k].src2);
            printf("li $v0,1\nsyscall\n");
            }else{
            printf("la $a0,%s\n",midtab.Midcod[k].src2);
            printf("li $v0,11\nsyscall\n");
            }
        }
    }else{
        if(MTable.Tab[var_des].typ==0){
            printf("lw $a0,%d($sp)\n",MTable.Tab[var_des].addr);
            printf("li $v0,1\nsyscall\n");
        }else{
            printf("lb $a0,%d($sp)\n",MTable.Tab[var_des].addr);
            printf("li $v0,11\nsyscall\n");
        }
    }
    printf("la $a0,enter\n");
    printf("li $v0,4\nsyscall\n");
}
void scaf_de(int k, int des){
    int var_des;
    char var_str[10];
    var_des=tab_des(midtab.Midcod[k].res,des);
    if(var_des==0){
        var_des=find_data(midtab.Midcod[k].res);
        if(MTable.Tab[var_des].typ==0){
            printf("li $v0,5\nsyscall\n");
            printf("move $t0,$v0\n");
            printf("sw $t0,%s\n",midtab.Midcod[k].res);
        }else{
            printf("li $v0,12\nsyscall\n");
            printf("move $t0,$v0\n");
            printf("sb $t0,%s\n",midtab.Midcod[k].res);
        }
    }else{
        if(MTable.Tab[var_des].typ==0){
            printf("li $v0,5\nsyscall\n");
            printf("move $t0,$v0\n");
            printf("sw $t0,%d($sp)\n",MTable.Tab[var_des].addr);
        }else{
            printf("li $v0,12\nsyscall\n");
            printf("move $t0,$v0\n");
            printf("sb $t0,%d($sp)\n",MTable.Tab[var_des].addr);
        }
    }
}
void deal_opera(int ik,int des,int opsy){
    int s1,s2,r,num;
    char sn1[10],sn2[10];
    s1=tab_des(midtab.Midcod[ik].src1,des);
    s2=tab_des(midtab.Midcod[ik].src2,des);
    r=tab_des(midtab.Midcod[ik].res,des);
    strcpy(sn1,midtab.Midcod[ik].src1);
    strcpy(sn2,midtab.Midcod[ik].src2);
    if(s1 == 0){
        if(isC(sn1)==1){
        printf("li $t0,%s\n",sn1);
        //printf("is CHAR\n");
        strcpy(sn1,"$t0");
        }
        else if(isNum(sn1,&num)!=-1){
        printf("li $t0,%s\n",sn1);
        //printf("is NUM:%d\n",num);
        strcpy(sn1,"$t0");
        }
        else{
        printf("lw $t0,%s\n",sn1);
        strcpy(sn1,"$t0");
        }
    }
    if(s2 == 0){
        if(isC(sn2)==1){
            printf("li $t1,%s\n",sn2);
         strcpy(sn2,"$t1");
        }
        else if(isNum(sn2,&num)==0){
        printf("li $t1,%s\n",sn2);
        strcpy(sn2,"$t1");
        }
        else{
        printf("lw $t1,%s\n",sn2);
        strcpy(sn2,"$t1");
        }
    }
    if(s1 != 0){
        printf("lw $t0,%d($sp)\n",MTable.Tab[s1].addr);
        strcpy(sn1,"$t0");
    }
    if(s2 != 0){
        printf("lw $t1,%d($sp)\n",MTable.Tab[s2].addr);
        strcpy(sn2,"$t1");
    }
    switch(opsy){
    case 1://add
        printf("add $t1,%s,%s\n",sn1,sn2);
        printf("sw $t1,%d($sp)\n",MTable.Tab[r].addr);
        break;
    case 2://sub
        printf("sub $t1,%s,%s\n",sn1,sn2);
        printf("sw $t1,%d($sp)\n",MTable.Tab[r].addr);
        break;
    case 3://mul
        printf("mult %s,%s\n",sn1,sn2);
        printf("mflo $t1\n");
        printf("sw $t1,%d($sp)\n",MTable.Tab[r].addr);
        break;
    case 4://div
        printf("div %s,%s\n",sn1,sn2);
        printf("mflo $t1\n");
        printf("sw $t1,%d($sp)\n",MTable.Tab[r].addr);
        break;
    }
}
int deal_con(int ik,int des,int opsy){
    int s1,s2,r,num;
    char sn1[10],sn2[10];
    s1=tab_des(midtab.Midcod[ik].src1,des);
    s2=tab_des(midtab.Midcod[ik].src2,des);
    strcpy(sn1,midtab.Midcod[ik].src1);
    strcpy(sn2,midtab.Midcod[ik].src2);
    if(s1 == 0){
        if(isC(sn1)==1){
            printf("li $t0,%s\n",sn1);
            strcpy(sn1,"$t0");
        }
        else if(isNum(sn1,&num)==0){
        printf("li $t0,%s\n",sn1);
        strcpy(sn1,"$t0");
        }
        else {
            printf("lw $t0,%s\n",sn1);
        strcpy(sn1,"$t0");
        }
    }
    if(s2 == 0){
        if(isC(sn2)==1){
        printf("li $t1,%s\n",sn2);
        strcpy(sn2,"$t1");
        }
        else if(isNum(sn2,&num)==0){
        printf("li $t1,%s\n",sn2);
        strcpy(sn2,"$t1");
        }else{
            printf("lw $t1,%s\n",sn1);
            strcpy(sn1,"$t1");
        }
    }
    if(s1 != 0){
        printf("lw $t0,%d($sp)\n",MTable.Tab[s1].addr);
        strcpy(sn1,"$t0");
    }
    if(s2 != 0){
        printf("lw $t1,%d($sp)\n",MTable.Tab[s2].addr);
        strcpy(sn2,"$t1");
    }
    switch(opsy){
    case 1://>=
        printf("sub $t2,%s,%s\n",sn1,sn2);
        ik++;
        printf("bltz $t2,%s\n",midtab.Midcod[ik].res);
        break;
    case 2://<=
        printf("sub $t2,%s,%s\n",sn1,sn2);
        ik++;
        printf("bgtz $t2,%s\n",midtab.Midcod[ik].res);
        break;
    case 3://==
        ik++;
        printf("bne %s,%s,%s\n",sn1,sn2,midtab.Midcod[ik].res);
        break;
    case 4: // !=
        ik++;
        printf("beq %s,%s,%s\n",sn1,sn2,midtab.Midcod[ik].res);
        break;
    case 5://>
        printf("sub $t2,%s,%s\n",sn1,sn2);
        ik++;
        printf("blez $t2,%s\n",midtab.Midcod[ik].res);
        break;
    case 6://<
        printf("sub $t2,%s,%s\n",sn1,sn2);
        ik++;
        printf("bgez $t2,%s\n",midtab.Midcod[ik].res);
        break;
    }
    return ik;
}
void deal_asary(int k,int des){
    int ary_des,ary_num,var_des,num;
    ary_des=tab_des(midtab.Midcod[k].res,des);
    ary_num=tab_des(midtab.Midcod[k].src1,des);
    var_des=tab_des(midtab.Midcod[k].src2,des);
    if(ary_num==0){
            if(isC(midtab.Midcod[k].src1)==1){
                printf("li $t0,%s\n",midtab.Midcod[k].src1);
            }else if(isNum(midtab.Midcod[k].src1,&num)==0){
                printf("li $t0,%d\n",num);
            }else {
                printf("lw $t0,%s\n",midtab.Midcod[k].src1);
            }
    }else{
        if(MTable.Tab[ary_num].typ==0){
                    printf("lw $t0,%d($sp)\n",MTable.Tab[ary_num].addr);
            }else{
                printf("lb $t0,%d($sp)\n",MTable.Tab[ary_num].addr);
            }
    }
    if(var_des==0){
            if(isC(midtab.Midcod[k].src2)==1){
                printf("li $t1,%s\n",midtab.Midcod[k].src2);
            }else if(isNum(midtab.Midcod[k].src2,&num)==0){
                printf("li $t1,%d\n",num);
                //printf("is a NUM\n");
            }else {
                printf("lw $t1,%s\n",midtab.Midcod[k].src2);
            }
    }else{
        if(MTable.Tab[var_des].typ==0){
                    printf("lw $t1,%d($sp)\n",MTable.Tab[var_des].addr);
            }else{
                printf("lb $t1,%d($sp)\n",MTable.Tab[var_des].addr);
            }
    }
    if(ary_des==0){
            ary_des=find_data(midtab.Midcod[k].res);
            printf("la $t2,%s\n",midtab.Midcod[k].res);
            if(MTable.Tab[ary_des].typ==0){
                    printf("sll $t0,$t0,2\n");
                    printf("add $t2,$t2,$t0\n");
                printf("sw $t1,0($t2)\n");
            }else{
                printf("add $t2,$t2,$t0\n");
                 printf("sb $t1,0($t2)\n");
            }
    }else{
        if(MTable.Tab[ary_des].typ==0){
                printf("sll $t0,$t0,2\n");
                printf("addi $t2,$sp,%d\n",MTable.Tab[ary_des].addr);
                printf("add $t2,$t2,$t0\n");
                printf("sw $t1,0($t2)\n");
            }else{
                printf("addi $t2,$sp,%d\n",MTable.Tab[ary_des].addr);
                printf("add $t2,$t2,$t0\n");
                printf("sb $t1,0($t2)\n");
            }
    }
}
void deal_asseq(int k,int des){
    int var1,var2,num;
    var1=tab_des(midtab.Midcod[k].res,des);
    var2=tab_des(midtab.Midcod[k].src1,des);
    if(var2==0){
            if(isC(midtab.Midcod[k].src1)==1){
                printf("li $t0,%s\n",midtab.Midcod[k].src1);
            }else if(isNum(midtab.Midcod[k].src1,&num)==0){
                printf("li $t0,%d\n",num);
            }else {
                printf("lw $t0,%s\n",midtab.Midcod[k].src1);
            }
    }else{
        if(MTable.Tab[var2].typ==0){
                   printf("lw $t0,%d($sp)\n",MTable.Tab[var2].addr);
            }else{
                printf("lb $t0,%d($sp)\n",MTable.Tab[var2].addr);
            }
    }
    if(var1==0){
            var1=find_data(midtab.Midcod[k].res);
            if(MTable.Tab[var1].typ==0){
                    printf("sw $t0,%s\n",midtab.Midcod[k].res);
            }else{
                printf("sb $t0,%s\n",midtab.Midcod[k].res);
            }
    }else{
        if(MTable.Tab[var1].typ==0){
                    printf("sw $t0,%d($sp)\n",MTable.Tab[var1].addr);
            }else{
                printf("sb $t0,%d($sp)\n",MTable.Tab[var1].addr);
            }
    }
}
void deal_aas(int k,int des){
    int ary_des,ary_num,var_des,num;
    ary_des=tab_des(midtab.Midcod[k].src1,des);
    ary_num=tab_des(midtab.Midcod[k].src2,des);
    var_des=tab_des(midtab.Midcod[k].res,des);
    if(ary_num==0){
            if(isC(midtab.Midcod[k].src2)==1){
                printf("li $t0,%s\n",midtab.Midcod[k].src2);
            }else if(isNum(midtab.Midcod[k].src2,&num)==0){
                printf("li $t0,%d\n",num);
            }else {
                printf("lw $t0,%s\n",midtab.Midcod[k].src2);
            }
    }else{
        if(MTable.Tab[ary_num].typ==0){
                    printf("lw $t0,%d($sp)\n",MTable.Tab[ary_num].addr);
            }else{
                printf("lb $t0,%d($sp)\n",MTable.Tab[ary_num].addr);
            }
    }
    if(ary_des==0){
            ary_des=find_data(midtab.Midcod[k].src1);
            printf("la $t1,%s\n",midtab.Midcod[k].src1);
            if(MTable.Tab[ary_des].typ==0){
                    printf("sll $t0,$t0,2\n");
                    printf("add $t1,$t1,$t0\n");
                printf("lw $t2,0($t1)\n");
            }else{
                printf("add $t1,$t1,$t0\n");
                 printf("lb $t2,0($t1)\n");
            }
    }else{
        if(MTable.Tab[ary_des].typ==0){
                printf("sll $t0,$t0,2\n");
                printf("addi $t1,$sp,%d\n",MTable.Tab[ary_des].addr);
                printf("add $t1,$t1,$t0\n");
                printf("lw $t2,0($t1)\n");
            }else{
                printf("addi $t1,$sp,%d\n",MTable.Tab[ary_des].addr);
                printf("add $t1,$t1,$t0\n");
                printf("lb $t2,0($t1)\n");
            }
    }

    if(var_des==0){
            var_des=find_data(midtab.Midcod[k].res);
            if(MTable.Tab[var_des].typ==0){
                    printf("sw $t2,%s\n",midtab.Midcod[k].res);
            }else{
                printf("sb $t2,%s\n",midtab.Midcod[k].res);
            }
    }else{
       if(MTable.Tab[var_des].typ==0){
                    printf("sw $t2,%d($sp)\n",MTable.Tab[var_des].addr);
            }else{
                printf("sb $t2,%d($sp)\n",MTable.Tab[var_des].addr);
            }
    }
}
int deal_state(int ik,int des){
    int var_des,varnum,ary_des;
    char varstr[5];
    while(midtab.Midcod[ik].midop != endfsign){
    switch(midtab.Midcod[ik].midop){
    case plusign:
        deal_opera(ik,des,1);
        ik++;
        break;
    case minusign:
        deal_opera(ik,des,2);
        ik++;
        break;
    case timesign:
        deal_opera(ik,des,3);
        ik++;
        break;
    case divsign:
        deal_opera(ik,des,4);
        ik++;
        break;
    case gresign://>=
        ik=deal_con(ik,des,1);
        ik=ik+1;
        break;
    case uneqsign: // !=
        ik=deal_con(ik,des,4);
        ik=ik+1;
        break;
    case eqlsign://==
        ik=deal_con(ik,des,3);
        ik=ik+1;
        break;
    case leesign://<=
        ik=deal_con(ik,des,2);
        ik=ik+1;
        break;
    case gretsign://>
        ik=deal_con(ik,des,5);
        ik=ik+1;
        break;
    case lesign://<
        ik=deal_con(ik,des,6);
        ik=ik+1;
        break;
    case jnesign:
        var_des=tab_des(midtab.Midcod[ik].src1,des);
        if(var_des==0){
            if(isNum(midtab.Midcod[ik].src1,&varnum)==-1)
                strcpy(varstr,midtab.Midcod[ik].src1);
            else {
                printf("li $t0,%s\n",midtab.Midcod[ik].src1);
                strcpy(varstr,"$t0");
            }
        }
        else{
            printf("lw $t0,%d($sp)\n",MTable.Tab[des].addr);
            strcpy(varstr,"$t0");
        }
        printf("bne %s,$0,%s\n",varstr,midtab.Midcod[ik].res);
        ik++;
        break;
    case jmpsign:
        printf("j %s\n",midtab.Midcod[ik].res);
        ik++;
        break;
    case prtfsign:
        prtf_de(ik,des);
        ik++;
        break;
    case scafsign:
        scaf_de(ik,des);
        ik++;
        break;
    case assary://[]=
        deal_asary(ik,des);
        ik++;
        break;
    case asseql://=
        deal_asseq(ik,des);
        ik++;
        break;
    case aassign://k=a[i];
        deal_aas(ik,des);
        ik++;
        break;
    case setsign:
        ik=setpar(ik,des);
        break;
    case callsign:
        printf("jal %s\n",midtab.Midcod[ik].src1);
        if(strcmp(midtab.Midcod[ik].res,"\0")!=0){
            var_des=tab_des(midtab.Midcod[ik].res,des);
            if(MTable.Tab[var_des].typ==0){
                printf("move $t4,$v0\n");
                printf("sw $t4,%d($sp)\n",MTable.Tab[var_des].addr);
            }else{
                printf("move $t4,$v0\n");
                printf("sb $t4,%d($sp)\n",MTable.Tab[var_des].addr);
            }
        }
        ik++;
        break;
    case retsign:
        ret(ik,des);
        ik++;
        break;
    case labsign:
        printf("%s:\n",midtab.Midcod[ik].res);
        ik++;
        break;
    default:
        ik++;
    }
    }
    return ik+1;
}
int find_data(char n[]){
    int i=0;
    for(i=MTable.display[0];i>0;i--){
        if(strcmp(MTable.Tab[i].name,n)==0)break;
    }
    return i;
}
int tab_des(char cn[],int des){
    int end,begin,i,jud=0;
    begin=MTable.display[MTable.Tab[des].addr];
    end=MTable.display[MTable.Tab[des].addr+1];
    for(i=end;i>begin+1;i--){
        if(strcmp(cn,MTable.Tab[i].name)==0){jud=1;break;}
    }
    if(jud==1)return i;
    return 0;
}
void run(){
    int midsy;
    int i=0,fu_des,const_des=0;
    data();
    printf("  .text  \n");
    midsy=midtab.Midcod[varfun].midop;
    i=varfun;
    //printf("i:%d",i);
    printf("jal main\n");
    while(midsy == funcsign){
         printf("%s:\n",midtab.Midcod[i].res);
         fu_des=loc(midtab.Midcod[i].res);
         stak_sub(fu_des);
         i=i+1;
         midsy=midtab.Midcod[i].midop;
         while(midsy == parsign || midsy == consts || midsy == ints || midsy == charsign){
                if(midsy == consts){
                    const_des=tab_des(midtab.Midcod[i].res,fu_des);
                    if(MTable.Tab[const_des].typ==0){
                    printf("li $t0,%d\n",MTable.Tab[const_des].value);
                    printf("sw $t0,%d($sp)\n",MTable.Tab[const_des].addr);
                    }else{
                       printf("li $t0,'%s'\n",midtab.Midcod[i].src2);
                    printf("sb $t0,%d($sp)\n",MTable.Tab[const_des].addr);
                    }
                }
           i=i+1;
           midsy=midtab.Midcod[i].midop;
         }
         i=deal_state(i,fu_des);//printf("i:%d\n",i);
         if(returnsy==0){
                printf("lw $ra,%d($sp)\n",MTable.Tab[fu_des].spsize-4);
            printf("addi $sp,$sp,%d\n",MTable.Tab[fu_des].spsize);
            printf("jr $ra\n");
         }
         if(midtab.Midcod[i].midop == endfsign){
            i=i+1;
         }
         //printf("i:%d\n",i);
         midsy=midtab.Midcod[i].midop;
         //printf("%d\n",midsy);
         returnsy=0;
    }
}
