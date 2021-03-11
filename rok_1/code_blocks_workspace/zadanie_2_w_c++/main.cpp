#include <iostream>
#include <cmath>
#include <string>
using namespace std;
#define PI 3.14159265
//BASE CLASS
class Figura {
    public:
    virtual double pole() = 0;
    virtual double obwod() = 0;
};

//2nd BASE CLASS
class Czworokat : public Figura {
};

//DERIVED CLASSES
class Okrag : public Figura {
    public:
    double pole(){
    return promien * promien * PI;
    }

    double obwod(){
    return 2*PI*promien;
    }

    Okrag(int pro){ //konstruktor
    promien = pro;
    }
    ~Okrag(){cout<<"Okrag zostal usuniety"<<endl;} //destruktor

    private:
    int promien;
};

class Pieciokat : public Figura {
    public:
    double pole(){
    return (sqrt(25+10*sqrt(5))/4)*bok*bok;
    }

    double obwod(){
    return 5*bok;
    }

    Pieciokat(int bo){ //konstruktor
    bok = bo;
    }
    ~Pieciokat(){cout<<"Pieciokat zostal usuniety"<<endl;} //destruktor

    private:
    int bok;
};

class Szesciokat : public Figura {
    public:
    double pole(){
    return 3*bok*bok*sqrt(3)/2;
    }

    double obwod(){
    return 6*bok;
    }

    Szesciokat(int bo){ //konstruktor
    bok = bo;
    }
    ~Szesciokat(){cout<<"Szesciokat zostal usuniety"<<endl;} //destruktor

    private:
    int bok;
};

//CLASSES DERIVING FROM CZWOROKAT
class Kwadrat : public Czworokat {
    public:
    double pole(){
    return bok*bok;
    }

    double obwod(){
    return 4*bok;
    }

    Kwadrat(int bo){
    bok = bo;
    }
    ~Kwadrat(){cout<<"Kwadrat zostal usuniety"<<endl;}
    private:
    int bok;
};

class Prostokat : public Czworokat {
    public:
    double pole(){
    return bok1*bok2;
    }

    double obwod(){
    return 2*bok1 + 2*bok2;
    }

    Prostokat(int bo1, int bo2){
    bok1 = bo1;
    bok2 = bo2;
    }
    ~Prostokat(){cout<<"Prostokat zostal usuniety"<<endl;}
    private:
    int bok1;
    int bok2;
};

class Romb : public Czworokat {
    public:
    double pole(){
    return bok*bok*sin(kat);
    }

    double obwod(){
    return 4*bok;
    }

    Romb(int bo, double ka){
    bok = bo;
    kat = ka*PI/180;
    }
    ~Romb(){cout<<"Romb zostal usuniety"<<endl;}
    private:
    int bok;
    double kat;
};



int main(int argc, char* argv[])
{

    int index = 2;
    int index_tablicy = 0;
    Figura* tablica[argc - 1];
    string polecenie = argv[1];
    cout<<polecenie<<endl;
    int length = polecenie.length();
    cout<<length<<endl;

    //if(argc - 2 != length) cout<<"Wprowadzono zła ilosc wymiarow"
    for(int i = 0; i < length; i++)
    {
        switch(argv[1][i])
        {

				case 'o': //GDY KOLO
				{
					int promien = 1;
					try
					{
						promien = stoi(argv[index]);
					}
					catch (invalid_argument e)
					{
						//e.printStackTrace();
						cout<<endl<<"Blad! zly argument"<<endl;
						index = index + 1;
						continue;
					}

					Okrag* okrag = new Okrag(promien);
					cout<<"Pole okregu = " << okrag->pole()<<endl;
					cout<<"Obwod okregu = " << okrag->obwod()<<endl;
					index++;
					tablica[index_tablicy] = okrag;
					index_tablicy = index_tablicy + 1;
					break;
                }

                case 'p':  //GDY PIECIOKAT
				{
					int bok = 1;
					try
					{
						bok = stoi(argv[index]);
					}
					catch (invalid_argument e)
					{
                        cout<<endl<<"Blad! zly argument"<<endl;
						index = index + 1;
						continue;
					}
					Pieciokat* pieciokat = new Pieciokat(bok);
					cout<<"Pole pieciokata = " << pieciokat->pole()<<endl;
					cout<<"Obwod pieciokata = " << pieciokat->obwod()<<endl;
					index = index + 1;
					tablica[index_tablicy] = pieciokat;
					index_tablicy = index_tablicy + 1;
					break;
				}
				case 's': //GDY SZESCIOKAT
				{
					int bok = 1;
					try
					{
						bok = stoi(argv[index]);
					}
					catch (invalid_argument e)
					{
						cout<<endl<<"Blad! zly argument"<<endl;
						index = index + 1;
						continue;
					}
					Figura* szesciokat = new Szesciokat(bok);
					cout<<"Pole szesciokata = " << szesciokat->pole()<<endl;
					cout<<"Obwod szesciokata = " << szesciokat->obwod()<<endl;
					index = index + 1;
					tablica[index_tablicy] = szesciokat;
					index_tablicy = index_tablicy + 1;
					break;
				}

				case 'c': //GDY CZWOROKAT
				{
					int bok1 = 1;
					int bok2 = 1;
					int bok3 = 1;
					int bok4 = 1;
					int kat = 1;
					try
					{
						bok1 = stoi(argv[index]);
						bok2 = stoi(argv[index+1]);
						bok3 = stoi(argv[index+2]);
						bok4 = stoi(argv[index+3]);
						kat = stoi(argv[index+4]);
					}
					catch (invalid_argument e)
					{
						cout<<endl<<"Blad! zly argument"<<endl;
						index = index + 5;
						continue;
					}

					if(kat > 360 || kat < 0)
					{
						cout<<"Kat nie zwiera sie w (0,360) nie wiem jak to interpretowac (mowi program)"<<endl;
						index = index + 5;
						continue;
					}
					//cout<<kat);

					if(kat != 90 && bok1 == bok2 && bok2 == bok3 && bok3 == bok4)
					{ // ROMB
						Figura* romb = new Romb(bok1,kat);
						cout<<"Pole rombu = " << romb->pole()<<endl;
						cout<<"Obwod rombu = " << romb->obwod()<<endl;
						index = index + 5;
						tablica[index_tablicy] = romb;
						index_tablicy = index_tablicy + 1;

					}

					else if(kat == 90 && bok1 == bok2 && bok2 == bok3 && bok3 == bok4)
					{ // KWADRAT
						Kwadrat* kwadrat = new Kwadrat(bok1);
						cout<<"Pole kwadratu = " << kwadrat->pole()<<endl;
						cout<<"Obwod kwadratu = " << kwadrat->obwod()<<endl;
						index = index + 5;
						tablica[index_tablicy] = kwadrat;
						index_tablicy = index_tablicy + 1;
					}

					else if(kat == 90 && ((bok1 == bok2 && bok3 == bok4) || (bok1 == bok3 && bok2 == bok4) || (bok1 == bok4 && bok2 == bok3)))
					{ // PROSKTOKAT
						if(bok1 == bok2) bok2 = bok3; //TUTAJ MOZE BYC BLAD

						Prostokat* prostokat = new Prostokat(bok1, bok2);
						cout<<"Pole prostokata = " << prostokat->pole()<<endl;
						cout<<"Obwod prostokata = " << prostokat->obwod()<<endl;
						index = index + 5;
						tablica[index_tablicy] = prostokat;
						index_tablicy = index_tablicy + 1;
					}

					else
					{
						cout<<"Tego czworokata nie obslugujemy :("<<endl;
						index = index + 5;
					}

                    break;
                }
                default:
                {
                cout<<"zly znak, niestety nie obslugujemy go"<<endl;
                index++;
                break;
                }
            }
        }

        for(int i = 0; i < index_tablicy; i++) ///usuwanie tablicy
        {
        delete[] tablica[i];
        }

return 0;
}
