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
    minusign,
    timesign,
    divsign,
    strsign
};
typedef struct{
    int midop;
    char src1[10];
    char src2[10];
    char res[100];
}MIDC;
typedef struct{
    MIDC Midcod[2000];
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

typedef struct{
    char charn[10];
    char chvl[4];
}CH;
char lab[15];
char varn[10];
caseT3 caseTab;
MID_T midtab;
CH charlist[1000];
int ifnum,whilenum,switchnum,varnum,stringnum;
void emit(int opx);
void gejcase(int k);
char *genlab(int sww);
char *genvar();
void genstr(int k);

void print_midcode();
#endif // MID_H
