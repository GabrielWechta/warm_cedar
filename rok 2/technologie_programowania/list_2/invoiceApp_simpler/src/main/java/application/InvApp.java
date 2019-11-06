package application;

import daos.ElementDao;
import daos.InvoiceDao;
import frontend.InvoicesGui;

public class InvApp {

	public static void main(String[] args) {
		
		InvoicesGui invoicesGui = new InvoicesGui();
		
		ElementDao elementDao = ElementDao.getInstance();
		InvoiceDao invoiceDao = InvoiceDao.getInstance();
		
		invoiceDao.createInvoice("31-10-2019", "Norma", "Agent Dale Cooper");
		invoiceDao.addElementToInvoice(0, elementDao.createElement("cherry pie", 3, 2.50f, 0.23f));
		invoiceDao.addElementToInvoice(0, elementDao.createElement("black coffee", 1, 1.50f, 0.23f));
		invoiceDao.addElementToInvoice(0, elementDao.createElement("damn good coffee", 1, 2.50f, 0.23f));
		invoiceDao.addElementToInvoice(0, elementDao.createElement("chesses", 5, 5.00f, 0.23f));
		invoiceDao.addElementToInvoice(0, elementDao.createElement("american rifle", 3, 100.00f, 0.0f));
		
		invoiceDao.createInvoice("1-11-2019", "Norma", "Nadine and Ed");
		invoiceDao.addElementToInvoice(1, elementDao.createElement("milkshake and coffee", 1, 4.99f, 0.23f));
		
		invoiceDao.createInvoice("7-11-2019", "Norma", "Gordon Cole");
		invoiceDao.addElementToInvoice(2, elementDao.createElement("full meal", 2, 20.99f, 0.23f));
		invoiceDao.addElementToInvoice(2, elementDao.createElement("coffe", 2, 1.99f, 0.23f));


	}

}