package eu.jpereira.trainings.designpatterns.creational.builder;

import java.util.Iterator;

import eu.jpereira.trainings.designpatterns.creational.builder.model.Report;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SaleEntry;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SoldItem;

public class XMLReportBuilder implements ReportBuilder {

	private Report report;

	public XMLReportBuilder() {
		this.report = new Report();
	}

	@Override
	public void setSaleEntry(SaleEntry saleEntry) {
		this.report.setSaleEntry(saleEntry);
	}
	
	@Override
	public Report getReport() {
		StringBuilder stringBuilder = report.getStringBuilder();
		SaleEntry saleEntry = report.getSaleEntry();
		
		stringBuilder.append("<sale><customer><name>");
		stringBuilder.append(saleEntry.getCustomer().getName());
		stringBuilder.append("</name><phone>");
		stringBuilder.append(saleEntry.getCustomer().getPhone());
		stringBuilder.append("</phone></customer>");
		
		stringBuilder.append("<items>");
		
		Iterator<SoldItem> it = saleEntry.getSoldItems().iterator();
		while ( it.hasNext() ) {
			SoldItem soldEntry= it.next();
			stringBuilder.append("<item><name>");
			stringBuilder.append(soldEntry.getName());
			stringBuilder.append("</name><quantity>");
			stringBuilder.append(soldEntry.getQuantity());
			stringBuilder.append("</quantity><price>");
			stringBuilder.append(soldEntry.getUnitPrice());
			stringBuilder.append("</price></item>");
		}
		stringBuilder.append("</items></sale>");

		return this.report;
	}
}
