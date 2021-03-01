package invoiceApp_simpler;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import entities.Element;

public class TestElement {
	
	Element element;
	
	@Before
	public void init() {
		element = new Element();
	}
	@Test
	public void calculatingBruttoPriceTest() {
		Assert.assertTrue(0.0f == element.calculateBruttoPrice(0.0f, 0.23f));
		Assert.assertTrue(0.0f == element.calculateBruttoPrice(0.0f, 0.0f));
		Assert.assertTrue(20.0f == element.calculateBruttoPrice(20.0f, 0.0f));
	}

	@Test
	public void getBruttoPriceTest() {
		element.calculateBruttoPrice(0.0f, 0.23f);
		Assert.assertTrue(0.0f == element.getBruttoPrice());
		element.calculateBruttoPrice(0.0f, 0.0f);
		Assert.assertTrue(0.0f == element.getBruttoPrice());
		element.calculateBruttoPrice(20.0f, 0.0f);
		Assert.assertTrue(20.00f == element.getBruttoPrice());
	}
}
