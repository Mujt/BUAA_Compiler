#ifndef OPT_H
#define OPT_H

typedef struct{
    char sym[50];
    int mm;
    int right_node;
    int left_node;
}Nodenet;//DAG图
typedef struct{
    char sym[50];
    int node;
    int als;//是否更改
}Nodetab;//优化表

Nodenet nodes[100];
Nodetab nodelist[100];

int loc_node(char name[]);
int loc_net(char op[],int rig,int lef);
void cleanodes();
int get_listnet(int adr1);
int jud_tt(char name[]);
void del_pubexp();
void regs_bet();
#endif
