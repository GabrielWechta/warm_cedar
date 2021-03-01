/**
 * Copyright 2011 Joao Miguel Pereira
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package eu.jpereira.trainings.designpatterns.creational.abstractfactory;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import elements.ReportBody;
import elements.ReportElement;
import elements.ReportFooter;
import elements.ReportHeader;
import factories.AbstractFactory;
import factories.FactoryProvider;

/**
 * @author jpereira
 * 
 */

public class ReportTest {

	@Test
	public void testCreateJSONReport() {

		Report report = new Report();

		AbstractFactory headerFactory = FactoryProvider.getFactory("Header");
		ReportHeader reportHeader = headerFactory.createHeader("JSON");

		AbstractFactory bodyFactory = FactoryProvider.getFactory("Body");
		ReportBody reportBody = bodyFactory.createBody("JSON");

		AbstractFactory footerFactory = FactoryProvider.getFactory("Footer");
		ReportFooter reportFooter = footerFactory.createFooter("JSON");

		report.setHeader(reportHeader);
		report.setBody(reportBody);
		report.setFooter(reportFooter);

		assertEquals("JSON", report.getBody().getType());
		assertEquals("JSON", report.getHeader().getType());
		assertEquals("JSON", report.getFooter().getType());

	}

	@Test
	public void testCreateXMLReport() {

		Report report = new Report();

		AbstractFactory headerFactory = FactoryProvider.getFactory("Header");
		ReportHeader reportHeader = headerFactory.createHeader("XML");

		AbstractFactory bodyFactory = FactoryProvider.getFactory("Body");
		ReportBody reportBody = bodyFactory.createBody("XML");

		AbstractFactory footerFactory = FactoryProvider.getFactory("Footer");
		ReportFooter reportFooter = footerFactory.createFooter("XML");

		report.setHeader(reportHeader);
		report.setBody(reportBody);
		report.setFooter(reportFooter);

		assertEquals("XML", report.getBody().getType());
		assertEquals("XML", report.getHeader().getType());
		assertEquals("XML", report.getFooter().getType());

	}

}
