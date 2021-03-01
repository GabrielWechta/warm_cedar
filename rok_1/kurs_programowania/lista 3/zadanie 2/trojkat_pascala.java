
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

class ButtonBehave implements ActionListener {
	MyFrame f;
	ButtonBehave(MyFrame f) {
		this.f = f;
	}
	public void actionPerformed(ActionEvent arg0) {
		int n = 0;
		n = Integer.parseInt(f.textfield.getText());
		f.action(n);
	}
}
class Trojkat {
	String wiersz(int n) {
		String strumien = "";
		int rzedy = n + 1;
		int kolumny = rzedy;
		int trojkat[][] = new int[rzedy][kolumny];
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
		for(int i = 0; i< n; i++ )
		{
			strumien = "";
			for(int j = 0; j < i+1; j++)
			{
				String str = Integer.toString(trojkat[i][j]);
				strumien = strumien + " " + str;
			}
			
		}
		return strumien;
	}
}
class MyFrame extends JFrame {
	JLabel[] tab_lab;
	JButton button;
	JTextField textfield;
	Panel panel1, panel2;
	ScrollPane scrollpane;
	Trojkat trojkat = new Trojkat();
	
	MyFrame() {
		
		super("Okno Pascala");
		button = new JButton("Przekaz moc");
		button.addActionListener(new ButtonBehave(this));
		textfield = new JTextField();
		panel1 = new Panel();
		panel1.setLayout(new GridLayout(1,2));
		panel1.add(button);
		panel1.add(textfield);
		panel2 = new Panel();
		panel2.setLayout(new BoxLayout(panel2, BoxLayout.PAGE_AXIS));
		setLayout(new GridLayout(2,1));
		add(panel1);
		scrollpane = new ScrollPane();
		scrollpane.add(panel2);
		add(panel2);
		add(scrollpane);
		setVisible(true);
		setSize(700,600);
		
	}
	public void action(int n) {
		panel2.removeAll();
		int c = 0;
		int l = 0;
		String longest = trojkat.wiersz(n);
		l = longest.length();
		for(int i = 0; i <= n; i++) {
			System.out.println(trojkat.wiersz(i));
			JLabel pierwsza_proba = new JLabel();
			String strumien = trojkat.wiersz(i);
			c = strumien.length();
			
			for(int j = 0; j < (l - c)/2 ; j++)
			{
				strumien = " " + strumien;
			}
			pierwsza_proba.setText(strumien);
			panel2.add(pierwsza_proba);
		}
		
		panel2.repaint();
		panel2.revalidate();
		pack();
	}
	
	
}
public class trojkat_pascala {
	
	public static void main(String[] arg) {
		MyFrame frame = new MyFrame();
		
	}
}
