public class dzielniki_javove {
	public static void main(String[] args) {
		for(int i = 0; i < args.length; i++)
			{
			int n = 0;
			try { n = Integer.parseInt(args[i]); }
			catch (NumberFormatException ex) {
				System.out.println(args[i] + " nie jest liczba calkowita"); 
				continue;}
			int odpowiedz = div(n);
			System.out.println(odpowiedz);
			}
	}
	public static int div(int n) {
			if(n < 0) n = -n;
			int dzielnik;
			for(dzielnik = n - 1; dzielnik > 1; dzielnik--) 
			{
				if(n%dzielnik == 0) return dzielnik;
			}
		return 1;
	}
}
		
