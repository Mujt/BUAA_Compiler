#ifndef OPT_H
#define OPT_H

typedef struct{
    char sym[50];
    int mm;
    int right_node;
    int left_node;
}Nodenet;//DAGͼ
typedef struct{
    char sym[50];
    int node;
    int als;//�Ƿ����
}Nodetab;//�Ż���

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
