import java.util.Arrays;

public class WierszTrojkataPascala
{
	public int rzedy;
	public int kolumny;
	public int [][] trojkat;

	public WierszTrojkataPascala(int n)
	{
		rzedy = n + 1;
		kolumny = rzedy;
		trojkat = new int[rzedy][kolumny];
		trojkat[0][0] = 1;
		for(int i = 1; i < rzedy; i++)
		{
			trojkat[i][0] = 1;
            		trojkat[i][rzedy-1] = 1;
            		for(int j = 1; j < rzedy; j++)
            		{
                		trojkat[i][j] = trojkat[i-1][j-1] + trojkat[i-1][j];
           		}
		}

		for (int[] tab1 : trojkat) 
		{
            	System.out.println(Arrays.toString(tab1));
        	}
	}	
	
	public int wspolczynniki(int m)
	{
		return trojkat[rzedy-1][m]; 
	}
	
}

