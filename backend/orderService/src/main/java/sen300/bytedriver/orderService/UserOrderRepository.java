/**
 * @author Cambry Partridge
 * @createdOn 5/8/2024 at 10:57 AM
 * @projectName orderService
 * @packageName sen300.bytedriver.orderService;
 */
package sen300.bytedriver.orderService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserOrderRepository extends JpaRepository<UserOrders, String> {
}
