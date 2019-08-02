#ifndef MID_H
#define MID_H

enum mid{
    asseql=1,//=
    assary,//[]=
    consts,//const
    intsign,//int
    charsign,//char
    setsign,
    callsign,
    labsign,
    funcsign,
    parsign=10,
    endfsign,
    gresign,//>=
    uneqsign, // !=
    eqlsign,//==
    leesign,//<=
    gretsign,//>
    lesign,//<
    jnesign,
    jmpsign,
    retsign=20,
    scafsign,
    prtfsign,
    aassign,
    plusign,
    minusign,//25
    timesign,
    divsign,
    strsign,
    blansign,//29
};
typedef struct{
    int midop;
    char src1[50];
    char src2[50];
    char res[100];
}MIDC;
typedef struct{
    MIDC Midcod[10000];
    int midcodeptr;
}MID_T;

typedef struct{
    int casedes;
    char casename[5];
}caseT1;
typedef struct{
    caseT1 casens[10];
    int caseptr;
}caseT2;
typedef struct{
    caseT2 sw[20];
    int swptr;
}caseT3;


char lab[25];
char varn[10];
caseT3 caseTab;
MID_T midtab;


int ifnum,whilenum,switchnum,varnum,stringnum,casenum;
void emit(int opx);
void gejcase(int k,int defsy,char endswi[]);
char *genlab(int sww);
char *genvar();
void genstr(int k);

void print_midcode();
#endif // MID_H
