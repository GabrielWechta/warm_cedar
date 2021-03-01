
interface Wlasnosci_figur{
	public double obwod();
	public double pole();
}

abstract class Figura implements Wlasnosci_figur{}

abstract class Czworokat extends Figura{}

class Kolo extends Figura{
	int promien;
	
	Kolo(int promien) {
		this.promien = promien;
	}
	
	public double pole() {
		return promien*promien*Math.PI;
	}
	public double obwod() {
		return 2*Math.PI*promien;
	}
}

class Pieciokat extends Figura{
	int bok;
	
	public Pieciokat(int bok) {
		this.bok = bok;
	}
	
	public double pole() {
		return (Math.sqrt(25+10*Math.sqrt(5))/4)*bok*bok;
	}
	public double obwod() {
		return 5*bok;
	}
}

class Szesciokat extends Figura{
	int bok;
	
	Szesciokat(int bok) {
		this.bok = bok;
	}
	public double pole() {
		return 3*bok*bok*Math.sqrt(3)/2;
	}
	public double obwod() {
		return 6*bok;
	}
}

class Kwadrat extends Czworokat{
	int bok;
	
	Kwadrat(int bok) {
		this.bok = bok;
	}
	public double pole() {
		return bok*bok;
	}
	public double obwod() {
		return 4*bok;
	}
}

class Prostokat extends Czworokat{
	int bok_a, bok_b;
	
	Prostokat(int a, int b) {
		bok_a = a;
		bok_b = b;
	}
	public double obwod() {
		return 2*bok_a + 2*bok_b;
	}
	public double pole() {
		return bok_a*bok_b;
	}
}

class Romb extends Czworokat{
	int bok;
	double kat;
	
	Romb(int bok, double kat_d) {
		this.bok = bok;
		this.kat = Math.toRadians(kat_d);
	}
	
	public double pole() {
		return bok*bok*Math.sin(kat);
	}
	public double obwod() {
		return 4*bok;
	}
}

public class zadanie_1_klasa {
	public static void main(String[] arg) {
		
		int index = 1;
		int index_tablicy = 0;
		Figura[] tablica = new Figura[arg[0].length()];
		for(int i = 0; i < arg[0].length(); i++) {
			
			switch(arg[0].charAt(i)) {
			
				case 'o': //GDY KOLO
				{
					int promien = 1;
					try {
						promien = Integer.parseInt(arg[index]);
					} catch (NumberFormatException e) {
						e.printStackTrace();
						index = index + 1;
						continue;
					}
					Figura kolo = new Kolo(promien);
					System.out.println("Pole kola = " + kolo.pole());
					System.out.println("Obwod kola = " + kolo.obwod());
					index = index + 1;
					tablica[index_tablicy] = kolo;
					index_tablicy = index_tablicy + 1;
					break;
					
				}
				case 'p':  //GDY PIECIOKAT
				{
					int bok = 1;
					try {
						bok = Integer.parseInt(arg[index]);
					} catch (NumberFormatException e) {
						e.printStackTrace();
						index = index + 1;
						continue;
					} 
					Figura pieciokat = new Pieciokat(bok);
					System.out.println("Pole pieciokata = " + pieciokat.pole());
					System.out.println("Obwod pieciokata = " + pieciokat.obwod());
					index = index + 1;
					tablica[index_tablicy] = pieciokat;
					index_tablicy = index_tablicy + 1;
					break;
				}
				case 's': //GDY SZESCIOKAT
				{
					int bok = 1;
					try {
						bok = Integer.parseInt(arg[index]);
					} catch (NumberFormatException e) {
						e.printStackTrace();
						index = index + 1;
						continue;
					} 
					Figura szesciokat = new Szesciokat(bok);
					System.out.println("Pole szesciokata = " + szesciokat.pole());
					System.out.println("Obwod szesciokata = " + szesciokat.obwod());
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
					try {
						bok1 = Integer.parseInt(arg[index]);
						bok2 = Integer.parseInt(arg[index+1]);
						bok3 = Integer.parseInt(arg[index+2]);
						bok4 = Integer.parseInt(arg[index+3]);
						kat = Integer.parseInt(arg[index+4]);
					} catch (NumberFormatException e) {
						e.printStackTrace();
						index = index + 5;
						continue;
					}
					
					if(kat > 360 || kat < 0)
					{
						System.out.println("kat nie zwiera sie w (0,360) nie wiem jak to interpretowac (mowi program)");
						index = index + 5;
						continue;
					}
					//System.out.println(kat);
					
					if(kat != 90 && bok1 == bok2 && bok2 == bok3 && bok3 == bok4) { // ROMB
						Figura romb = new Romb(bok1,kat);
						System.out.println("Pole rombu = " + romb.pole());
						System.out.println("Obwod rombu = " + romb.obwod());
						index = index + 5;
						tablica[index_tablicy] = romb;
						index_tablicy = index_tablicy + 1;
						
					}
					
					else if(kat == 90 && bok1 == bok2 && bok2 == bok3 && bok3 == bok4) { // KWADRAT
						Figura kwadrat = new Kwadrat(bok1);
						System.out.println("Pole kwadratu = " + kwadrat.pole());
						System.out.println("Obwod kwadratu = " + kwadrat.obwod());
						index = index + 5;
						tablica[index_tablicy] = kwadrat;
						index_tablicy = index_tablicy + 1;
					}
					
					else if(kat == 90 && ((bok1 == bok2 && bok3 == bok4) || (bok1 == bok3 && bok2 == bok4) || (bok1 == bok4 && bok2 == bok3))) { // PROSKTOKAT
						if(bok1 == bok2) bok2 = bok3; //TUTAJ MOZE BYC BLAD
						
						Figura prostokat = new Prostokat(bok1, bok2);
						System.out.println("Pole prostokata = " + prostokat.pole());
						System.out.println("Obwod prostokata = " + prostokat.obwod());
						index = index + 5;
						tablica[index_tablicy] = prostokat;
						index_tablicy = index_tablicy + 1;
					}
		
					else {
						System.out.println("Tego czworokata nie obslugujemy :(");
						index = index + 5;
					}
					
					break;
				}
				
				default:
				{
					System.out.println("Cos poszlo nie tak> Wystapil blad w wpisywanych danych, dostepne figury do policzenia to o, c, p, s");
				}
			}
		}
	}
}
