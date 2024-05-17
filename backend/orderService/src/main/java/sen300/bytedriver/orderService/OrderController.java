/**
 * @author Cambry Partridge
 * @createdOn 5/8/2024 at 11:13 AM
 * @projectName orderService
 * @packageName sen300.bytedriver.orderService;
 */
package sen300.bytedriver.orderService;

import com.fasterxml.jackson.databind.util.JSONPObject;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    OrderRepository orderRepo;

    @Autowired
    UserRepository userRepo;

    @Autowired
    UserOrderRepository userOrdersRepo;

    @GetMapping("/test")
    @ResponseStatus(code = HttpStatus.OK)
    public String runTest(){
        return "OrderService working";
    }

    @GetMapping("")
    @ResponseStatus(code = HttpStatus.OK)
    public HashMap<Long, List<Orders>> getAllOrdersGroupedByOrderID() {
        List<Orders> allOrders = orderRepo.findAll();

        HashMap<Long, List<Orders>> ordersGroupedByOrderID = new HashMap<>();

        for (Orders order : allOrders) {
            Long orderID = order.getOrderID();

            // Check if ordersGroupedByOrderID already contains the orderID
            if (ordersGroupedByOrderID.containsKey(orderID)) {
                // If the orderID exists, retrieve the existing list and add the new order
                ordersGroupedByOrderID.get(orderID).add(order);
            } else {
                // If the orderID doesn't exist, create a new list and add the new order
                List<Orders> newOrdersList = new ArrayList<>();
                newOrdersList.add(order);
                ordersGroupedByOrderID.put(orderID, newOrdersList);
            }
        }

        return ordersGroupedByOrderID;
    }

    @GetMapping("/{orderid}")
    @ResponseStatus(code = HttpStatus.OK)
    public List<Orders> getAllOrdersByOrderID(@PathVariable int orderid) {
        List<Orders> allOrdersWithOrderID = orderRepo.findAllByOrderID(orderid);

        return allOrdersWithOrderID;
    }

    @PostMapping("")
    @ResponseStatus(code = HttpStatus.CREATED)
    public FullOrder createOrder(@RequestBody FullOrder fullOrder){
        String firstName = fullOrder.getFirstName();
        String lastName = fullOrder.getLastName();
        Long phoneNumber = fullOrder.getPhoneNumber();
        List<MenuItem> menuItems = fullOrder.getMenuItems();
        Long byterID = fullOrder.getByterID();
        Long driverID = fullOrder.getDriverID();

        Users user = new Users(byterID, phoneNumber, firstName, lastName);
        userRepo.save(user);

        if(driverID == null) driverID = 000L;
       UserOrders userOrder = new UserOrders(byterID, driverID, "order placed");
       userOrder = userOrdersRepo.save(userOrder);

        for (MenuItem item: menuItems) {
            Orders order = new Orders(userOrder.getOrderID(), item.getName(), item.getPrice(), item.getQuantity());
            orderRepo.save(order);
        }
        return fullOrder;
    }

    @PatchMapping("/{orderid}/{status}")
    @ResponseStatus(code = HttpStatus.OK)
    public String updateStatus(@PathVariable int orderid, @PathVariable String status){
        UserOrders order = userOrdersRepo.findByOrderID(orderid);
        if (order != null) {
            order.setStatus(status);
            userOrdersRepo.save(order); // Save the updated order
            return "Order status successfully updated to: " + status;
        }
        return "No order found to update the status";
    }

}
