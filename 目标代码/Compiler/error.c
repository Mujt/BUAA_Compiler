#include <stdio.h>
#include "error.h"
#include "Lexical.h"
extern FILE *fp;
extern char token[tokensize];
extern int linecout,chcout;
char errormsg[][20]={
    "defect mainfun",
	"ident def",
	"illegal char",
	"string too long",
	"string def",
	"!= def",
	"char def",
	"undef id",//7
	"defect [",
	"defect ]",
	"defect )",
	"defect =",//11
	"defect ,",
	"defect ;",
	"asig typ",
	"const def",
	"ary size",
	"var def",//17
	"para",
	"unexpect ,",
	"defect (",
	"defect case",
	"illegal caselab",
	"defect :",//23
	"defect {",
	"defect }",
	"defect default",//26
	"too few para",
	"defect return",
};
void error(int k){
    printf("Error:%s in line:%d\n",errormsg[k],linecout);
}
