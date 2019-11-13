package factories;

import elements.ReportBody;
import elements.ReportFooter;
import elements.ReportHeader;
import eu.jpereira.trainings.designpatterns.creational.abstractfactory.json.JSONReportFooter;
import eu.jpereira.trainings.designpatterns.creational.abstractfactory.xml.XMLReportFooter;

public class FooterFactory extends AbstractFactory {
	@Override
	public ReportFooter createFooter(String type) {
		if (type.equalsIgnoreCase("JSON")) {
			return new JSONReportFooter();
		} else if (type.equalsIgnoreCase("XML")) {
			return new XMLReportFooter();
		}

		return null;
	}
	
	@Override
	public ReportBody createBody(String type) {
		return null;
	}
	
	@Override
	public ReportHeader createHeader(String type) {
		return null;
	}
}
