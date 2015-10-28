#include<stdio.h>
int fac_ite(int n){
    if( n == 0 )
        return 1;
    int i;
    for(i = n-1; i > 1; i--)   
        n = n * i; 
    return n;
}
int main(){
    int n, fac;
    scanf("%d", &n);
    fac = fac_ite(n);
    printf("%d\n",fac);
    return 0;
}
