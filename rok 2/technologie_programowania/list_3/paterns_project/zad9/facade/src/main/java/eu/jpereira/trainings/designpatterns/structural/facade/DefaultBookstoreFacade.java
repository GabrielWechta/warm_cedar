package eu.jpereira.trainings.designpatterns.structural.facade;

import eu.jpereira.trainings.designpatterns.structural.facade.model.Book;
import eu.jpereira.trainings.designpatterns.structural.facade.model.Customer;
import eu.jpereira.trainings.designpatterns.structural.facade.model.DispatchReceipt;
import eu.jpereira.trainings.designpatterns.structural.facade.model.Order;
import eu.jpereira.trainings.designpatterns.structural.facade.service.BookDBService;
import eu.jpereira.trainings.designpatterns.structural.facade.service.CustomerDBService;
import eu.jpereira.trainings.designpatterns.structural.facade.service.CustomerNotificationService;
import eu.jpereira.trainings.designpatterns.structural.facade.service.OrderingService;
import eu.jpereira.trainings.designpatterns.structural.facade.service.WharehouseService;

public class DefaultBookstoreFacade implements BookstoreFacade {
	
	private BookDBService bookDBService;
	private CustomerDBService customerDBService;
	private OrderingService orderingService;
	private WharehouseService wharehouseService;
	private CustomerNotificationService customerNotificationService;
	
	
	public DefaultBookstoreFacade(BookDBService bookDBService, CustomerDBService customerDBService,
			OrderingService orderingService,
			WharehouseService wharehouseService, CustomerNotificationService customerNotificationService) {
		super();
		this.bookDBService = bookDBService;
		this.customerDBService = customerDBService;
		this.orderingService = orderingService;
		this.wharehouseService = wharehouseService;
		this.customerNotificationService = customerNotificationService;
	}


	@Override
	public void placeOrder(String customerId, String isbn) {
		Book book = bookDBService.findBookByISBN(isbn);
		Customer customer = customerDBService.findCustomerById(customerId);
		Order order = orderingService.createOrder(customer, book);
		DispatchReceipt dispatchReceipt = wharehouseService.dispatch(order);
		customerNotificationService.notifyClient(dispatchReceipt);
	}

}
