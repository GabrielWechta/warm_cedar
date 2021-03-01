package invoiceApp_simpler;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import entities.Element;
import entities.Invoice;

public class TestInvoice {
	Invoice invoice;

	@Before
	public void init() {
		invoice = new Invoice();
		invoice.addElement(new Element("a", 1, 2.03f, 0.3f));
	}

	@Test
	public void testDescribing() {
		Assert.assertTrue("a" == invoice.getListOfElements().get(0).getNameOfService());
		Assert.assertTrue(1 == invoice.getListOfElements().get(0).getAmount());
		Assert.assertTrue(2.03f == invoice.getListOfElements().get(0).getNettoPrice());
		Assert.assertTrue(0.3f == invoice.getListOfElements().get(0).getVat());
	}
	
	@Test
	public void testAdding() {
		invoice.addElement(new Element("b", 1, 2.03f, 0.3f));
		invoice.addElement(new Element("c", 1, 2.03f, 0.3f));
		invoice.addElement(new Element("d", 1, 2.03f, 0.3f));
		invoice.addElement(new Element("e", 1, 2.03f, 0.3f));
		
		Assert.assertTrue(5 == invoice.getListOfElements().size());
	}
}
