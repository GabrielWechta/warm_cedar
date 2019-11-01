package entities;

import java.util.ArrayList;
import java.util.List;

public class Invoice {

	private int id;
	private String date;
	private String seller;	
	private String buyer; // in future Client

	private List<Element> listOfElements = new ArrayList<Element>();

	public Invoice() {
	}

	public Invoice(String date, String seller, String buyer) {
		super();
		this.date = date;
		this.seller = seller;
		this.buyer = buyer;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getSeller() {
		return seller;
	}

	public void setSeller(String seller) {
		this.seller = seller;
	}

	public String getBuyer() {
		return buyer;
	}

	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}

	public List<Element> getListOfElements() {
		return listOfElements;
	}

	public void setListOfElements(List<Element> listOfElements) {
		this.listOfElements = listOfElements;
	}

	public void addElement(Element element) {
		element.setInvoiceId(this.id);
		this.listOfElements.add(element);
	}

	public void describeListOfElements() { // grasp mocno
		for (Element e : listOfElements) {
			System.out.println(
					"\t" + e.getId() + " " + e.getNameOfService() + " " + e.getNettoPrice() + " " + e.getBruttoPrice());
		}
	}

}
