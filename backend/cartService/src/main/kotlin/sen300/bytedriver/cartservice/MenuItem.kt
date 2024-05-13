package sen300.bytedriver.cartservice

import org.springframework.data.annotation.Id
import java.io.Serializable

data class MenuItem(
    @Id
    var id: Int? = null,
    val name: String,
    val price: Float,
    val quantity: Int
) : Serializable {
    constructor(name: String, price: Float, quantity: Int) : this(null, name, price, quantity)
    constructor() : this(null, "", 0.0f, 1)
}