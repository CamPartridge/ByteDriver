/**
 * @author Cambry Partridge
 * @createdOn 5/8/2024 at 10:41 AM
 * @projectName orderService
 * @packageName sen300.bytedriver.orderService;
 */
package sen300.bytedriver.orderService;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
public class Orders {

    @Id
    @GeneratedValue
    private Long ID;
    private Long orderID;

    private String itemName;
    private double itemPrice;
    private int quantity;

    // Getters and setters


    public Orders() {
    }

    public Orders(Long orderID, String itemName, double itemPrice, int quantity) {
        this.orderID = orderID;
        this.itemName = itemName;
        this.itemPrice = itemPrice;
        this.quantity = quantity;
    }

    public Long getID() {
        return ID;
    }

    public void setID(Long ID) {
        this.ID = ID;
    }

    public void setItemPrice(double itemPrice) {
        this.itemPrice = itemPrice;
    }

    public Long getOrderID() {
        return orderID;
    }

    public void setOrderID(Long orderID) {
        this.orderID = orderID;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public double getItemPrice() {
        return itemPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
