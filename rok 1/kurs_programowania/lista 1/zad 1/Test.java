import java.util.Arrays;
import java.lang.*;

public class Test
{
	public static void main(String[] args)
	{
		int n = 0;

		try 
		{ 
			n=Integer.parseInt(args[0]); 
		}
		catch (NumberFormatException ex) 
		{
			System.out.println(args[0] + " zla dana");
			System.exit(0);
		}
		
		if(n < 0)
		{
			System.out.println(n + " jest mniejsze od zera");
			System.exit(0);
		}
		
		if(n > 33)
		{
			System.out.println(n + " niestety dla tej liczby wyznaczniki sa zbyt duze");
			System.exit(0);
		}

		WierszTrojkataPascala chyba = new WierszTrojkataPascala(n);
		for(int i = 1; i < args.length; i++)
		{	
			int m = 0;
			try 
			{ 
				m=Integer.parseInt(args[i]); 
			}
			catch (NumberFormatException ex) 
			{
				System.out.println(args[i] + " - zla dana");
				continue;
			}
			
			if(m < 0 || m > n)
			{
				System.out.println(args[i] + " - liczba poza zakresem");
			}	
			else System.out.println(args[i] + " - " + chyba.wspolczynniki(m));
		
		}
		
	}
}
