#ifndef LEX_H_
#define LEX_H_
#define keysize 13 //������13��
#define tokensize 10 //��ŵ�ǰ����token�����С
#define strsize 100 //���ַ��������С
#define specsymsize 23 //������ű��С
#define condisize 4 //��������
enum reserv{
    CASESY=1,
    CHARSY,
    CONSTSY,
    IFSY,
    INTSY,
    MAINSY,
    PRINTSY,
    RETURNSY,
    SCANFSY,
    SWITCHSY,
    VOIDSY,
    WHILESY,

    ident=13,
    charcon,
    stringcon,
    ints,

    andsy=17, //'!'
    doubquota, //'"'
    semicolon,//';'
    comma,//','
    colon,//':'
    lbrace,//'{'
    rbrace,//'}'
    lparent,//'('
    rparent,//')'
    lbrack=26,//'['
    rbrack,//']'
    pluss,//'+'
    minuss,//'-'
    times,//'*'
    idiv,//'/'
    eqlsy,//'='
    lesss=33,
    gree,//'>'
    quotat,
    leq,
    geq,
    eql,
    uneql,

    DEFAULTSY=40
};

enum reserv sy;
char token[tokensize];
int num;
int charvalue;

int isSpace();
int isNewline();
int isTab();
int isLetter();
int isDigit();
int isLetinstr();
int isSYm();
void setinial();
void nextch();
void retract();
void clearToken();
void clearString();
void addtoken();
void addstring();
//void print_table();
//void error(int k);
int transNUM();
void insym();
#endif
