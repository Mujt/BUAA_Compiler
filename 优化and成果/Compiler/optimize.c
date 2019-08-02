#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "optimize.h"
#include "midcode.h"
#include "syn.h"
extern MID_T midtab;

extern Nodenet nodes[100];
extern Nodetab nodelist[100];
char bl[50];
int ptr1=0,ptr2=0;
char out_line[100][50];
int outnode[100];
char in_line[50][50];
int outptr=0;
int inptr=0;
char nodesmy[100][50];
int nodesjud[100];


int loc_node(char name[]){
    int i=0,jud=0;
    for(;i<ptr2;i++){
        if(strcmp(nodelist[i].sym,name)==0){
            jud=1;
            break;
        }
    }
    if(jud==1)return i;
    else return -1;
}
int loc_net(char op[],int rig,int lef){
    int i=0,jud=0;
    for(;i<ptr1;i++){
        if(strcmp(nodes[i].sym,op)==0 && rig == nodes[i].right_node && lef == nodes[i].left_node)
        {
           jud=1;
           break;
        }
    }
    if(jud==1)return i;
    else return -1;
}
void cleanodes(){
    int i,j;
    for(i=0;i<ptr1;i++){
        strcpy(nodes[i].sym,bl);
        nodes[i].left_node=0;
        nodes[i].right_node=0;
    }
    for(j=0;j<ptr2;j++){
        strcpy(nodelist[j].sym,bl);
        nodelist[j].node=0;
    }
    for(i=0;i<inptr;i++){
        for(j=0;j<50;j++)
        in_line[i][j]='\0';
    }
    for(i=0;i<outptr;i++){
        for(j=0;j<50;j++)
        out_line[i][j]='\0';
    }
    for(i=0;i<ptr1;i++){
        for(j=0;j<50;j++)
        nodesmy[i][j]='\0';
    }
    for(i=0;i<ptr1;i++){
        nodesjud[i]=0;
    }
    ptr1=0;
    ptr2=0;
    inptr=0;
    outptr=0;
}
int get_listnet(int adr1){
    cleanodes();
    //printf("clean!\n");
    int ops=0,i=adr1;
    int a,b,c,d;
    ops=midtab.Midcod[i].midop;
    while(ops==1 || (ops>=24 && ops<=27)){
           // printf("%d\n",ops);
        if(ops==1){
            int sa;
            a=loc_node(midtab.Midcod[i].src1);
            b=loc_node(midtab.Midcod[i].res);
            if(a==-1){
                strcpy(nodelist[ptr2].sym,midtab.Midcod[i].src1);
                nodelist[ptr2].node=ptr1;
                sa=ptr1;
                strcpy(nodes[ptr1].sym,midtab.Midcod[i].src1);
                nodes[ptr1].right_node=-1;
                nodes[ptr1].left_node=-1;
                strcpy(nodesmy[ptr1],midtab.Midcod[i].src1);
                ptr1=ptr1+1;
                ptr2=ptr2+1;
                strcpy(in_line[inptr],midtab.Midcod[i].src1);
                inptr=inptr+1;
                if(b==-1){
                    strcpy(nodelist[ptr2].sym,midtab.Midcod[i].res);
                    nodelist[ptr2].node=sa;
                    ptr2=ptr2+1;
                }
                else{
                    nodelist[b].node=sa;
                    nodelist[b].als=1;
                }
            }else{
                if(b==-1){
                    strcpy(nodelist[ptr2].sym,midtab.Midcod[i].res);
                    nodelist[ptr2].node=nodelist[a].node;
                    ptr2=ptr2+1;
                }
                else{
                    nodelist[b].node=nodelist[a].node;
                    nodelist[b].als=1;
                }
            }
            i=i+1;
        }else if(ops>=24 && ops<=27){
            int sa;
            a=loc_node(midtab.Midcod[i].src1);
            b=loc_node(midtab.Midcod[i].src2);
            c=loc_node(midtab.Midcod[i].res);
            if(a==-1){
                strcpy(nodelist[ptr2].sym,midtab.Midcod[i].src1);
                nodelist[ptr2].node=ptr1;
                nodelist[ptr2].als=0;
                a=ptr2;
                strcpy(nodes[ptr1].sym,midtab.Midcod[i].src1);
                nodes[ptr1].right_node=-1;
                nodes[ptr1].left_node=-1;
                strcpy(nodesmy[ptr1],midtab.Midcod[i].src1);
                ptr1=ptr1+1;
                ptr2=ptr2+1;
                strcpy(in_line[inptr],midtab.Midcod[i].src1);
                inptr=inptr+1;
            }
            if(b==-1){
                strcpy(nodelist[ptr2].sym,midtab.Midcod[i].src2);
                nodelist[ptr2].node=ptr1;
                nodelist[ptr2].als=0;
                b=ptr2;
                strcpy(nodes[ptr1].sym,midtab.Midcod[i].src2);
                nodes[ptr1].right_node=-1;
                nodes[ptr1].left_node=-1;
                strcpy(nodesmy[ptr1],midtab.Midcod[i].src2);
                ptr1=ptr1+1;
                ptr2=ptr2+1;
                strcpy(in_line[inptr],midtab.Midcod[i].src2);
                inptr=inptr+1;
            }
            switch(ops){
                case 24://+
                    d=loc_net("+",a,b);
                    if(d==-1){
                        strcpy(nodes[ptr1].sym,"+");
                        nodes[ptr1].mm=24;
                        nodes[ptr1].right_node=nodelist[a].node;
                        nodes[ptr1].left_node=nodelist[b].node;
                        sa=ptr1;
                        ptr1=ptr1+1;
                    }else{
                        sa=d;
                    }
                    break;
                case 25://-
                    d=loc_net("-",a,b);
                    if(d==-1){
                        strcpy(nodes[ptr1].sym,"-");
                        nodes[ptr1].mm=25;
                        nodes[ptr1].right_node=nodelist[a].node;
                        nodes[ptr1].left_node=nodelist[b].node;
                        sa=ptr1;
                        ptr1=ptr1+1;
                    }else{
                        sa=d;
                    }
                    break;
                case 26://*
                    d=loc_net("*",a,b);
                    if(d==-1){
                        strcpy(nodes[ptr1].sym,"*");
                        nodes[ptr1].mm=26;
                        nodes[ptr1].right_node=nodelist[a].node;
                        nodes[ptr1].left_node=nodelist[b].node;
                        sa=ptr1;
                        ptr1=ptr1+1;
                    }else{
                        sa=d;
                    }
                    break;
                case 27://³ý
                    d=loc_net("/",a,b);
                    if(d==-1){
                        strcpy(nodes[ptr1].sym,"/");
                        nodes[ptr1].mm=27;
                        nodes[ptr1].right_node=nodelist[a].node;
                        nodes[ptr1].left_node=nodelist[b].node;
                        sa=ptr1;
                        ptr1=ptr1+1;
                    }else{
                        sa=d;
                    }
                    break;
            }
            if(c==-1){
                strcpy(nodelist[ptr2].sym,midtab.Midcod[i].res);
                nodelist[ptr2].node=sa;
                ptr2=ptr2+1;
                if(d==-1)strcpy(nodesmy[ptr1-1],midtab.Midcod[i].res);
            }else{
                nodelist[c].node=sa;
                nodelist[c].als=1;
                if(d==-1)strcpy(nodesmy[ptr1-1],midtab.Midcod[i].res);
            }
            i=i+1;
        }

        ops=midtab.Midcod[i].midop;
        a=0;b=0;c=0;d=0;
    }

    /*
    int j=0;
    printf("%d %d %d %d %d\n",ptr1,ptr2,inptr,outptr,i);
    for(;j<ptr2;j++){
        printf("%s %d %d\n",nodelist[j].sym,nodelist[j].node,nodelist[j].als);
    }

    printf("**********\n");

    for(j=0;j<ptr1;j++){
         printf("%d %s %d %d\n",j,nodes[j].sym,nodes[j].right_node,nodes[j].left_node);
    }
     printf("**********\n");
     for(j=0;j<inptr;j++){
            printf("%s\n",in_line[j]);
    }*/


    int mi,mj=0,mk=0;
    int jud=0,mptr=0;
    mptr=adr1;
   // printf("%d\n",mptr);
    for(mk=0;mk<ptr1;mk++){//nodes
            //printf("mk:%d\n",mk);
        for(mi=0;mi<ptr2;mi++){//nodelist
           // printf("node mk: %d %d\n",nodelist[mi].node,mk);
            if(nodelist[mi].node==mk){
        for(mj=0;mj<inptr;mj++){
            if(strcmp(in_line[mj],nodelist[mi].sym)==0){
                jud=1;break;
                }
            }
            //printf("jud:%d\n",jud);
            if(jud==0){
                if(nodes[nodelist[mi].node].right_node==-1 && nodes[nodelist[mi].node].left_node==-1){
                    midtab.Midcod[mptr].midop=1;
                    strcpy(midtab.Midcod[mptr].src1,nodesmy[nodelist[mi].node]);
                    strcpy(midtab.Midcod[mptr].src2," ");
                    strcpy(midtab.Midcod[mptr].res,nodelist[mi].sym);
                    strcpy(out_line[outptr],nodelist[mi].sym);
                    nodesjud[nodelist[mi].node]=1;
                    strcpy(nodesmy[nodelist[mi].node],midtab.Midcod[mptr].res);
                    outnode[outptr]=nodelist[mi].node;
                    outptr=outptr+1;
                    mptr=mptr+1;
                }else if(nodesjud[nodelist[mi].node]==0){
                midtab.Midcod[mptr].midop=nodes[nodelist[mi].node].mm;
                strcpy(midtab.Midcod[mptr].res,nodelist[mi].sym);
                strcpy(midtab.Midcod[mptr].src1,nodesmy[nodes[nodelist[mi].node].right_node]);
                strcpy(midtab.Midcod[mptr].src2,nodesmy[nodes[nodelist[mi].node].left_node]);
                strcpy(nodesmy[nodelist[mi].node],midtab.Midcod[mptr].res);
                nodesjud[nodelist[mi].node]=1;
                strcpy(out_line[outptr],nodelist[mi].sym);
                outnode[outptr]=nodelist[mi].node;
                outptr=outptr+1;
                mptr=mptr+1;
                }else if(nodesjud[nodelist[mi].node]==1){
                    midtab.Midcod[mptr].midop=1;
                    strcpy(midtab.Midcod[mptr].src1,nodesmy[nodelist[mi].node]);
                    strcpy(midtab.Midcod[mptr].src2," ");
                    strcpy(midtab.Midcod[mptr].res,nodelist[mi].sym);
                    strcpy(nodesmy[nodelist[mi].node],midtab.Midcod[mptr].res);
                    strcpy(out_line[outptr],nodelist[mi].sym);
                    nodesjud[nodelist[mi].node]=1;
                    outnode[outptr]=nodelist[mi].node;
                    outptr=outptr+1;
                    mptr=mptr+1;
                }
            }else jud=0;

        }

        }//if mk
    }

    /*printf("**********\n");
    for(j=0;j<outptr;j++){

          printf("%s\n", out_line[j]);
    }*/



    for(mi=0;mi<inptr&&mptr<i;mi++){
        for(mj=0;mj<ptr2;mj++){
            if(strcmp(nodelist[mj].sym,in_line[mi])==0){
                if(nodelist[mj].als==1){
                    midtab.Midcod[mptr].midop=1;
                    strcpy(midtab.Midcod[mptr].src1,nodesmy[nodelist[mj].node]);
                    strcpy(midtab.Midcod[mptr].src2," ");
                    strcpy(midtab.Midcod[mptr].res,nodelist[mj].sym);
                    mptr=mptr+1;
                }
            }
        }
    }

    while(mptr<i){
        midtab.Midcod[mptr].midop=29;
        strcpy(midtab.Midcod[mptr].res,"  ");
        strcpy(midtab.Midcod[mptr].src1,"  ");
        strcpy(midtab.Midcod[mptr].src2,"  ");
        mptr=mptr+1;
    }/*
    for(j=adr1;j<i;j++){
        printf("%d %s %s %s\n",midtab.Midcod[j].midop,midtab.Midcod[j].src1,midtab.Midcod[j].src2,midtab.Midcod[j].res);
    }
    printf("********************************************\n");
    */
    int j,ii;
    char ress[50],srcc[50];
    for(j=adr1;j<i-1;j++){
           // printf("%d\n",midtab.Midcod[j].midop);
        if(midtab.Midcod[j].midop==1 && (strcmp(midtab.Midcod[j].res,midtab.Midcod[j+1].src1)==0||strcmp(midtab.Midcod[j].res,midtab.Midcod[j+1].src2)==0)){
                strcpy(ress,midtab.Midcod[j].res);
                 strcpy(srcc,midtab.Midcod[j].src1);
                for(ii=j+1;ii<i&&strcmp(ress,midtab.Midcod[ii].res)!=0;ii++){
            if(strcmp(ress,midtab.Midcod[ii].src1)==0)
                {strcpy(midtab.Midcod[ii].src1,srcc);}
            else if(strcmp(ress,midtab.Midcod[ii].src2)==0)
                {strcpy(midtab.Midcod[ii].src2,srcc);}

            }
            //printf("%d\n",midtab.Midcod[j].midop);
            if(jud_tt(midtab.Midcod[j].res)==1 && ii==i){
            midtab.Midcod[j].midop=29;
            strcpy(midtab.Midcod[j].res,"  ");
            strcpy(midtab.Midcod[j].src1,"  ");
            strcpy(midtab.Midcod[j].src2,"  ");
            }
        }
    }
    /*
    for(j=adr1;j<i;j++){
        printf("%d %s %s %s\n",midtab.Midcod[j].midop,midtab.Midcod[j].src1,midtab.Midcod[j].src2,midtab.Midcod[j].res);
    }
    printf("********************************************\n");*/
    return i;
}
int jud_tt(char name[]){
    int i=1;
    int jud=0;
    for(;name[i]!='\0';i++){
        if(name[i]<'0' || name[i]>'9'){
            jud=1;break;
        }
    }
    int re=0;
    if(name[0]=='t'){
        if(jud==0)re=1;
    }
    return re;
}
void del_pubexp(){
    int i=0;
    int ops;
    while(i<midtab.midcodeptr){
        ops=midtab.Midcod[i].midop;
        //printf("********\n");
        if(ops>=24 && ops<=27){
             i = get_listnet(i);
             //break;
        }
        i=i+1;
    }
    //printf("*****************************11111111111111111111111111111111");
}
