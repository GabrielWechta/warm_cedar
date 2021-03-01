package factories;

import elements.ReportBody;
import elements.ReportFooter;
import elements.ReportHeader;
import eu.jpereira.trainings.designpatterns.creational.abstractfactory.json.JSONReportBody;
import eu.jpereira.trainings.designpatterns.creational.abstractfactory.xml.XMLReportBody;

public class BodyFactory extends AbstractFactory{
	@Override
	public ReportBody createBody(String type) {
		if (type.equalsIgnoreCase("JSON")) {
			return new JSONReportBody();
		} else if (type.equalsIgnoreCase("XML")) {
			return new XMLReportBody();
		}

		return null;
	}
	
	@Override
	public ReportFooter createFooter(String type) {
		return null;
	}
	
	@Override
	public ReportHeader createHeader(String type) {
		return null;
	}
}
