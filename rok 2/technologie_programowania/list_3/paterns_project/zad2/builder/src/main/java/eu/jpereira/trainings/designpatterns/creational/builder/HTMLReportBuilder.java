package eu.jpereira.trainings.designpatterns.creational.builder;

import java.util.Iterator;

import eu.jpereira.trainings.designpatterns.creational.builder.model.Report;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SaleEntry;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SoldItem;

public class HTMLReportBuilder implements ReportBuilder {
	private Report report;

	public HTMLReportBuilder() {
		this.report = new Report();
	}

	@Override
	public void setSaleEntry(SaleEntry saleEntry) {
		this.report.setSaleEntry(saleEntry);
	}

	@Override
	public Report getReport() {
		report.getStringBuilder().append("<span class=\"customerName\">");
		report.getStringBuilder().append(this.report.getSaleEntry().getCustomer().getName());
		report.getStringBuilder().append("</span><span class=\"customerPhone\">");
		report.getStringBuilder().append(this.report.getSaleEntry().getCustomer().getPhone());
		report.getStringBuilder().append("</span>");
		
		report.getStringBuilder().append("<items>");
		
		Iterator<SoldItem> it = this.report.getSaleEntry().getSoldItems().iterator();
		while ( it.hasNext() ) {
			SoldItem soldEntry= it.next();
			report.getStringBuilder().append("<item><name>");
			report.getStringBuilder().append(soldEntry.getName());
			report.getStringBuilder().append("</name><quantity>");
			report.getStringBuilder().append(soldEntry.getQuantity());
			report.getStringBuilder().append("</quantity><price>");
			report.getStringBuilder().append(soldEntry.getUnitPrice());
			report.getStringBuilder().append("</price></item>");
		}
		report.getStringBuilder().append("</items>");

	return report;
	}
}
