package daos;

import java.util.ArrayList;
import java.util.List;

import entities.Element;
import entities.Invoice;

public final class InvoiceDao {
	private static final InvoiceDao InstanceOfInvoiceDao = new InvoiceDao();

	private List<Invoice> listOfInvoices = new ArrayList<Invoice>();
	static private int counter = 1;

	private InvoiceDao() {

	}

	public static InvoiceDao getInstance() {
		return InstanceOfInvoiceDao;
	}

	public Invoice createInvoice(String date, String seller, String buyer) {
		Invoice invoice = new Invoice(date, seller, buyer);
		invoice.setId(counter);
		listOfInvoices.add(invoice);

		counter++;
		return invoice;
	}

	public void showInvoice(int id) {
		Invoice invoice = listOfInvoices.get(id);
		System.out.println(invoice.getId() + " : " + invoice.getSeller() + " : " + invoice.getBuyer());
		invoice.describeListOfElements();

	}

	public void addElementToInvoice(int id, Element element) {
		listOfInvoices.get(id).addElement(element);
	}

}
