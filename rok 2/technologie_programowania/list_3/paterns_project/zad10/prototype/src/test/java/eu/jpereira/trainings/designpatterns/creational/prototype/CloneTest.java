package eu.jpereira.trainings.designpatterns.creational.prototype;

import static org.junit.Assert.assertEquals;

import java.util.List;
import java.util.Properties;

import org.junit.Test;

import eu.jpereira.trainings.designpatterns.creational.prototype.exception.CannotHaveZeroPartsException;
import eu.jpereira.trainings.designpatterns.creational.prototype.exception.CouldNotCloneLastObjectException;
import eu.jpereira.trainings.designpatterns.creational.prototype.exception.NeedToPackLastVehicleException;
import eu.jpereira.trainings.designpatterns.creational.prototype.exception.VehicleDoesNotHavePartsException;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.Shell;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.Tire;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.Vehicle;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.VehiclePartEnumeration;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.VehiclePartPropertiesEnumeration;
import eu.jpereira.trainings.designpatterns.creational.prototype.model.Window;

public class CloneTest {

	@Test
	public void testCloneBUS() throws CouldNotCloneLastObjectException, CannotHaveZeroPartsException, NeedToPackLastVehicleException, VehicleDoesNotHavePartsException, CloneNotSupportedException {
		Client client = new Client();
		
		Properties tiresProps = new Properties();
		tiresProps.put(VehiclePartPropertiesEnumeration.SIZE,10);

		Properties shellProps = new Properties();
		shellProps.put(VehiclePartPropertiesEnumeration.COLOR,"blue");

		
		Properties windowProps = new Properties();
		windowProps.put(VehiclePartPropertiesEnumeration.WIDTH,20);
		windowProps.put(VehiclePartPropertiesEnumeration.WIDTH,20);

		//client.createVehicle().with(new Tires()).times(4).
		Vehicle firstVehicle = client.vehicleBuilder().createVehicle().with(new Tire(tiresProps)).times(3).with(new Window(windowProps)).times(8).with(new Shell(shellProps)).times(1).packIt();
		Vehicle secVehicle = (Vehicle) firstVehicle.clone();
		
		//Get all windows
		List<VehiclePart> parts = firstVehicle.getParts(VehiclePartEnumeration.WINDOW);
		assertEquals(8, parts.size());
		//ze skopiowanej
		List<VehiclePart> parts2 = secVehicle.getParts(VehiclePartEnumeration.TIRE);
		assertEquals(3, parts2.size());
	}
	
	@Test
	public void testClonePart() throws CouldNotCloneLastObjectException, CannotHaveZeroPartsException, NeedToPackLastVehicleException, VehicleDoesNotHavePartsException, CloneNotSupportedException {
		Client client = new Client();
		
		Properties tiresProps = new Properties();
		tiresProps.put(VehiclePartPropertiesEnumeration.SIZE,10);
		
		Tire tire1 = new Tire(tiresProps);
		Tire tire2 = (Tire) tire1.clone();
		assertEquals(10, tire2.getProperties().get(VehiclePartPropertiesEnumeration.SIZE));
	}
}
