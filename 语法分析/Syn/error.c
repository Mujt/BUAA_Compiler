#include <stdio.h>
#include "error.h"
#include "Lexical.h"
extern FILE *fp;
extern char token[tokensize];
void error(int k){

    switch(k){
    case 0:printf("Error:%s\n",token);break;
    case 1:
        printf("Error:%d identifier definition wrong\n",k);
        break;
    case 2:
        printf("Error:%d cannot distinguish symbol\n",k);
        break;
    case 3:
        printf("Error:%d string is too long\n",k);
        break;
    case 4:
        printf("Error:%d cannot distinguish symbol\n",k);
        break;
    case 5:
        printf("Error:%d '!' cannot match with '='\n",k);
        break;
    case 6:
        printf("Error:%d character's length is wrong\n",k);
        break;
    }
}
