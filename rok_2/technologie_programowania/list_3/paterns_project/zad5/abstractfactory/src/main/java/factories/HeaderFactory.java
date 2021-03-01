package factories;

import elements.ReportBody;
import elements.ReportFooter;
import elements.ReportHeader;
import eu.jpereira.trainings.designpatterns.creational.abstractfactory.json.JSONReportHeader;
import eu.jpereira.trainings.designpatterns.creational.abstractfactory.xml.XMLReportHeader;

public class HeaderFactory extends AbstractFactory {
	@Override
	public ReportHeader createHeader(String type) {
		if (type.equalsIgnoreCase("JSON")) {
			return new JSONReportHeader();
		} else if (type.equalsIgnoreCase("XML")) {
			return new XMLReportHeader();
		}

		return null;
	}

	@Override
	public ReportBody createBody(String type) {
		return null;
	}

	@Override
	public ReportFooter createFooter(String type) {
		return null;
	}
}
