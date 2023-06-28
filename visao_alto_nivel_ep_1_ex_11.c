#include <stdio.h>
#include "visao_alto_nivel_ep_1_ex_11.h"

long valor(int i, long* F, long* G){
    (*F) = valorF(i);
    (*G) = valorG(i);
}

long valorG(long i) {
    if(i < 1)
        return 0;
    if(i == 1)
        return 1;
    if(i == 2)
        return 2;
    long G = valorG(i - 1);
    long F = valorF(i - 2);
    return (G + 3*F);
}

long valorF(long i) {
    if(i < 1)
        return 0;
    if(i == 1)
        return 2;
    if(i == 2)
        return 1;
    long F = valorF(i - 1);
    long G = valorG(i - 2);
    return (2*F + G);
}

int main() {
    long i = 5;
    long F;
    long G;
    valor(i, &F, &G);
    printf("Item B: F(%d): %d; G(%d): %d;\n", i, F, i, G);

    // o numero resultante de F(n+200) e G(n+200) é maior que o limite suportado pela linguagem C
    // o limite da linguagem se encontra entre F(33) e F(43)
    /*long F1 = valorF(i-2);
    long F2 = valorF(i+200);
    long G1 = valorG(i-2);
    long G2 = valorG(i+200);
    long R1 = F1 + G2;
    long R2 = F2 - G1;
    printf("Item C: Para n = %d; R1 = %d; R2 = %d\n", i, R1, R2);*/
}
