/**
 * @author Cambry Partridge
 * @createdOn 5/8/2024 at 10:42 AM
 * @projectName orderService
 * @packageName sen300.bytedriver.orderService;
 */
package sen300.bytedriver.orderService;

import jakarta.persistence.*;

@Entity
public class UserOrders {

    @Id
    @GeneratedValue
    private Long orderID;

    @JoinColumn(name = "byterid", referencedColumnName = "userid", foreignKey = @ForeignKey(name = "FK_byterid"))
    private Long byterID;

    @JoinColumn(name = "driverid", referencedColumnName = "userid", foreignKey = @ForeignKey(name = "FK_driverid"))
    private Long driverID;

    private String status;

    public UserOrders() {
    }

    public UserOrders(Long byterID, Long driverID, String status) {
        this.byterID = byterID;
        this.driverID = driverID;
        this.status = status;
    }

    // Getters and setters
    public Long getOrderID() {
        return orderID;
    }

    public void setOrderID(Long orderID) {
        this.orderID = orderID;
    }

    public Long getByterID() {
        return byterID;
    }

    public void setByterID(Long byterID) {
        this.byterID = byterID;
    }

    public Long getDriverID() {
        return driverID;
    }

    public void setDriver(Long driverID) {
        this.driverID = driverID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
