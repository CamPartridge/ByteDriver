package sen300.bytedriver.cartservice

import org.springframework.data.annotation.Id
import java.io.Serializable

data class Cart(
    @Id
    var id: String? = null,
    var menuItems: MutableList<MenuItem> = mutableListOf()
) : Serializable {

}