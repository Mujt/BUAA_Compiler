#include <stdio.h>
#include <string.h>
#include "Lexical.h"
#include "syn.h"
#include "error.h"
#include "Lexical.h"
extern mainTab MTable;
extern char token[tokensize];
int semisym=0;
extern int Tokenpoint;
extern char str[strsize];
void print_tab(){
    int i=0;
    for(i=1;i<MTable.tabindex+1;i++){
        printf("%s %d %d %d %d\n",MTable.Tab[i].name,MTable.Tab[i].obj,MTable.Tab[i].typ,MTable.Tab[i].value,MTable.Tab[i].paranum);
    }
}
void enter(char nm[],int obj1,int typ1){//向符号表添加
    MTable.tabindex=MTable.tabindex+1;
    strcpy(MTable.Tab[MTable.tabindex].name,nm);
    MTable.Tab[MTable.tabindex].obj=obj1;
    MTable.Tab[MTable.tabindex].typ=typ1;
}

int funcsym=0;
int op=0;

int loc(char name[]){//查找符号表
    int j=0;
    for(j=MTable.tabindex;j>=1;j--){
        if(strcmp(name,MTable.Tab[j].name)==0)break;
    }
    return j;
}
void factor(int *re){//因子
    int re1=0;

    if(sy == ident){

        int i=loc(token);
        insym();
        if(i==0){error(0);printf("id is not defined!\n");}
        else {
            int j=MTable.Tab[i].obj;
            switch(j){
                case 0://常量
                    *re=MTable.Tab[i].value;
                    break;
                case 1://变量
                    if(MTable.Tab[i].paranum!=0){
                        if(sy!=lbrack){error(0);printf("defect [\n");sy=lbrack;}
                        if(sy==lbrack){
                            insym();
                            expression(&re1);
                            /*表达式结果为*/
                            if(sy != rbrack){
                                error(0);
                                printf("defect ]\n");
                                sy=rbrack;
                            }
                            else insym();
                        }
                    }
                    else *re=MTable.Tab[i].value;
                    break;
                case 2://函数
                    call(i);
                    *re=MTable.Tab[i].value;
                    break;
                case 3://参数
                    *re=MTable.Tab[i].value;
                    break;
            }
        }
        //printf("factor is id sy:%d\n",sy);
    }
    else if(sy == ints || sy == charcon){//常量、字符
            if(sy == ints)*re=num;
            else *re=token[0];
            insym();
    }
    else if(sy == lparent){//(
        insym();
        int re1=0;
        expression(&re1);
        *re=re1;
        if(sy == rparent)insym();
        else {error(0);printf("defect )");}
    }
    printf("This is factor!\n");
}
void term(int *re){//项
    int re1=0,re2=0;
    factor(&re1);
    while(sy == times || sy == idiv){
        op=sy;
        insym();
        factor(&re2);
        if(op == times){
        /*乘*/re1=re1*re2;
        }
        else {
            /*除*/re1=re1/re2;
        }
    }
    *re=re1;
    printf("This is term\n");
}
void expression(int *re){//表达式
    int re1=0,re2=0;
    if(sy == minuss||sy == pluss){
        op=sy;
        insym();
        term(&re1);
        if(op == minuss){
            /*取负*/re1=-re1;
        }
    }
    else term(&re1);
    //printf("sy:%d\n",sy);
    while(sy == minuss ||sy == pluss){
        op=sy;
        insym();
        term(&re2);
        if(op == pluss){
            /*加*/re1=re1+re2;
        }
        else {
            /*减*/re1=re1-re2;
        }
    }
    printf("This is expression \n");
    *re=re1;
}
void condiexpr(int *re){//条件表达式
    int re1=0,re2=0;
    expression(&re1);
    *re=re1;
    if(sy >= 33 && sy <=39 && sy != 35){
        op=sy;
        insym();
        expression(&re2);
        switch(op){
            case lesss:
                *re = (re1<re2);
                break;
            case gree:
                *re = (re1>re2);
                break;
            case leq:
                *re = (re1<=re2);
                break;
            case geq:
                *re = (re1>=re2);
                break;
            case eql:
                *re = (re1==re2);
                break;
            case uneql:
                *re = (re1!=re2);
                break;
        }
    }
    else if(sy != rparent)
            error(0);

}
void constdef(){//常量定义

    insym();
    switch(sy){
        case INTSY:
            insym();
            while(sy==ident){
                enter(token,0,0);
                insym();
                if(sy==eqlsy)insym();
                else {error(0);sy=eqlsy;
                if(sy != ints)insym();}
                 if(sy==minuss || sy == pluss){op=sy;insym();}
                if(sy==ints){
                    if(op == minuss)num=-num;
                    MTable.Tab[MTable.tabindex].value=num;
                    insym();
                }
                else {
                    error(0);
                    if(sy == charcon){
                        insym();
                    }
                }
                if(sy==comma)insym();
                else if(sy==semicolon){
                    insym();
                    semisym=1;break;
                }
                else {
                    error(0);
                    insym();
                }
            }
            if(sy!=semicolon && semisym!=1)
                error(0);
            printf("This is const defination!Type is int\n");
            break;
        case CHARSY:
            insym();
            while(sy==ident){
                enter(token,0,1);
                insym();
                if(sy==eqlsy)insym();
                else {error(0);sy=eqlsy;
                if(sy!=charcon)insym();}
                if(sy==charcon){
                    MTable.Tab[MTable.tabindex].value=charvalue;
                    insym();
                }
                else {
                    error(0);
                    if(sy == ints){
                        insym();
                    }
                }
                if(sy==comma)insym();
                else if(sy==semicolon){
                    insym();
                    semisym=1;break;
                }
                else {
                    error(0);
                    if(sy!=ident)
                    insym();
                }
            }
            if(sy!=semicolon && semisym!=1)
                error(0);
            printf("This is const defination!Type is char\n");
            break;
        default:
            error(0);
            break;

    }

}
void conststate(){//常量说明
    while(sy==CONSTSY){
        constdef();
        //printf("sy in constate:%d\n",sy);

    }printf("This is const statement part !\n");
    printf("\n");
}
void vardef(){//变量定义
    int semisym=0;
    switch(sy){
        case INTSY:
            //printf("INSY begin\n");
            insym();
            while(sy == ident){
                enter(token,1,0);
                insym();
                if(sy == lparent){
                    MTable.Tab[MTable.tabindex].obj=2;
                    funcsym=1;
                    break;
                }
                if(sy == lbrack){
                    insym();
                    if(sy == ints){
                        if(num==0){error(0);printf("num is 0\n");num=1;}
                        MTable.Tab[MTable.tabindex].paranum=num;
                        insym();
                    }
                    if(sy == rbrack)insym();
                    else {error(0);printf("defect ]\n");insym();}
                }
                if(sy == comma)insym();
                else if(sy == semicolon){
                    insym();
                    semisym=1;break;
                }
                else {
                    error(0);
                    insym();
                }
            }
            if(funcsym==1)break;
            if(sy!=semicolon && semisym!=1)
                {error(0);printf("defect }\n");}
            printf("This is var defination!Type is int\n");
            break;
        case CHARSY:
            insym();
            //printf("CHARSY begin\n");

            while(sy == ident){
                enter(token,1,1);
                insym();
                if(sy == lparent){
                    MTable.Tab[MTable.tabindex].obj=2;
                    funcsym=1;
                    break;
                }
                if(sy == lbrack){
                    insym();
                    if(sy == ints){
                        if(num==0){error(0);printf("num is 0\n");num=1;}
                        MTable.Tab[MTable.tabindex].paranum=num;
                        insym();
                    }
                    if(sy == rbrack)insym();
                    else {error(0);printf("defect ]\n");insym();}
                }
                if(sy == comma)insym();
                else if(sy == semicolon){
                    insym();
                    semisym=1;break;
                }
                else {
                    error(0);
                    insym();
                }
            }
            if(funcsym==1)break;
            if(sy!=semicolon && semisym!=1)
                error(0);
            printf("This is var defination!Type is char\n");
            break;
        default:
            error(0);
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

    }printf("This is var statement part !\n");
    printf("\n");
}
void parastate(){//形参表
    insym();
    int parnum=0;
    if(sy != CHARSY && sy != INTSY && sy !=rparent)
    {error(0);}
    while(sy == CHARSY || sy ==INTSY){
        parnum++;
        switch(sy){
            case CHARSY:
                insym();
                if(sy != ident){error(0);printf("sy is not id\n");}
                else{
                    enter(token,3,1);
                }
                break;
            case INTSY:
                insym();
                if(sy != ident)error(0);
                else{
                    enter(token,3,0);
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
            else {error(0);printf("defect )\n");break;}
        }
    }
    MTable.Tab[MTable.tabindex-parnum].paranum=parnum;
    printf("This is para statement!\n");
}

void ifstate(){//if语句
    insym();
    int re1=0;
    if(sy!=lparent){error(0);sy=lparent;}
    if(sy == lparent){
            insym();
        condiexpr(&re1);
       // printf("sy in if:%d\n",sy);
        if(sy == rparent){insym();}
        else {error(0);printf("defect )");}
    }
    statement();
    printf("This is if statement!\n");
}
void whilestate(){//while语句
    insym();
    int re1=0;
    if(sy!=lparent){error(0);sy=lparent;}
    if(sy == lparent){
            insym();
        condiexpr(&re1);
        if(sy == rparent){insym();}
        else {error(0);printf("defect )");}
    }
    statement();
    printf("This is while statement!\n");
}
void casetab(){//情况表
    if(sy != CASESY){error(0);printf("in case Tab:defect case\n");}
    while(sy == CASESY){
        insym();
        onecase();
        insym();
    }
    printf("This is case tab!\n");
}
void onecase(){//一个分支
    //int casei=0;
    //if(sy == ints){
      //  casei=num;
    //}
    insym();
    if(sy == colon){
            insym();
        statement();
    }
    printf("one case is over!\n");
}
void defaultcase(){//缺省
    insym();
    if(sy == colon)insym();
    else{error(0);printf("default defect :\n");}
    if(sy != rbrace)
    statement();
    insym();
    printf("This is default case!\n");
}
void switchstate(){//switch情况语句
    insym();
    int re1=0;
    if(sy!=lparent){error(0);printf("1:in switch defect (\n");sy=lparent;}
    if(sy == lparent){
            insym();
        expression(&re1);
        if(sy == rparent){insym();}
        else{error(0);printf("2:in switch defect )\n");}
    }
    if(sy == lbrace){
        insym();
        casetab();
    }
    else {
        error(0);
        printf("in switch defect {\n");
    }
    if(sy != DEFAULTSY){
        error(0);
        printf("defect defaultstatement\n");
    }
    else defaultcase();
    if(sy != rbrace){
        error(0);
        printf("defect } in switch\n");
    }
    printf("This is switch statement!\n");
}
void scanstate(){//读语句
    insym();
    if(sy != lparent){error(0);printf("defect (\n");sy=lparent;}
    if(sy == lparent){
        insym();
        while(sy == ident){
            /*标识符*/
            insym();
            if(sy == rparent)break;
            else if(sy == comma){insym();continue;}
            else {error(0);printf("defect )\n");}//缺少')'
        }
    }
    insym();
    if(sy != semicolon){error(0);printf("defect ;\n");}
    printf("This is scanf statement!\n");
}
void prtfstate(){//写语句
    insym();
    int re1=0,re2=0;
    if(sy != lparent){error(0);printf("defect (\n");sy=lparent;}
    if(sy == lparent){
        insym();//》》》》
        if(sy == stringcon){
            /*打印字符串*/
           // printf("string:%s\n",str);
            clearString();
            insym();
            if(sy == comma){
                    insym();
                expression(&re2);
            }else if(sy != rparent)error(0);//缺少')'
        }
        else{
        if(sy != rparent){
            expression(&re2);
        }
        }
        if(sy == rparent){insym();}
        else {error(0);printf("in print defect )\n");}
    }
    if(sy != semicolon)
    {error(0);printf("defect ;\n");}
    printf("This is printf statement!\n");
}
void assignment(int adr){//赋值语句
    int re1=0,re2=0;
    if(MTable.Tab[adr].paranum==0)
    {
        insym();
        if(sy==eqlsy){
            insym();
            expression(&re2);
            if(MTable.Tab[adr].typ==1)MTable.Tab[adr].value=re2;
            else MTable.Tab[adr].value=re2;
        }
    }
    else{
           // printf("assign for Array\n");
        insym();
        if(sy == lbrack){
            insym();
            expression(&re1);
            //printf("%d\n",re1);
            if(sy==rbrack){
                insym();
                if(sy==eqlsy){
                    insym();
                    expression(&re2);
                   if(MTable.Tab[adr].typ==1) MTable.Tab[adr].arrayv[re1]=re2;
                   else MTable.Tab[adr].arrayv[re1]=re2;
                }
            }
        }
    }
    //printf("sy:%d\n",sy);
    if(sy!=semicolon){error(0);printf("defect ;\n");}
    printf("This is assignment!\n");
}
void retstate(){//return语句
    insym();
    int re1=0;
    if(sy != lparent){
    if(sy != semicolon){printf("defect (\n");error(0);sy=lparent;}//缺失'('
    }
    if(sy == lparent){
            //printf("expression \n");
        insym();
        expression(&re1);
        if(sy!=rparent){error(0);printf("defect )\n");}
        else insym();
    }
    //printf("sy in ret:%d\n",sy);
    if(sy!=semicolon){error(0);printf("defect ;\n");}
    printf("This is return statement!\n");
}

void call(int adr){//调用函数
    int k=MTable.Tab[adr].paranum;
    int i=0;
    if(sy == lparent || k>0){
        for(i=0;i<k-1;i++){
            while (sy!=comma)insym();
        }
        while(sy != rparent)insym();
    }
    if(k==0){insym();insym();}
    //printf("sy in call():%d %s\n",sy,token);

    if(sy!=rparent){error(0);printf("function call defect )\n");}
    else insym();
    printf("This part call Function:%s is over\n",MTable.Tab[adr].name);
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
            retstate();
            break;
        case SCANFSY:
            scanstate();
            break;
        case SWITCHSY:
            switchstate();
            break;
        case semicolon:
            printf("This is a blank statement!\n");
            break;
        case lbrace:
            insym();
            statelist();
            break;
        case ident:
            //printf("%s\n",token);
            i=loc(token);
           // printf("%d\n",i);
            if(i==0){error(0);break;}
            if(MTable.Tab[i].obj==2){call(i);}
            else if(MTable.Tab[i].obj==1)assignment(i);
            break;
        default:
            break;
    }
    printf("\n");
}
void statelist(){//语句列
    while(sy == IFSY || sy==WHILESY ||sy==PRINTSY ||sy==RETURNSY ||sy==SCANFSY ||sy==SWITCHSY||sy==semicolon||sy==lbrace||sy==ident){
            statement();
            //printf("statelist ident +1\n");
            insym();
            //printf("%s\n",token);
    }
    /*if(sy != rbrace){
        error(0);
        printf("defect }\n");
    }*/
    printf("statelist is over!\n");
}
void cpstate(){//复合语句
    insym();
    //printf("cpstate begin \n");
    if(sy == CONSTSY){
        conststate();
        MTable.display[MTable.num]=MTable.tabindex;
        MTable.num++;
    }
    if(sy == INTSY || sy == CHARSY){
        varstate();

    }
    if(sy != rbrace){
            //printf("statelist run:\n");
        statelist();
    }
    printf("This is combine statement!\n");
}

void funcstate(){//函数说明
    if(sy == lparent){
        //printf("%s\n",MTable.Tab[MTable.tabindex].name);
        parastate();
        insym();
        if(sy == lbrace){
            cpstate();
        }
        else {error(0);cpstate();}
       printf("This is funktion statement!\n");
       printf("\n");
    }
    insym();
    funcsym=0;
    while(sy == INTSY || sy == CHARSY || sy == VOIDSY){
        switch(sy){
            case INTSY:
                insym();
                if(sy == ident){
                    enter(token,2,0);
                    printf("%s\n",MTable.Tab[MTable.tabindex].name);
                    insym();
                    if(sy == lparent){
                        parastate();
                        insym();

                        if(sy == lbrace){
                            cpstate();
                           // printf("sy in int func:%d\n",sy);
                            if(sy != rbrace){
                                error(0);printf("defect }\n");
                            }
                        }
                        else {error(0);printf("defect {,program is over\n");}
                    }
                }
                break;
            case CHARSY:
                insym();
                if(sy == ident){
                    enter(token,2,1);
                    insym();
                    if(sy == lparent){
                        parastate();
                        insym();
                        if(sy == lbrace){
                            cpstate();
                           // printf("sy in char func:%d\n",sy);
                            if(sy != rbrace){
                                error(0);printf("defect }\n");
                            }
                        }
                        else {error(0);printf("defect {\n");}
                    }
                }
                break;
            case VOIDSY:
                insym();
                if(sy == ident){
                    enter(token,2,2);
                    insym();
                    if(sy == lparent){
                        parastate();
                        insym();
                        if(sy == lbrace){
                            cpstate();//printf("sy in void func:%d\n",sy);
                            if(sy != rbrace){
                                error(0);printf("defect }\n");
                            }
                        }
                        else {error(0);cpstate();}
                    }
                }
                else if(sy == MAINSY){
                while(sy != lbrace)
                    insym();
                mainstate();}
                break;
            default:
                break;
        }
        insym();
    printf("This is a funktion statement!\n");
    printf("\n");
    }
}
void mainstate(){//主函数说明
    if(sy == lbrace)
    cpstate();
    printf("This is main funktion!\n");
}
void program(){//程序
    insym();
    if(sy == CONSTSY){
        conststate();
        MTable.display[MTable.num]=MTable.tabindex;
        MTable.num++;
    }
    if(sy == INTSY || sy == CHARSY){
        varstate();
        if(funcsym==1){
            funcstate();
            funcsym=0;
        }
        MTable.display[MTable.num]=MTable.tabindex;
        MTable.num++;
        insym();
        //printf("var or fuktion!\n");
    }
    if(sy == VOIDSY){
        insym();
        if(sy == MAINSY){
                while(sy != lbrace)insym();
            mainstate();
        }
        else {
            funcstate();
        }
    }

}
