
import java.io.*;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class Exec extends JFrame implements ActionListener {
	JButton myButton = new JButton();
	JTextField myTextField = new JTextField(4);
	JLabel myLabelField = new JLabel("", 10);

	static int n = 0;
	public static void main(String[] arg) {
		Exec frame = new Exec();
	}
	
	public Exec() {
		//setLayout(new FlowLayout());
		
		setBounds(400,400,1000,600);
		setTitle("Trojkat Pascala Ciagniety z c++");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLayout(new FlowLayout(FlowLayout.LEFT));

		add(myButton);
		myButton.setIcon(new ImageIcon("/home/gabriel/Desktop/icon.png"));
		validate();
		myButton.addActionListener(this);
		myButton.setPreferredSize(new Dimension(225,225));
		
		myTextField.setFont(new Font(Font.SANS_SERIF,Font.PLAIN,40));
		add(myTextField);
		
		myLabelField.setFont(new Font(Font.SANS_SERIF,Font.PLAIN,30));
		add(myLabelField);
		
		pack();
		setVisible(true);
	}
	
	public void actionPerformed(ActionEvent e) {
		
		if(e.getSource() == myButton) {
			
				String strumien = new String("");
				String liczba_s = Integer.toString(n);
				try {
					Process child = Runtime.getRuntime().exec("./trojkat_pascala_executive " + myTextField.getText());
					InputStream in = child.getInputStream();
					int c;
					while((c = in.read()) != -1) 
					{
						String str = Character.toString(c);
						strumien = strumien + str;
					}
						System.out.println(strumien);
						
					in.close();
					}
					catch(IOException e_io) {pack();}
				
				//myLabelField.setText(strumien);
				pack();
				//myLabelField.setMinimumSize(myLabelField.getSize());
		}
	}

}
