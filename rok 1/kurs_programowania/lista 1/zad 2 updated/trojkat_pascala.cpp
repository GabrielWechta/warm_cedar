#include <iostream>
#include <cstdlib>
#include <string>

using namespace std;

class Trojkat{

public:
    int rzedy;
    int kolumny;
    int tablica[33][33];
    int srodek;

    int wspolczynniki(int m)
    {
        return tablica[rzedy-1][m];
    }

    Trojkat(int n);

    ~Trojkat()
    {
        cout << "Destruktor" <<endl;
    }
};

int main(int argc, char* argv[])
{
    int n = stoi(argv[1]);
    int ile_m = argc-2;

    if( n < 0)
    {
        cout<<" - wprowadzono zle dane: ERROR 501"<<endl;
        exit(1);
    }

    if(ile_m < 0)
    {
        cout<<" - wprowadzono zle dane: ERROR 505"<<endl;
        exit(1);
    }

    int tab[ile_m];


    for(int i = 0; i < ile_m; i++)
    {
        if(stoi(argv[i+2]) > n || stoi(argv[i+2]) < 0)
        {
            cout<<"zla dana"<<endl;
            continue;
        }
        else tab[i] = stoi(argv[i+2]);
    }

    //or(int i = 0; i < ile_m; i++) cout<<tab[i]<<" ";

    Trojkat pierwszy(n);

    for(int i = 0; i < ile_m; i++)
    {
        cout<<tab[i]<<" - "<<pierwszy.wspolczynniki(tab[i])<<endl;;
    }

return 0;
}

Trojkat::Trojkat(int n)
{
	rzedy = n+2;
	kolumny = rzedy;
	for(int i = 0; i < 33; i++)
        {
            for(int j = 0; j < 33; j++)
            {
                tablica[i][j] = 0;
            }
        }

	for(int i = 1; i < rzedy; i++)
	{
	    tablica[i][0] = 1;
            tablica[i][rzedy-1] = 1;
            for(int j = 1; j < rzedy; j++)
            {
                tablica[i][j] = tablica[i-1][j-1] + tablica[i-1][j];
            }
	}
}
