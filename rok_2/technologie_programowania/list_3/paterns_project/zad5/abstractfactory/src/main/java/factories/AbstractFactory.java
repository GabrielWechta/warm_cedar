package factories;

import elements.ReportBody;
import elements.ReportFooter;
import elements.ReportHeader;

public abstract class AbstractFactory {
	public abstract ReportHeader createHeader(String type);
	public abstract ReportBody createBody(String type);
	public abstract ReportFooter createFooter(String type);
}
