#include <stdio.h>
#include <stdlib.h>
//========================================
// We use an array to represent 2x2 matrix
// Q[0][0] <-> Q[0] , Q[0][1] <-> Q[1]
// Q[1][0] <-> Q[2] , Q[1][1] <-> Q[3]
//========================================

int Q1[4] = {1, 1, 1, 0};       //  Constant matrix Q1

int* mmul(int* m1, int* m2){
//========================================
//    **mmul implemented for you**
// Please use arrays to represent matrices
// You can use this function as follows:
// int* C = mmul(A, B), to calculate C = AB
// where A, B, C are 2 by 2 matrices
//========================================
    int* r = (int*)malloc(sizeof(int) * 4);
    r[0] = m1[0] * m2[0] + m1[1] * m2[2];
    r[1] = m1[0] * m2[1] + m1[1] * m2[3];
    r[2] = m1[2] * m2[0] + m1[3] * m2[2];
    r[3] = m1[2] * m2[1] + m1[3] * m2[3];
    return r;
}

int main(){
    //===================================
    // Sample program demonstrating
    // how to determine Q3 with mmul
    // =================================
    int* Q2 = mmul(Q1, Q1);
    int* Q3 = mmul(Q1, Q2);
    printf("Q3 = \n");
    printf("%d %d\n", Q3[0], Q3[1]);
    printf("%d %d\n", Q3[2], Q3[3]);
    return 0;
}
