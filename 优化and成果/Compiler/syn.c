#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Lexical.h"
#include "syn.h"
#include "error.h"
#include "Lexical.h"
#include "midcode.h"
extern mainTab MTable;
extern MID_T midtab;
extern caseT3 caseTab;
extern int switchnum;
extern char token[tokensize];
int semisym=0;
extern int Tokenpoint;
extern char str[strsize];
extern FILE *fp;
int retsy=0;
int retval=0;
int aryjud=0;
int rettyp=-1;

void print_tab(){
    int i=0;
    for(i=1;i<MTable.tabindex+1;i++){
        printf("%d:%s %d %d %d %d %d %d\n",i,MTable.Tab[i].name,MTable.Tab[i].obj,MTable.Tab[i].typ,MTable.Tab[i].value,MTable.Tab[i].paranum,MTable.Tab[i].addr,MTable.Tab[i].spsize);
    }
    for(i=0;i<MTable.num;i++)
    printf("%d,%d\n",i,MTable.display[i]);
}
void new_fun(){
    int i=0,vnum=0,totalnum=0,j=0,k,lastpos=0;
    MTable.var_num[0]=0;
    for(i=1;i<MTable.num;i++){
        lastpos=0;
       totalnum = MTable.display[i]-MTable.display[i-1]-1;
       //printf("total:%d\n",totalnum);
       MTable.var_num[i]=totalnum;
       MTable.Tab[MTable.display[i]+1].addr=i;
       for(j=MTable.display[i],k=0;j>=MTable.display[i-1]+2 && k<totalnum;j--,k++){
            if(MTable.Tab[j].paranum==0 ){
            MTable.Tab[j].addr=lastpos;
            lastpos=lastpos+4;
            }

            else if(MTable.Tab[j].paranum!=0 ){
            MTable.Tab[j].addr=lastpos;
            lastpos=lastpos+4*MTable.Tab[j].paranum;
            }

       }
       MTable.Tab[MTable.display[i-1]+1].spsize=lastpos+4;
    }
}
void enter(char nm[],int obj1,int typ1){//向符号表添加
    MTable.tabindex=MTable.tabindex+1;
    strcpy(MTable.Tab[MTable.tabindex].name,nm);
    MTable.Tab[MTable.tabindex].obj=obj1;
    MTable.Tab[MTable.tabindex].typ=typ1;
}

int funcsym=0;
//int op=0;
int loc1(char name[]){
    int j=0,judfind=0;
    int end=MTable.display[MTable.num-1]+1;
    if(MTable.num==0)end=0;
    for(j=MTable.tabindex+1;j>=end;j--){
        if(strcmp(name,MTable.Tab[j].name)==0){judfind=1;break;}
    }
    return judfind;
}
int loc(char name[]){//查找符号表
    int j=0,i=0;
    int judfind=0;
    //printf("%d,%d\n",MTable.tabindex+1,MTable.display[MTable.num-1]);

    for(j=MTable.tabindex+1;j>=MTable.display[MTable.num-1]+1;j--){
        if(strcmp(name,MTable.Tab[j].name)==0){judfind=1;break;}
    }
    if(judfind==1){//printf("j:%d\n",j);
    return j;}
    for(j=MTable.display[0]+1;j>=1;j--){
            //printf("%s %s\n",name,MTable.Tab[j].name);
        if(strcmp(name,MTable.Tab[j].name)==0){judfind=1;break;}
    }
    if(judfind==1){//printf("j:%d\n",j);
    return j;}
    for(i=MTable.num;i>=0;i--){
        if(strcmp(name,MTable.Tab[MTable.display[i]+1].name)==0){judfind=1;break;}
    }
    if(judfind==1){//
    //printf("i:%d\n",MTable.display[i]+1);
    return MTable.display[i]+1;
    }
    return -1;
}
void factor(char re[],int *vtyp,int *preindex){//因子
    char *re1,*re2;
    char rev1[50];
    int readr,rety=0,op;
    char *re3,num_str[20];
    if(sy == ident){
        *preindex=-1;
        int i=loc(token);
        insym();
        if(i==-1){error(7);printf("id is not defined!\n");}
        else {
            int j=MTable.Tab[i].obj;
            switch(j){
                case 0://常量
                    //printf("%s\n",MTable.Tab[i].name);
                    /*emit(asseql);
                    re2=genvar();
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,MTable.Tab[i].name);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re2);
                    enter(re2,1,MTable.Tab[i].typ);*/
                    strcpy(re,MTable.Tab[i].name);
                    *vtyp=MTable.Tab[i].typ;
                    break;
                case 1://变量
                    if(MTable.Tab[i].paranum!=0){
                        if(sy!=lbrack){error(8);printf("defect [\n");sy=lbrack;}
                        if(sy==lbrack){
                            insym();
                            int k=0;
                            expression(rev1,&rety,&k);

                            if(aryjud!=-1){
                                if(k<0 || k>=MTable.Tab[i].paranum)error(31);
                               // printf("%d\n",k);
                            }

                            emit(aassign);
                            re2=genvar();
                            strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,MTable.Tab[i].name);
                            strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev1);
                            enter(re2,1,MTable.Tab[i].typ);
                            strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re2);
                            strcpy(re,re2);
                            if(sy != rbrack){
                                error(9);
                                printf("defect ]\n");
                                sy=rbrack;
                            }
                            else insym();
                        }
                    }
                    else { /*emit(asseql);
                            re2=genvar();
                            strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,MTable.Tab[i].name);
                            strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re2);
                            enter(re2,1,MTable.Tab[i].typ);
                            strcpy(re,re2);*/
                            //*vtyp=MTable.Tab[i].typ;
                            strcpy(re,MTable.Tab[i].name);
                    }//*re=MTable.Tab[i].value;
                    *vtyp=MTable.Tab[i].typ;
                    break;
                case 2://函数
                    call(i,&readr);
                    re3=genvar();
                    enter(re3,1,MTable.Tab[i].typ);
                    strcpy(midtab.Midcod[readr].res,re3);
                    strcpy(re,re3);
                    *vtyp=MTable.Tab[i].typ;
                    //*re=MTable.Tab[i].value;
                    break;
                case 3://参数
                    //*re=MTable.Tab[i].value;
                    /*emit(asseql);
                    re2=genvar();
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,MTable.Tab[i].name);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re2);
                    enter(re2,1,MTable.Tab[i].typ);*/
                    strcpy(re,MTable.Tab[i].name);
                    *vtyp=MTable.Tab[i].typ;
                    break;
            }
        }
        //printf("factor is id sy:%d\n",sy);
    }
    else if(sy == ints || sy == charcon || sy == minuss || sy == pluss){//常量、字符

            if(sy == minuss){
                    //op=sy;
                insym();
               *preindex=-transNUM();
                //strcpy(num_str,token);
                strcpy(num_str,"-");
                strcat(num_str,token);
                emit(asseql);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,num_str);
                re3=genvar();
                enter(re3,1,0);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re3);
                strcpy(re,re3);
                *vtyp=0;
            }else if(sy == pluss){
                //op=sy;
                insym();
                *preindex=transNUM();
                strcpy(re,token);
                *vtyp=0;

            }else if(sy == ints){
                /*strcpy(num_str,token);
                emit(asseql);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,num_str);
                re3=genvar();
                enter(re3,1,0);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re3);*/
                *preindex=transNUM();
                strcpy(re,token);
                *vtyp=0;
            }
            else {
                *preindex=token[0];
                strcpy(num_str,"'");
                strcat(num_str,token);
                strcat(num_str,"'");
                emit(asseql);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,num_str);
                re3=genvar();
                enter(re3,1,1);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re3);
                strcpy(re,re3);
                *vtyp=1;
            }
            insym();
    }
    else if(sy == lparent){//(
        insym();
        int a=0;
        expression(rev1,&rety,&a);
        *preindex=a;
        strcpy(re,rev1);
        *vtyp=0;
        if(sy == rparent)insym();
        else {error(10);printf("defect )");}
    }
    //printf("This is factor!\n");
}
void term(char re[],int *vtyp,int *preindex){//项
    char *re3;
    int opte,rety=0,preindex2=1,aryindex=1,mid=1;
    char rev1[50],rev2[50];
    int a=0;
    factor(rev1,&rety,&a);
    *preindex=a;
    if(a == -1)aryindex=-1;
    else
    preindex2=a;
    *vtyp=rety;
    while(sy == times || sy == idiv){
        opte=sy;
        insym();
        factor(rev2,&rety,&a);
        if(a==-1)aryindex=-1;
        mid=a;
        if(opte == times){
        preindex2=mid*preindex2;
        emit(timesign);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,rev1);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev2);
        re3=genvar();
        enter(re3,1,0);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re3);
        strcpy(rev1,re3);
        }
        else {
        emit(divsign);
        preindex2=preindex2/mid;
        strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,rev1);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev2);
        re3=genvar();
        enter(re3,1,0);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re3);
        strcpy(rev1,re3);
        }
        *vtyp=0;
    }
    if(aryindex==-1){
        aryjud=-1;
    }else{
        *preindex=preindex2;
    }
    strcpy(re,rev1);
    //printf("This is term\n");
}
void expression(char re[],int *vtyp,int *preindex){//表达式
    aryjud=0;
    char *re3,*re2;
    int opex=0,opex2,rety1=0,rety2=0,mid1=0,mid2=0,a=0;
    char rev1[50],rev2[50];
    int preindex2=1,aryindex=1;
    /*if(sy == minuss || sy == pluss)
    printf("first exp:sy:%d\n",sy);*/
    if(sy == minuss||sy == pluss){
        opex=sy;
        //printf("op:%d\n",opex);
        insym();
        term(rev1,&rety1,&a);
        *preindex=a;
        if(a == -1)aryindex=-1;
        mid1=a;
        *vtyp=rety1;
        if(opex == 29){
            /*取负*/
            emit(minusign);
            mid1=-mid1;
            strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"0");
            strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev1);
            re2=genvar();
            strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re2);
            enter(re2,1,0);
            strcpy(rev1,re2);
            //printf("get the miuss!\n");

        }
        *vtyp=0;
    }
    else {
    term(rev1,&rety1,&a);
    if(a == -1)aryindex=-1;
    mid1=a;
    *vtyp=rety1;
    }
    preindex2=mid1;
    //printf("sy:%d\n",sy);
    while(sy == minuss ||sy == pluss){
        opex2=sy;
        insym();
        term(rev2,&rety2,&a);
        if(a==-1)aryindex=-1;
        mid2=a;
        if(opex2 == pluss){
            /*加*/
            preindex2=preindex2+mid2;
        emit(plusign);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,rev1);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev2);
        re3=genvar();
        enter(re3,1,0);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re3);
        strcpy(rev1,re3);
        }
        else{
            /*减*/
             preindex2=preindex2-mid2;
        emit(minusign);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,rev1);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev2);
        re3=genvar();
        enter(re3,1,0);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re3);
        strcpy(rev1,re3);
        }
        *vtyp=0;
    }
    //printf("This is expression \n");
    if(aryindex==-1){
        aryjud=-1;
    }else{
        *preindex=preindex2;
    }
    strcpy(re,rev1);
}
void condiexpr(char re[]){//条件表达式

    char rev1[50],rev2[50];
    int opcon,rety1,rety2;
    int a=0;
    expression(rev1,&rety1,&a);
    if(rety1!=0)error(37);
    strcpy(re,rev1);
    if(sy >= 33 && sy <=39 && sy != 35){
        opcon=sy;
        insym();
        expression(rev2,&rety2,&a);
        if(rety2!=0)error(37);
        /*是否要看rety1，rety2是否均为0？*/
        switch(opcon){
            case lesss:
                emit(lesign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,rev1);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev2);

                break;
            case gree:
                emit(gretsign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,rev1);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev2);

                break;
            case leq:
                emit(leesign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,rev1);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev2);

                break;
            case geq:
                emit(gresign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,rev1);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev2);

                break;
            case eql:
                emit(eqlsign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,rev1);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev2);

                break;
            case uneql:
                emit(uneqsign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,rev1);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,rev2);

                break;
        }
        strcpy(re,"re");
    }
    else if(sy != rparent)
            {error(10);printf("defect )\n");}
}
void constdef(){//常量定义
    int opcon;
    char minuint[10];
    insym();
    switch(sy){
        case INTSY:
            insym();
            if(sy>=1 && sy <=12){error(35);sy=ident;}
            while(sy==ident){
                    if(loc1(token)==1){error(34);}
                enter(token,0,0);
                emit(consts);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].res,token);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"int");
                insym();
                if(sy==eqlsy)insym();
                else {error(11);sy=eqlsy;
                if(sy != ints)insym();}
                 if(sy==minuss || sy == pluss){opcon=sy;insym();}
                if(sy==ints){
                    if(opcon == minuss){num=-num;
                    strcpy(minuint,"-");
                    strcat(minuint,token);}
                    else{
                      strcpy(minuint,token);
                    }
                    MTable.Tab[MTable.tabindex].value=num;
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,minuint);
                    insym();
                }
                else {
                    error(14);
                    if(sy == charcon){
                        insym();
                    }
                }
                if(sy==comma){
                     insym();
                     if(sy == CONSTSY || sy == INTSY || sy == CHARSY || sy ==VOIDSY){
                        error(29);
                     }
                }
                else if(sy==semicolon){
                    insym();
                    semisym=1;break;
                }
                else {
                    error(12);
                    insym();
                }
            }
            if(sy!=semicolon && semisym!=1)
                error(13);
            //printf("This is const defination!Type is int\n");
            break;
        case CHARSY:
            insym();
            if(sy>=1 && sy <=12){error(35);sy=ident;}
            while(sy==ident){
                    if(loc1(token)==1){error(34);}
                enter(token,0,1);
                emit(consts);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].res,token);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"char");
                insym();
                if(sy==eqlsy)insym();
                else {error(11);sy=eqlsy;
                if(sy!=charcon)insym();}
                if(sy==charcon){
                    MTable.Tab[MTable.tabindex].value=charvalue;
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,token);
                    insym();
                }
                else {
                    error(14);
                    if(sy == ints){
                        insym();
                    }
                }
                if(sy==comma){
                        insym();
                if(sy == CONSTSY || sy == INTSY || sy == CHARSY || sy ==VOIDSY){
                        error(29);
                     }
                }
                else if(sy==semicolon){
                    insym();
                    semisym=1;break;
                }
                else {
                    error(12);
                    if(sy!=ident)
                    insym();
                }
            }
            if(sy!=semicolon && semisym!=1)
                error(13);
            //printf("This is const defination!Type is char\n");
            break;
        default:
            error(15);
            break;

    }

}
void conststate(){//常量说明
    while(sy==CONSTSY){
        constdef();
        //printf("sy in constate:%d\n",sy);

    }//printf("This is const statement part !\n");
    //printf("\n");
}
void vardef(){//变量定义
    int semisym=0;
    switch(sy){
        case INTSY:
            //printf("INSY begin\n");
            insym();
            if(sy>=1 && sy <=12){error(35);sy=ident;}
            while(sy == ident){
                if(loc1(token)==1){error(34);}
                enter(token,1,0);

                insym();
                if(sy == lparent){
                    MTable.Tab[MTable.tabindex].obj=2;
                    emit(funcsign);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"int");
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[MTable.tabindex].name);
                    funcsym=1;
                    break;
                }
                emit(intsign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[MTable.tabindex].name);
                if(sy == lbrack){
                    insym();
                    if(sy == ints){
                        if(num==0){error(16);printf("num is 0\n");num=1;}
                        MTable.Tab[MTable.tabindex].paranum=num;
                        strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,token);
                        insym();
                    }
                    if(sy == rbrack)insym();
                    else {error(9);printf("defect ]\n");insym();}
                }
                if(sy == comma){
                        insym();
                if(sy == CONSTSY || sy == INTSY || sy == CHARSY || sy ==VOIDSY){
                        error(29);
                     }
                }
                else if(sy == semicolon){
                    insym();
                    semisym=1;break;
                }
                else {
                    error(12);
                    insym();
                }
            }
            if(funcsym==1)break;
            if(sy!=semicolon && semisym!=1)
                {error(13);printf("defect }\n");}
            //printf("This is var defination!Type is int\n");
            break;
        case CHARSY:
            insym();
            //printf("CHARSY begin\n");

            if(sy>=1 && sy <=12){error(35);sy=ident;}
            while(sy == ident){
                    if(loc1(token)==1){error(34);}
                enter(token,1,1);
                insym();
                if(sy == lparent){
                    MTable.Tab[MTable.tabindex].obj=2;
                    emit(funcsign);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"CHAR");
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[MTable.tabindex].name);
                    funcsym=1;
                    break;
                }
                emit(charsign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[MTable.tabindex].name);
                if(sy == lbrack){
                    insym();
                    if(sy == ints){
                        if(num==0){error(16);printf("num is 0\n");num=1;}
                        MTable.Tab[MTable.tabindex].paranum=num;
                        strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,token);
                        insym();
                    }
                    if(sy == rbrack)insym();
                    else {error(9);printf("defect ]\n");insym();}
                }
                if(sy == comma){
                        insym();
                if(sy == CONSTSY || sy == INTSY || sy == CHARSY || sy ==VOIDSY){
                        error(29);
                     }
                }
                else if(sy == semicolon){
                    insym();
                    semisym=1;break;
                }
                else {
                    error(12);
                    insym();
                }
            }
            if(funcsym==1)break;
            if(sy!=semicolon && semisym!=1)
                error(13);
            //printf("This is var defination!Type is char\n");
            break;
        default:
            error(17);
            //printf("not int or char\n");
    }

}
void varstate(){//变量说明
    while(sy == INTSY || sy == CHARSY){
        vardef();
        if(funcsym == 1){
            //printf("isFunction\n");
            break;
        }

    }//printf("This is var statement part !\n");
   // printf("\n");
}
void parastate(){//形参表
    insym();
    int parnum=0;
    if(sy != CHARSY && sy != INTSY && sy !=rparent)
    {error(10);}
    while(sy == CHARSY || sy ==INTSY){
        parnum++;
        switch(sy){
            case CHARSY:
                emit(parsign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"char");
                insym();
                if(sy != ident){error(18);printf("sy is not id\n");}
                else{
                    enter(token,3,1);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,token);
                }
                break;
            case INTSY:
                emit(parsign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"int");
                insym();
                if(sy != ident)error(18);
                else{
                    enter(token,3,0);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,token);
                }
                break;
            default:
                break;
        }
        insym();
        if(sy == rparent)break;
        else if(sy == comma){
            insym();
           //printf("parastate:%d\n",sy);
            if(sy == INTSY || sy == CHARSY){
                continue;
            }
            else {error(19);printf("defect )\n");break;}
        }
        else
            {error(10);}
    }
    MTable.Tab[MTable.tabindex-parnum].paranum=parnum;
    //printf("This is para statement!\n");
}

void ifstate(){//if语句
    char *ifn,*endifn,endnif[10];
    insym();
    emit(labsign);
    ifn=genlab(1);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,ifn);
    endifn=genlab(2);
    strcpy(endnif,endifn);
    char re1[50];
    if(sy!=lparent){error(20);sy=lparent;}
    if(sy == lparent){
            insym();
        condiexpr(re1);
        if(re1[0] == '\0'){
            error(30);
        }
        emit(jnesign);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].res,endifn);
        if(strcmp(re1,"re")!=0){
            strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,re1);
        }
       // printf("sy in if:%d\n",sy);
        if(sy == rparent){insym();}
        else {error(10);printf("defect )");}
    }
    statement();
    emit(labsign);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,endnif);

    //printf("This is if statement!\n");
}
void whilestate(){//while语句
    char *whilen,*endwhilen,endnwhile[25],nwhile[20];
    insym();
    char re1[50];
    emit(labsign);
    whilen=genlab(3);
    strcpy(nwhile,whilen);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,whilen);
    endwhilen=genlab(4);
    strcpy(endnwhile,endwhilen);
    if(sy!=lparent){error(20);sy=lparent;}
    if(sy == lparent){
            insym();
        condiexpr(re1);
        if(re1[0] == '\0'){
            error(30);
        }
        emit(jnesign);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].res,endwhilen);
        if(strcmp(re1,"re")!=0){
            strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,re1);
        }
        if(sy == rparent){insym();}
        else {error(10);printf("defect )");}
    }
    statement();
    emit(jmpsign);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,nwhile);
    emit(labsign);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,endnwhile);
    //printf("This is while statement!\n");
}
void casetab(char elab[],int sn,char e[]){//情况表
    if(sy != CASESY){error(21);printf("in case Tab:defect case\n");}
    while(sy == CASESY){
        insym();

        onecase(sn,e);
        emit(jmpsign);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].res,elab);
        insym();
    }
   // printf("This is case tab!\n");
}
void onecase(int swn,char e[]){//一个分支
    char st[25],charstr[5];
    int opc,isc=0;
    caseTab.sw[swn].caseptr=caseTab.sw[swn].caseptr+1;
    if(sy == minuss || sy == pluss){opc=sy;insym();}
    if(sy == ints){
            strcpy(st,token);
            if(opc==minuss){strcpy(st,"-");strcat(st,token);}

            strcpy(caseTab.sw[swn].casens[caseTab.sw[swn].caseptr-1].casename,st);
    }
    else if(sy == charcon){
            strcpy(caseTab.sw[swn].casens[caseTab.sw[swn].caseptr-1].casename,token);
            strcpy(charstr,"'");
            strcat(charstr,caseTab.sw[swn].casens[caseTab.sw[swn].caseptr-1].casename);
            strcat(charstr,"'");
            isc=1;
    }
    else{
        error(22);
    }
    emit(labsign);
    emit(eqlsign);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,e);
    if(isc==1)
    strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,charstr);
    else
       strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,st);
    emit(jnesign);
    caseTab.sw[swn].casens[caseTab.sw[swn].caseptr-1].casedes=midtab.midcodeptr-1;
    insym();
    if(sy == colon){
            insym();
        statement();
    }
    else error(23);
    //printf("one case is over!\n");
}
void defaultcase(int swn){//缺省
    emit(labsign);
    char str1[5]="swi",str2[5];
    itoa(swn,str2,10);
    strcat(str1,str2);
    strcat(str1,"csdef");
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,str1);
    insym();
    if(sy == colon)insym();
    else{error(23);printf("default defect :\n");}
    if(sy != rbrace){
    statement();
    insym();
    }else{
        error(13);
    }

    //printf("This is default case!\n");
}
void switchstate(){//switch情况语句
    char *switchn,*endswitchn,endnswitch[10];
    int swcout,rety1;
    int defsy=0;
    char re1[50];
    int a=0;
    swcout=switchnum;
    //printf("switchnum:%d\n",switchnum);
    caseTab.swptr=caseTab.swptr+1;
    insym();
    emit(labsign);
    switchn=genlab(5);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,switchn);
    endswitchn=genlab(6);
    strcpy(endnswitch,endswitchn);
    if(sy!=lparent){error(20);printf("1:in switch defect (\n");sy=lparent;}
    if(sy == lparent){
            insym();
        expression(re1,&rety1,&a);
        if(sy == rparent){insym();}
        else{error(10);printf("2:in switch defect )\n");}
    }
    if(sy == lbrace){
        insym();
        casetab(endnswitch,swcout,re1);
    }
    else {
        error(24);
        printf("in switch defect {\n");
    }
    if(sy == DEFAULTSY){
        defaultcase(swcout);
        defsy=1;
    }
    if(sy != rbrace){
        error(25);
        printf("defect } in switch\n");
    }
    emit(labsign);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,endnswitch);
    gejcase(swcout,defsy,endnswitch);
    defsy=0;
    //printf("This is switch statement!\n");
}
void scanstate(){//读语句
    insym();
    if(sy != lparent){error(20);printf("defect (\n");sy=lparent;}
    if(sy == lparent){
        insym();
        while(sy == ident){
            emit(scafsign);
            strcpy(midtab.Midcod[midtab.midcodeptr-1].res,token);
            /*标识符*/
            insym();
            if(sy == rparent)break;
            else if(sy == comma){insym();continue;}
            else {error(10);printf("defect )\n");}//缺少')'
        }
    }
    insym();
    if(sy != semicolon){error(13);printf("defect ;\n");}
    //printf("This is scanf statement!\n");
}
void prtfstate(){//写语句
    insym();
    int prtdes=0,ju=0,rety1=0,a=0;
    char re2[50];
    if(sy != lparent){error(20);printf("defect (\n");sy=lparent;}
    if(sy == lparent){
        insym();//》》》》
        if(sy == stringcon){
            /*打印字符串*/
            emit(strsign);
            prtdes=midtab.midcodeptr-1;
            genstr(midtab.midcodeptr-1);
            strcpy(midtab.Midcod[midtab.midcodeptr-1].res,str);
            //printf("string:%s\n",str);

            clearString();
            insym();
            if(sy == comma){
                    insym();
                expression(re2,&rety1,&a);
                ju=1;
                /*表达式*/

            }else if(sy != rparent)error(0);//缺少')'
            emit(prtfsign);
            strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,midtab.Midcod[prtdes].src1);
            strcpy(midtab.Midcod[midtab.midcodeptr-1].res,"strsym");
            if(ju==1)
            strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,re2);
        }
        else{
        if(sy != rparent){
            expression(re2,&rety1,&a);
            emit(prtfsign);
            strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,re2);
        }
        }
        if(sy == rparent){insym();}
        else {error(10);printf("in print defect )\n");}
    }
    if(sy != semicolon)
    {error(13);printf("defect ;\n");}
    //printf("This is printf statement!\n");
}
void assignment(int adr){//赋值语句
    char re1[50],re2[50];
    int rety1=0,rety2=0;
    int a=0;
    if(MTable.Tab[adr].obj==0){error(36);}
    if(MTable.Tab[adr].paranum==0)
    {
        insym();
        if(sy==eqlsy){
            insym();
            expression(re2,&rety1,&a);
            //if(MTable.Tab[adr].typ==1){
            if(rety1 != MTable.Tab[adr].typ)error(14);
            emit(asseql);
            strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[adr].name);
            strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,re2);
            //}//MTable.Tab[adr].value=re2;
            //else {;}//MTable.Tab[adr].value=re2;
        }
        else{
            error(11);
        }
        //emit(asseql);
    }
    else{
           // printf("assign for Array\n");
        insym();
        if(sy == lbrack){
            insym();
            expression(re1,&rety1,&a);
            if(aryjud!=-1){
                if(a<0 || a>=MTable.Tab[adr].paranum)error(31);
                   // printf("%d\n",a);
             }
            //printf("%d\n",re1);
            if(sy==rbrack){
                insym();
                if(sy==eqlsy){
                    insym();
                    expression(re2,&rety2,&a);
                    if(rety2 != MTable.Tab[adr].typ)error(14);
                    emit(assary);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[adr].name);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,re1);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,re2);
                }
                else{error(11);}
            }
            else error(9);
        }
        else{
            error(8);
        }
        //emit(assary);
    }
    //printf("sy:%d\n",sy);
    if(sy!=semicolon){error(13);printf("defect ;\n");}
   //printf("This is assignment!\n");
}
void retstate(){//return语句
    retval=0;
    rettyp=0;
    insym();
    char re1[50];
    int rety1=0,a=0;
    if(sy != lparent){
    if(sy != semicolon){printf("defect (\n");error(20);sy=lparent;}//缺失'('
    }
    retsy=1;
    if(sy == lparent){
            //printf("expression \n");
        retval=1;
        insym();
        expression(re1,&rety1,&a);
        rettyp=rety1;
        if(sy!=rparent){error(10);printf("defect )\n");}
        else insym();
        emit(retsign);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,re1);
    }
    else emit(retsign);
    //printf("sy in ret:%d\n",sy);
    if(sy!=semicolon){error(13);printf("defect ;\n");}
    //printf("This is return statement!\n");

}

void call(int adr,int *jud){//调用函数
    int k=MTable.Tab[adr].paranum;
    int i=0,rety1,a=0;
    //printf("call:%s sy:%d\n",token,sy);
    char re1[50];
    if(sy == lparent ){
            insym();
        for(i=1;i<=k;i++){
            expression(re1,&rety1,&a);
            if(rety1 != MTable.Tab[adr+i].typ){error(18);}
            emit(setsign);
            strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[adr+i].name);
            strcpy(midtab.Midcod[midtab.midcodeptr-1].src2,re1);
            if(sy != comma && sy != rparent){error(12);printf("defect ),");}
            else if(sy == comma) insym();
            else if(sy == rparent)break;
        }
        if(i!=k && k!=0){
        error(27);
        //printf("%d\n",i);
        }
    }


    emit(callsign);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,MTable.Tab[adr].name);
    *jud=midtab.midcodeptr-1;
    //if(k==0){insym();insym();}
    if(sy!=rparent){error(10);printf("function call defect )\n");}
    else insym();
    //printf("This part call Function:%s is over\n",MTable.Tab[adr].name);
}

void statement(){//语句
    int i=0;
    switch(sy){
        case IFSY:
            ifstate();
            break;
        case WHILESY:
            whilestate();
            break;
        case PRINTSY:
            prtfstate();
            break;
        case RETURNSY:
            retsy=1;
            retstate();
            break;
        case SCANFSY:
            scanstate();
            break;
        case SWITCHSY:
            switchstate();
            break;
        case semicolon:
            //printf("This is a blank statement!\n");
            break;
        case lbrace:
            insym();
            statelist();
            break;
        case ident:
            //printf("%s\n",token);
            i=loc(token);
           //printf("%d\n",i);
           int re;
            if(i==-1){error(7);printf("cant find funktion or var\n");break;}
            if(MTable.Tab[i].obj==2){insym();call(i,&re);
            //printf("call is over!\n");
            if(sy != semicolon){error(13);printf("call statement defect semiclon!\n");}}
            else if(MTable.Tab[i].obj==1||MTable.Tab[i].obj==3 || MTable.Tab[i].obj==0)assignment(i);
            break;
        default:
            break;
    }
    //printf("\n");
}
void statelist(){//语句列
    while(sy == IFSY || sy==WHILESY ||sy==PRINTSY ||sy==RETURNSY ||sy==SCANFSY ||sy==SWITCHSY||sy==semicolon||sy==lbrace||sy==ident){
            statement();
            //printf("statelist ident +1\n");
            if(feof(fp))break;
            insym();
            //printf("sy:%d\n",sy);
            //printf("%s\n",token);
    }
    //printf("line:%d\n",linecout+1);

    /*if(sy != rbrace){
        error(0);
        printf("defect }\n");
    }*/
    //printf("statelist is over!\n");
}
void cpstate(){//复合语句
    insym();
    //printf("cpstate begin \n");
    if(sy == CONSTSY){
        conststate();
    }
    if(sy == INTSY || sy == CHARSY){
        varstate();
    }

    if(sy != rbrace){
            //printf("statelist run:\n");
        statelist();
    }
    //printf("This is combine statement!\n");
}

void funcstate(){//函数说明
    char fname[50];
    int ftyp=-1;
    if(sy == lparent){
        //printf("%s\n",MTable.Tab[MTable.tabindex].name);
        strcpy(fname,MTable.Tab[MTable.tabindex].name);
        ftyp=MTable.Tab[MTable.tabindex].typ;
        parastate();
        insym();
        if(sy == lbrace){
            cpstate();
            linecout=linecout-1;
            if(retsy!=1 && ftyp!=2 && retval!=1){error(28);ftyp=-1;}
            if(retsy==1 && retval==1 && ftyp==2){error(33);ftyp=-1;}
            if(retsy==1 && ftyp!=2 && rettyp!=ftyp){error(38);ftyp=-1;}
            linecout=linecout+1;
            retsy=0;retval=0;
            MTable.display[MTable.num]=MTable.tabindex;
            MTable.num++;
        }
        else {error(24);cpstate();}
       //printf("This is funktion statement!\n");
       emit(endfsign);
       strcpy(midtab.Midcod[midtab.midcodeptr-1].res,fname);
       //printf("\n");
    }
    insym();
    funcsym=0;
    while(sy == INTSY || sy == CHARSY || sy == VOIDSY){
        switch(sy){
            case INTSY:
                insym();
                if(sy>=1 && sy <=12){error(35);sy=ident;}
                if(sy == ident){
                    enter(token,2,0);
                    emit(funcsign);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"int");
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[MTable.tabindex].name);

                    //printf("%s\n",MTable.Tab[MTable.tabindex].name);
                    strcpy(fname,MTable.Tab[MTable.tabindex].name);
                    insym();
                    if(sy == lparent){
                        parastate();
                        insym();

                        if(sy == lbrace){
                            cpstate();
                            linecout=linecout-1;
                            if(retsy!=1){error(28);retsy=0;}
                            if(retsy==1 && rettyp!=0){error(38);}
                            linecout=linecout+1;
                            retsy=0;retval=0;
                            MTable.display[MTable.num]=MTable.tabindex;
                            MTable.num++;
                           // printf("sy in int func:%d\n",sy);
                            if(sy != rbrace){
                                error(25);printf("defect }\n");
                            }
                        }
                        else {error(24);printf("defect {,program is over\n");}
                    }
                }
                emit(endfsign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].res,fname);
                break;
            case CHARSY:
                insym();
                if(sy>=1 && sy <=12){error(35);sy=ident;}
                if(sy == ident){
                    enter(token,2,1);
                    emit(funcsign);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"char");
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[MTable.tabindex].name);

                    insym();
                     //printf("%s\n",MTable.Tab[MTable.tabindex].name);
                     strcpy(fname,MTable.Tab[MTable.tabindex].name);
                    if(sy == lparent){
                        parastate();
                        insym();
                        if(sy == lbrace){
                            cpstate();linecout=linecout-1;
                            if(retsy!=1){error(28);}
                            if(retsy==1 && rettyp!=1){error(38);;}
                            linecout=linecout+1;
                            retsy=0;retval=0;
                            MTable.display[MTable.num]=MTable.tabindex;
                            MTable.num++;
                           // printf("sy in char func:%d\n",sy);
                            if(sy != rbrace){
                                error(25);printf("defect }\n");
                            }
                        }
                        else {error(24);printf("defect {\n");}
                    }
                }
                emit(endfsign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].res,fname);
                break;
            case VOIDSY:
                insym();
                if(sy>=1 && sy <=12 && sy != MAINSY){error(35);sy=ident;}
                if(sy == ident){
                    enter(token,2,2);
                    emit(funcsign);
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"void");
                    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[MTable.tabindex].name);
                    insym();
                     //printf("%s\n",MTable.Tab[MTable.tabindex].name);
                     strcpy(fname,MTable.Tab[MTable.tabindex].name);
                    if(sy == lparent){
                        parastate();
                        insym();
                        if(sy == lbrace){
                            cpstate();//printf("sy in void func:%d\n",sy);
                            linecout=linecout-1;
                            if(retsy==1 && retval==1){error(33);}
                            linecout=linecout+1;
                            retsy=0;retval=0;
                            MTable.display[MTable.num]=MTable.tabindex;
                            MTable.num++;
                            if(sy != rbrace){
                                error(25);printf("defect }\n");
                            }
                        }
                        else {error(24);cpstate();}
                    }
                emit(endfsign);
                strcpy(midtab.Midcod[midtab.midcodeptr-1].res,fname);
                }
                else if(sy == MAINSY){
                while(sy != lbrace)
                    insym();
                mainstate();
                }

                break;
            default:
                break;
        }
        insym();
    //printf("This is a funktion statement!\n");
    //printf("\n");
    }
}
int mainnsy=0;
void mainstate(){//主函数说明
    //printf("main start!\n");
    enter("main",2,2);
    emit(funcsign);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"void");
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,"main");
    if(sy == lbrace){
    cpstate();
        //printf("%d %d\n",retsy,retval);
        if(retsy == 1 && retval == 1){linecout=linecout-1;error(33);linecout=linecout+1;}
        retsy=0;retval=0;
    }
    else{
        error(24);
        cpstate();
       // printf("%d %d\n",retsy,retval);
        if(retsy == 1 && retval == 1){linecout=linecout-1;error(33);linecout=linecout+1;}
        retsy=0;retval=0;
    }
    //printf("sy  :  %d\n",sy);
    if(sy != rbrace && feof(fp)>0){
        error(32);
    }
    MTable.display[MTable.num]=MTable.tabindex;
    MTable.num++;
    emit(endfsign);
    strcpy(midtab.Midcod[midtab.midcodeptr-1].res,"main");
    //printf("This is main funktion!\n");
    mainnsy=1;
}
void program(){//程序
    insym();
    int i_des=0;
    int jud_c=0,jud_v=0;
    if(sy == CONSTSY){
        conststate();
        MTable.display[MTable.num]=MTable.tabindex;
        i_des=MTable.num;
        MTable.num++;
        jud_c=1;
    }
    //printf("const def end!\n");
    if(sy == INTSY || sy == CHARSY){
        varstate();
        if(funcsym==1){
if(jud_c==0){MTable.display[MTable.num]=MTable.tabindex;MTable.num++;}
            else MTable.display[i_des]=MTable.tabindex;
            MTable.display[0]=MTable.tabindex-1;
            funcstate();
            funcsym=0;
        }
        else{
        if(jud_c==0){MTable.display[MTable.num]=MTable.tabindex;MTable.num++;}
            else MTable.display[i_des]=MTable.tabindex;
        }
        //printf("var or fuktion!\n");
    }
    //printf("sy:%d\n",sy==VOIDSY);
    if(sy == VOIDSY){
            insym();
    //printf("sy:%d\n",sy);
        if(sy == MAINSY){
            while(sy != lbrace)insym();
            mainstate();
        }
        else {
            if(sy>=1 && sy<=12){error(35);sy=ident;}
            enter(token,2,2);
                emit(funcsign);
        strcpy(midtab.Midcod[midtab.midcodeptr-1].src1,"void");
        strcpy(midtab.Midcod[midtab.midcodeptr-1].res,MTable.Tab[MTable.tabindex].name);
                //printf("funktion begin\n");
                insym();
            funcstate();
        }
    }
    if(mainnsy!=1)error(0);
    //printf("sy:%d\n",sy==VOIDSY);
   // printf("%d %d %d %d\n",mainnsy,MTable.num,midtab.midcodeptr,MTable.tabindex);
    /*int i=0;

    for(i=0;i<MTable.num;i++){
        printf("%d %d\n",i,MTable.display[i]);
    }*/

}
