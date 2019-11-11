package eu.jpereira.trainings.designpatterns.creational.builder;

import eu.jpereira.trainings.designpatterns.creational.builder.model.Report;
import eu.jpereira.trainings.designpatterns.creational.builder.model.SaleEntry;

public interface ReportBuilder {
	public Report getReport();
	public void setSaleEntry(SaleEntry saleEntry);
}
