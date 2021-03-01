package entities;

public class Element {

	private int id;
	private String nameOfService;
	private int amount;
	private float nettoPrice;
	private float vat; // maybe enum?
	private float bruttoPrice;
	private int invoice_id;

	public Element() {

	}

	public Element(String nameOfService, int amount, float nettoPrice, float vat) {
		super();
		this.nameOfService = nameOfService;
		this.amount = amount;
		this.nettoPrice = nettoPrice;
		this.vat = vat;
		this.bruttoPrice = calculateBruttoPrice(nettoPrice, vat);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNameOfService() {
		return nameOfService;
	}

	public void setNameOfService(String nameOfService) {
		this.nameOfService = nameOfService;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public float getNettoPrice() {
		return nettoPrice;
	}

	public void setNettoPrice(float nettoPrice) {
		this.nettoPrice = nettoPrice;
	}

	public float getVat() {
		return vat;
	}

	public void setVat(float vat) {
		this.vat = vat;
	}

	public float getBruttoPrice() {
		float twoDigit = Math.round(bruttoPrice * 100) / 100.0f;
		return twoDigit;
	}

	public void setBruttoPrice(float bruttoPrice) {
		this.bruttoPrice = bruttoPrice;
	}

	public float calculateBruttoPrice(float nettoPrice, float vat) {
		this.bruttoPrice = nettoPrice * (vat + 1.0f);
		return this.bruttoPrice;
	}

	public void setInvoiceId(int id) {
		this.invoice_id = id;
	}

	public int getInoiveId() {
		return this.id;
	}
}
