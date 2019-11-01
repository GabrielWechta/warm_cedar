package frontend;

import java.awt.CardLayout;
import java.awt.FlowLayout;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class InvoicesGui extends JFrame {

	public InvoicesGui() {
		setSize(400, 150);
		setTitle("Make Your Own Invoice");
		setLocationRelativeTo(null);

		JPanel panel = new JPanel();
		panel.setSize(1000, 900);
		panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));

		addMakeInvoiceButtonToPanel(panel);
		addShowInvoicesButtonToPanel(panel);

		add(panel);
		
		setVisible(true);
	}

	private void addShowInvoicesButtonToPanel(JPanel panel) {
		JButton button = new JButton("Show Invoices");
		button.setSize(200, 100);
		button.addActionListener(e -> {});
		panel.add(button);		
	}

	public void addMakeInvoiceButtonToPanel(JPanel panel) {
		JButton button = new JButton("Make Invoice");
		button.setSize(200, 100);
		button.addActionListener(e -> createInvoiceWindow());
		panel.add(button);
	}

	public void createInvoiceWindow() {
		InvoiceWindow invoiceWindow = new InvoiceWindow();
	}
}
