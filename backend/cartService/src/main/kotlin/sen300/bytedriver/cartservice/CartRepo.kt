package sen300.bytedriver.cartservice

import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Repository

@Repository
interface CartRepo :CrudRepository<Cart, String> {
}