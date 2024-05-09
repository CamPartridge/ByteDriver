package sen300.bytedriver.cartservice

import org.springframework.data.annotation.Id
import java.io.Serializable

data class MenuItem(
    @Id
    val name: String,
    val price: Float,
    val quantity: Int
) : Serializable {
    constructor() : this("", 0.0f, 0)
}