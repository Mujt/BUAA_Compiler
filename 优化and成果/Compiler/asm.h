#ifndef ASM_H
#define ASM_H

typedef struct{//data段
    char dataname[50];//名
    int datatyp;//类型
    char datavalue[150];//值
}datan;
typedef struct{
    datan dataone[500];
    int dataptr;//data段长度
}datatab;
/*typedef struct{
    char fu_n[10];
    int begin_des;
    int end_des;
}fu_stack;*/
datatab DATB;
void emitdata(char n[],int typsy,char v[]);
void data();
void stak_sub(int des);
int isNum(char inn[],int *Num);
int isC(char n[]);
int setpar(int k,int des);
void ret(int k,int des);
void prtf_de(int k, int des);
void scaf_de(int k, int des);
void deal_opera(int ik,int des,int opsy);
int deal_con(int ik,int des,int opsy);
int deal_state(int ik,int des);
int find_data(char n[]);
int tab_des(char cn[],int des);
void run();
void deal_asary(int k,int des);
void deal_asseq(int ik,int des);
void deal_aas(int ik,int des);
#endif // ASM_H
