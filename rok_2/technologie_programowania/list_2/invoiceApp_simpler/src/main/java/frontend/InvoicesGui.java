package frontend;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.FlowLayout;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextArea;

import daos.InvoiceDao;

public class InvoicesGui extends JFrame {
    int invoice_id = -1;

	public InvoicesGui() {
		
		InvoiceDao invoiceDao = InvoiceDao.getInstance();
		
		setSize(400, 150);
		setTitle("Make Your Own Invoice");
		setLocationRelativeTo(null);

		JPanel panel = new JPanel();
		panel.setSize(1000, 900);
		panel.setLayout(new FlowLayout());
	    JButton showButton = new JButton("show invoices");
	    
	    JTextArea inputAre = new JTextArea();
	    
	    try {
		    showButton.addActionListener(e -> {
				String input = inputAre.getText();
		    	invoice_id = Integer.parseInt(input);
		    	invoiceDao.showInvoice(invoice_id);});
		} catch (NumberFormatException e1) {
			System.out.println("wrong id format, type again");
		}
	    
	    panel.add(inputAre);
	    panel.add(showButton);
		add(panel);
		
		setVisible(true);
	}
}
