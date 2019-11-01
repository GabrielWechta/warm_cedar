package application;

import daos.ElementDao;
import daos.InvoiceDao;

public class InvApp {

	public static void main(String[] args) {
		
		//InvoicesGui invoicesGui = new InvoicesGui();
		
		ElementDao elementDao = ElementDao.getInstance();
		InvoiceDao invoiceDao = InvoiceDao.getInstance();
		
		invoiceDao.createInvoice("31-10-2019", "Norma", "Agent Dale Cooper");
		invoiceDao.addElementToInvoice(0, elementDao.createElement("cherry pie", 3, 2.50f, 0.23f));
		invoiceDao.addElementToInvoice(0, elementDao.createElement("black coffee", 1, 1.50f, 0.23f));
		invoiceDao.addElementToInvoice(0, elementDao.createElement("damn good coffee", 1, 2.50f, 0.23f));
		invoiceDao.addElementToInvoice(0, elementDao.createElement("chesses", 5, 5.00f, 0.23f));
		invoiceDao.addElementToInvoice(0, elementDao.createElement("american rifle", 3, 100.00f, 0.0f));
		invoiceDao.showInvoice(0);
		
		invoiceDao.createInvoice("1-11-2019", "Norma", "Nadine and Ed");
		invoiceDao.addElementToInvoice(1, elementDao.createElement("milkshake and coffee", 1, 4.99f, 0.23f));
		invoiceDao.showInvoice(1);

	}

}