package daos;

import java.util.ArrayList;
import java.util.List;

import entities.Element;

public final class ElementDao {
	private static final ElementDao instanceOfELementDao = new ElementDao();

	private ElementDao() {

	}

	public static ElementDao getInstance() {
		return instanceOfELementDao;
	}

	private List<Element> listOfElements = new ArrayList<Element>();
	static private int counter = 1;

	public Element createElement(String nameOfService, int amount, float nettoPrice, float vat) {
		Element element = new Element(nameOfService, amount, nettoPrice, vat);
		element.setId(counter);
		listOfElements.add(element);

		counter++;
		return element;
	}

	public void showElement(int id) {
		Element element = listOfElements.get(id);
		System.out.println(element.getId() + " " + element.getNameOfService());
	}

}
