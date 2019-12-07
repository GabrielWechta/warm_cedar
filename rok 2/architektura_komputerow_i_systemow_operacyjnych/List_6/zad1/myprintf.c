 #include <stdio.h>
 #include <unistd.h>

 int length(char* str){
    int i = 0;
    while(*str != '\0'){
        str++;
        i++;
    }
    return i;
}

char *convert(unsigned int num, int base) 
{ 
	static char Representation[]= "0123456789ABCDEF";
	static char buffer[50]; 
	char *ptr; 
	
	ptr = &buffer[49]; 
	*ptr = '\0'; 
	
	do 
	{ 
		*--ptr = Representation[num%base]; 
		num /= base; 
	}while(num != 0); 
	
	return(ptr); 
}

void mywrite(char ch){
    char onechar[2];
    onechar[0] = ch;
    onechar[1] = '\0';

    write(1, onechar, sizeof(char));
}

void mywriteForString(char* str){
     write(1, str, length(str));
}

 int func (char* a, ...)
 { 
    char *p = (char *) &a + sizeof a;

    while(*a != '\0'){
        if(*a == '%') {
            a++;
            switch (*a)
            {
            case 's':
                {
                    char* str = *((char **)p);
                    p += sizeof str;
                    mywriteForString(str);
                    a++;
                }
                break;

            case 'd':
                {
                int d = *((int *)p);
                p += sizeof(int);

                char* str = convert(d, 10);
                mywriteForString(str);
                a++;
                }
                break;
            
            case 'x':
                {
                int d = *((int *)p);
                p += sizeof(int);

                char* str = convert(d, 16);
                mywriteForString(str);
                a++;
                }
                break;

            case 'b':
                {
                int d = *((int *)p);
                p += sizeof(int);

                char* str = convert(d, 2);
                mywriteForString(str);
                a++;
                }
                break;
            
            default:
                break;
            }
        }
        mywrite(*a);
        a++;
    }

    p = NULL;
 }

 int main(){
    func("dlugi jest %s napis i %s ma on %d liter, w hex %x, a w bin %b \n", "tutaj", "kolejny", 44, 44, 44);
    return 0;
 }