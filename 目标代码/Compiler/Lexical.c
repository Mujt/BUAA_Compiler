#include<stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Lexical.h"
char spsch[specsymsize];
enum reserv ksy[keysize],sps[specsymsize],idcss[4];
int Tokenpoint=0,Strpoint=0;
FILE *fp;
char str[strsize];
char *currchar;//��ǰ�ַ�
extern enum reserv sy;
extern char token[tokensize];
extern int num;
extern int charvalue;
extern int linecout,chcout;

char condistr[condisize][3]={//�������ʽ
    "<=",
    ">=",
    "==",
    "!="
};
char ksystr[keysize][10]={//12��������
    "CASESY   ",
    "CHARSY   ",
    "CONSTSY  ",
    "IFSY     ",
    "INTSY    ",
    "MAINSY   ",
    "PRINTSY  ",
    "RETURNSY ",
    "SCANFSY  ",
    "SWITCHSY ",
    "VOIDSY   ",
    "WHILESY  ",
    "DEFAULTSY"
};
char key[keysize][11]={/*���ڴʷ��������,�����ڲ��ұ����ֱ�*/
    "case",
    "char",
    "const",
    "if",
    "int",
    "main",
    "printf",
    "return",
    "scanf",
    "switch",
    "void",
    "while",
    "default"
};
char idchss[4][10]={/*���ڴʷ��������*/
    "ident    ",
    "charcon  ",
    "stringcon",
    "ints     "
};
char specss[specsymsize][10]={/*���ڴʷ��������*/
    "andsy    ",
    "doubquota",
    "semicolon",
    "comma    ",
    "colon    ",
    "lbrace   ",
    "rbrace   ",
    "lparent  ",
    "rparent  ",
    "lbrack   ",
    "rbrack   ",
    "pluss    ",
    "minuss   ",
    "times    ",
    "idiv     ",
    "eqlsy    ",
    "less     ",
    "gree     ",
    "quotat   ",
    "leq      ",
    "geq      ",
    "eql      ",
    "uneql    "
};
int isSpace(){
    return *currchar==' ';
}
int isNewline(){
    return *currchar=='\n';
}
int isTab(){
    return *currchar=='\t';
}

int isLetter(){
    return ((*currchar>='a'&&*currchar<='z')||(*currchar>='A'&&*currchar<='Z')||(*currchar=='_'));
}
int isDigit(){
    return (*currchar>='0'&&*currchar<='9');
}
int isLetinstr(){//�����ж��ַ����з����Ƿ�Ϸ�
    return ((*currchar==' ') || (*currchar=='!')||(*currchar>='#' && *currchar<='~'));
}
int isSYm(){
    return ((*currchar=='+')||(*currchar=='-')||(*currchar=='*')||(*currchar=='/')||isLetter()||isDigit());
}

void setinial(){
    ksy[0]=CASESY;
    ksy[1]=CHARSY;
    ksy[2]=CONSTSY;
    ksy[3]=IFSY;
    ksy[4]=INTSY;
    ksy[5]=MAINSY;
    ksy[6]=PRINTSY;
    ksy[7]=RETURNSY;
    ksy[8]=SCANFSY;
    ksy[9]=SWITCHSY;
    ksy[10]=VOIDSY;
    ksy[11]=WHILESY;
    ksy[12]=DEFAULTSY;

    idcss[0]=ident;
    idcss[1]=charcon;
    idcss[2]=stringcon;
    idcss[3]=ints;

    sps[0]=andsy;    spsch[0]='!';
    sps[1]=doubquota;spsch[1]='"';
    sps[2]=semicolon;spsch[2]=';';
    sps[3]=comma;    spsch[3]=',';
    sps[4]=colon;    spsch[4]=':';
    sps[5]=lbrace;   spsch[5]='{';
    sps[6]=rbrace;   spsch[6]='}';
    sps[7]=lparent;  spsch[7]='(';
    sps[8]=rparent;  spsch[8]=')';
    sps[9]=lbrack;   spsch[9]='[';
    sps[10]=rbrack;  spsch[10]=']';
    sps[11]=pluss;   spsch[11]='+';
    sps[12]=minuss;  spsch[12]='-';
    sps[13]=times;   spsch[13]='*';
    sps[14]=idiv;    spsch[14]='/';
    sps[15]=eqlsy;   spsch[15]='=';
    sps[16]=lesss;    spsch[16]='<';
    sps[17]=gree;    spsch[17]='>';
    sps[18]=quotat;  spsch[18]='\'';
    sps[19]=leq;//'<='
    sps[20]=geq;//'>='
    sps[21]=eql;//'=='
    sps[22]=uneql;//'!='
}
void nextch(){//����һ���ַ�
    char ch=fgetc(fp);
    if(ch == '\n'){
        linecout=linecout+1;
        chcout=0;
    }
    chcout=chcout+1;
    currchar = &ch;
    return;
}
void retract(){//���ַ�ָ�����һ��
    fseek(fp,-1,SEEK_CUR);
    return;
}
void clearToken(){//���token����
    int i=0;
    for(i=0;i<Tokenpoint;i++){
        token[i]='\0';
    }
    Tokenpoint=0;
}
void clearString(){//���str����
    int i=0;
    for(i=0;i<Strpoint;i++){
        str[i]='\0';
    }
    Strpoint=0;
}
void addtoken(){//�ѵ�ǰ�������ַ���token����
    char ssk=*currchar;
    if(Tokenpoint==0)
        token[0]=ssk;
    else
        token[Tokenpoint]=ssk;
    Tokenpoint=Tokenpoint+1;
    return;
}
void addstring(){//����ǰ�������ַ���str����
    char ssk=*currchar;
    if(Strpoint==0)
        str[0]=ssk;
    else
        str[Strpoint]=ssk;
    Strpoint=Strpoint+1;
    return;
}
/*void print_table(){//��ӡ�ʷ�����������ѽ��д���ļ�
    if(sy>=1 && sy<=12){
        printf("%s %s\n",ksystr[sy-1],key[sy-1]);
        fputs(ksystr[sy-1],out);
        fprintf(out," ");
        fputs(key[sy-1],out);
        fprintf(out,"\n");
    }
    else if(sy>=13 && sy<=14){
        printf("%s %s\n",idchss[sy-13],token);
        fputs(idchss[sy-13],out);
        fprintf(out," ");
        fputs(token,out);
        fprintf(out,"\n");
    }
    else if(sy==15){
        printf("%s %s\n",idchss[2],str);
        fputs(idchss[2],out);
        fprintf(out," ");
        fputs(str,out);
        fprintf(out,"\n");
        clearString();
    }
    else if(sy==16){
        printf("%s %d\n",idchss[3],num);
        fputs(idchss[3],out);
        fprintf(out," ");
        fputs(token,out);
        fprintf(out,"\n");
    }
    else if(sy>=17 && sy<=35){
        printf("%s %c\n",specss[sy-17],spsch[sy-17]);
        fputs(specss[sy-17],out);
        fprintf(out," ");
        fputc(spsch[sy-17],out);
        fprintf(out,"\n");
    }
    else if(sy>=36 && sy<=39){
        printf("%s %s\n",specss[sy-17],condistr[sy-36]);
        fputs(specss[sy-17],out);
        fprintf(out," ");
        fputs(condistr[sy-36],out);
        fprintf(out,"\n");
    }
    else if(sy == 40 ){//default
        printf("%s %s\n",ksystr[12],key[12]);
        fputs(ksystr[12],out);
        fprintf(out," ");
        fputs(key[12],out);
        fprintf(out,"\n");
    }
}
void error(int k){//��ӡ������Ϣ���Ѵ�����Ϣд���ļ�
    switch(k){
    case 1:
        printf("Error:%d identifier definition wrong\n",k);
        fputs("Error:%d identifier definition wrong\n",out);
        fprintf(out,"\n");
        break;
    case 2:
        printf("Error:%d cannot distinguish symbol\n",k);
        fputs("Error:%d cannot distinguish symbol\n",out);
        fprintf(out,"\n");
        break;
    case 3:
        printf("Error:%d string is too long\n",k);
        fputs("Error:%d string is too long\n",out);
        fprintf(out,"\n");
        break;
    case 4:
        printf("Error:%d cannot distinguish symbol\n",k);
        fputs("Error:%d cannot distinguish symbol\n",out);
        fprintf(out,"\n");
        break;
    case 5:
        printf("Error:%d '!' cannot match with '='\n",k);
        fputs("Error:%d '!' cannot match with '='\n",out);
        fprintf(out,"\n");
        break;
    case 6:
        printf("Error:%d character's length is wrong\n",k);
        fputs("Error:%d character's length is wrong\n",out);
        fprintf(out,"\n");
        break;
    }
}*/
int transNUM(){//�����ִ�ת��Ϊ����
    char (*k)[Tokenpoint]=&token;
    return atoi(*k);
}
void insym(){//������
    int i=0;
    clearToken();
    nextch();
    while(isSpace()||isNewline()||isTab()){
        nextch();
    }
    if(isLetter()){//�����ʶ��
        while(isLetter()||isDigit())
           {addtoken();nextch();}
        retract();
        int symbol=0;
        char (*s)[10]=&token;
        for(i=0;i<keysize;i++){//���ұ�����
            if(!strcmp(*s,key[i])){symbol=1;break;}
        }
        if(symbol==1){sy=ksy[i];}
        else sy=ident;
    }
    else if(isDigit()){//�������ִ�
        while(isDigit()){addtoken();nextch();}
        if(isLetter()){//�������֮�������ĸ�������Ǳ�ʶ����������
            error(1);
        }
        else {
            retract();
            num=transNUM();
            sy=ints;
        }
    }
    else {
        switch(*currchar){
        case '!':
            nextch();
            if(*currchar=='=')
                sy=uneql;
            else {error(5);retract();}
            break;
        case '"':{
            nextch();
            i=0;
            while(*currchar!='"'){//�ַ���
                if(!isLetinstr()){error(4);break;}
                addstring();
                i=i+1;
                nextch();
            }
            if(i<100)
                sy=stringcon;
            else//�ַ�������
                error(3);
            break;
        }
        case ';':
            sy=semicolon;
            break;
        case ',':
            sy=comma;
            break;
        case ':':
            sy=colon;
            break;
        case '{':
            sy=lbrace;
            break;
        case '}':
            sy=rbrace;
            break;
        case '(':
            sy=lparent;
            break;
        case ')':
            sy=rparent;
            break;
        case '[':
            sy=lbrack;
            break;
        case ']':
            sy=rbrack;
            break;
        case '+':
            sy=pluss;
            break;
        case '-':
            sy=minuss;
            break;
        case '*':
            sy=times;
            break;
        case '/':
            sy=idiv;
            break;
        case '=':
            nextch();
            if(*currchar=='=')
                sy=eql;
            else {retract();sy=eqlsy;}
            break;
        case '<':
            nextch();
            if(*currchar=='=')
                sy=leq;
            else {retract();sy=lesss;}
            break;
        case '>':
            nextch();
            if(*currchar=='=')
                sy=geq;
            else {retract();sy=gree;}
            break;
        case '\'':{
            nextch();
            i=0;
            int iserro=0;
            if(*currchar!='\'')
                while(*currchar!='\''){
                if(!isSYm()){iserro=1;break;}
                addtoken();
                nextch();
                i++;
                }
            if(i==1 && iserro==0)
                  {sy=charcon;charvalue=token[0];}
            else if(i==0 || iserro==1)//''
                error(4);
            else
                error(6);//'acd'
            break;
        }
        default:
            if(feof(fp))break;
            error(2);//�޷�ʶ���ַ�
        }
    }
}
