package factories;

public class FactoryProvider {
	public static AbstractFactory getFactory(String choice) {
		if ("Header".equalsIgnoreCase(choice)) {
			return new HeaderFactory();
		} else if ("Body".equalsIgnoreCase(choice)) {
			return new BodyFactory();
		} else if ("Footer".equalsIgnoreCase(choice)) {
			return new FooterFactory();
		}

		return null;
	}
}
