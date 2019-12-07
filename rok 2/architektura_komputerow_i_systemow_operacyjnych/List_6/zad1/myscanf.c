 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>

 int length(char* str){
    int i = 0;
    while(*str != '\0'){
        str++;
        i++;
    }
    return i;
}

int val(char c) 
{ 
    if (c >= '0' && c <= '9') 
        return (int)c - '0'; 
    else
        return (int)c - 'A' + 10; 
} 

int toDeci(char *str, int base) 
{ 
    int len = length(str); 
    int power = 1; 
    int num = 0;  
    int i; 
  
    for (i = len - 1; i >= 0; i--) 
    { 
        if (val(str[i]) >= base) 
        { 
           printf("Invalid Number"); 
           return -1; 
        } 
  
        num += val(str[i]) * power; 
        power = power * base; 
    } 
  
    return num; 
}

int myReadForBase(int base){
    int d, i = 0;
    char ch;
    char str[100];
    while(read(0, &ch, 1) > 0 && ch != '\n'){
        str[i] = ch;
        i++;
    }
    str[i] = '\0';
    d = toDeci(str, base);
    return d;
}

char* myReadString(){
    int i = 0;
    char ch;
    char* str = malloc(100 * sizeof(char));
    while(read(0, &ch, 1) > 0 && ch != '\n'){
        *(str+i) = ch;
        i++;
    }
    *(str + i ) = '\0';
    return str;
}

 int func (char* a, ...)
 { 
    char *p = (char *) &a + sizeof a;

    while(*a != '\0'){

                printf("wszedlem do case");

        if(*a == '%') {

            a++;
            switch (*a)
            {
            case 'd':
                {
                int* wsk = *((int**)p);
                int d;
                d = myReadForBase(10);
                p += sizeof(int*);

                *wsk = d;
                a++;
                }
                break;

            case 'x':
                {
                int* wsk = *((int**)p);
                int d;
                d = myReadForBase(16);
                p += sizeof(int*);

                *wsk = d;
                a++;
                }
                break;

            case 'b':
                {
                int* wsk = *((int**)p);
                int d;
                d = myReadForBase(2);
                p += sizeof(int*);

                *wsk = d;
                a++;
                }
                break;

            case 's':
                {
                char** wsk = *((char***)p);
                char* d;
                d = myReadString();
                p += sizeof(char**);

                *wsk = d;
                a++;
                }
                break;
            
            default:
                break;
            }
        }
        if(*a == '\0') break;
        a++;
    }

    p = NULL;
 }

 int main(){
    // int hex = toDeci("1A", 16);
    // printf("%d", hex);
    int myint, myhex, mybin;
    char* mystr = malloc(100 * sizeof(char));// = myReadString();
    func("%d, %x, %s", &myint, &myhex, &mystr);
    printf("\nmy: %d, %x, %s\n", myint, myhex, mystr);
    return 0;
 }