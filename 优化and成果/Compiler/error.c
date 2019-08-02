#include <stdio.h>
#include "error.h"
#include "Lexical.h"
extern FILE *fp;
extern int errorjud;
extern char token[tokensize];
extern int linecout,chcout;
char errormsg[][40]={
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
	"type conflict",
	"const def",
	"ary size",
	"var def",//17
	"para type conflict",
	"unexpect ,",
	"defect (",
	"defect case",
	"illegal caselab",
	"defect :",//23
	"defect {",
	"defect }",
	"defect default",//26
	"para num conflict",
	"defect return",
	"expect ; here",
	"condi expres empty",
	"array index error",
	"source not completion",//32
	"return state conflict",
	"ident multdef",
	"ident cannot be keyword",
	"assign for const",//36
	"condiexp typ conflict",
	"return typ conflict"
};
void error(int k){
    printf("Error:%s in line:%d\n",errormsg[k],linecout+1);
    errorjud=1;
}
