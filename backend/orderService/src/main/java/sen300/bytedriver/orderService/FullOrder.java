/**
 * @author Cambry Partridge
 * @createdOn 5/9/2024 at 10:16 PM
 * @projectName orderService
 * @packageName sen300.bytedriver.orderService;
 */
package sen300.bytedriver.orderService;

import java.util.List;

public class FullOrder {

    private Long phoneNumber;
    private String firstName;
    private String lastName;
    List<MenuItem> menuItems;
    private Long driverID;
    private Long byterID;

    public FullOrder(Long byterID, Long phoneNumber, String firstName, String lastName, List<MenuItem> menuItems, Long driverID) {
        this.byterID = byterID;
        this.phoneNumber = phoneNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.menuItems = menuItems;
        this.driverID = driverID;
    }

    public Long getByterID() {
        return byterID;
    }

    public void setByterID(Long byterID) {
        this.byterID = byterID;
    }

    public Long getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(Long phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public List<MenuItem> getMenuItems() {
        return menuItems;
    }

    public void setMenuItems(List<MenuItem> menuItems) {
        this.menuItems = menuItems;
    }

    public Long getDriverID() {
        return driverID;
    }

    public void setDriverID(Long driverID) {
        this.driverID = driverID;
    }

    @Override
    public String toString() {
        return "FullOrder{" +
                "byterID=" + byterID +
                ", phoneNumber=" + phoneNumber +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", menuItems=" + menuItems +
                ", driverID=" + driverID +
                '}';
    }
}
