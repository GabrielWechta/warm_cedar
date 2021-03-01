public class Figury {
	
	enum Pojedyncze {
		OKRAG {
			public int a;
			public void Set(int a) {
				 this.a = a;
			}
			public double Pole() {
				return Math.PI*a*a;
			}
			public double Obwod() {
				return Math.PI*a*2;
			}
			
		},
		PIECIOKAT {
			public int a;
			public void Set(int a) {
				 this.a = a;
			}
			public double Pole() {
				return (Math.sqrt(25+10*Math.sqrt(5))/4)*a*a;
			}
			public double Obwod() {
				return 5*a;
			}
		},
		SZESCIOKAT{
			public int a;
			public void Set(int a) {
				 this.a = a;
			}
			public double Pole() {
				return 3*a*a*Math.sqrt(3)/2;
			}
			public double Obwod() {
				return 6*a;
			}
		},
		KWADRAT{
			public int a;
			public void Set(int a) {
				 this.a = a;
			}
			public double Pole() {
				return a*a;
			}
			public double Obwod() {
				return 4*a;
			}
		};
		
		public abstract void Set(int a);
		public abstract double Obwod();
		public abstract double Pole();
	}
	
	enum Podwojne {
		PROSTOKAT{
			public int a,b;
			public void Set(int a, int b) {
				 this.a = a;
				 this.b = b;
			}
			public double Obwod() {
				return 2*a + 2*b;
			}
			public double Pole() {
				return a*b;
			}
		},
		ROMB{
			public int a;
			public double b;
			public void Set(int a, int b) {
				 this.a = a;
				 this.b = Math.toRadians((double)b);
			}
			public double Pole() {
				return a*a*Math.sin(b);
			}
			public double Obwod() {
				return 4*a;
			}
		};
		
		public abstract void Set(int a, int b);
		public abstract double Obwod();
		public abstract double Pole();
}


public static void main(String[] arg) {
		
		int index = 1;
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
					Pojedyncze o = Pojedyncze.OKRAG;
					o.Set(promien);
					System.out.println("Pole kola = " + o.Pole());
					System.out.println("Obwod kola = " + o.Obwod());
					index = index + 1;
					
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
					Pojedyncze p = Pojedyncze.PIECIOKAT;
					p.Set(bok);
					System.out.println("Pole pieciokata = " + p.Pole());
					System.out.println("Obwod pieciokata = " + p.Obwod());
					index = index + 1;
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
					Pojedyncze s = Pojedyncze.SZESCIOKAT;
					s.Set(bok);
					System.out.println("Pole szesciokata = " + s.Pole());
					System.out.println("Obwod szesciokata = " + s.Obwod());
					index = index + 1;
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
						Podwojne r = Podwojne.ROMB;
						r.Set(bok1, kat);
						System.out.println("Pole rombu = " + r.Pole());
						System.out.println("Obwod rombu = " + r.Obwod());
						index = index + 5;
						
					}
					
					else if(kat == 90 && bok1 == bok2 && bok2 == bok3 && bok3 == bok4) { // KWADRAT
						Pojedyncze k = Pojedyncze.KWADRAT;
						k.Set(bok1);
						System.out.println("Pole kwadratu = " + k.Pole());
						System.out.println("Obwod kwadratu = " + k.Obwod());
						index = index + 5;
					}
					
					else if(kat == 90 && ((bok1 == bok2 && bok3 == bok4) || (bok1 == bok3 && bok2 == bok4) || (bok1 == bok4 && bok2 == bok3))) { // PROSKTOKAT
						if(bok1 == bok2) bok2 = bok3; //TUTAJ MOZE BYC BLAD
						
						Podwojne p = Podwojne.PROSTOKAT;
						p.Set(bok1, bok2);
						System.out.println("Pole prostokata = " + p.Pole());
						System.out.println("Obwod prostokata = " + p.Obwod());
						index = index + 5;
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
