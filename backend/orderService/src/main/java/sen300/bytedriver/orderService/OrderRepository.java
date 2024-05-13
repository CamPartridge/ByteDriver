/**
 * @author Cambry Partridge
 * @createdOn 5/8/2024 at 10:50 AM
 * @projectName orderService
 * @packageName sen300.bytedriver.orderService;
 */
package sen300.bytedriver.orderService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Orders, String> {
    @Query("SELECT MAX(m.orderID) FROM Orders m")
    Long findMaxId();

    List<MenuItem> findByOrderID(Long orderID);

    List<Orders> findAllByOrderID(int orderid);
}
