package eu.jpereira.trainings.designpatterns.creational.builder;

import java.util.Iterator;

import eu.jpereira.trainings.designpatterns.creational.builder.model.Report;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SaleEntry;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SoldItem;

public class JSONReportBuilder implements ReportBuilder {

	private Report report;

	public JSONReportBuilder() {
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
		
		stringBuilder.append("sale:{customer:{");
		stringBuilder.append("name:\"");
		stringBuilder.append(saleEntry.getCustomer().getName());
		stringBuilder.append("\",phone:\"");
		stringBuilder.append(saleEntry.getCustomer().getPhone());
		stringBuilder.append("\"}");
		stringBuilder.append(",items:[");
		Iterator<SoldItem> it = saleEntry.getSoldItems().iterator();
		while (it.hasNext()) {
			SoldItem item = it.next();
			stringBuilder.append("{name:\"");
			stringBuilder.append(item.getName());
			stringBuilder.append("\",quantity:");
			stringBuilder.append(String.valueOf(item.getQuantity()));
			stringBuilder.append(",price:");
			stringBuilder.append(String.valueOf(item.getUnitPrice()));
			stringBuilder.append("}");
			if (it.hasNext()) {
				stringBuilder.append(",");
			}

		}
		stringBuilder.append("]}");

		return this.report;
	}
}
