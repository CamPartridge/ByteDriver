package sen300.bytedriver.cartservice

import com.fasterxml.jackson.core.JsonParseException
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.io.Serializable

@RestController
@RequestMapping("/cart")
class CartRestController {
    @Autowired
    private lateinit var redisTemplate: RedisTemplate<String, Cart>

    private var latestId: Int = 0

    @GetMapping("/test")
    @ResponseStatus(code = HttpStatus.OK)
    fun getTest(): String {
        return "Hey there, this is the cart service api."
    }

    @PostMapping("/", consumes = ["application/json"])
    @ResponseStatus(code = HttpStatus.CREATED)
    fun createCart(@RequestBody cart: Cart): Cart {
        val cartWithId = assignUniqueIdToCart(cart)
        saveCartToRedis(cartWithId)
        return cartWithId
    }

    //region HELPERS
    fun assignUniqueIdToCart(cart: Cart): Cart {
        latestId++
        cart.id = latestId.toString()
        return cart
    }

    fun saveCartToRedis(cart: Cart) {
        val objectMapper = ObjectMapper()
        val cartJsonString = objectMapper.writeValueAsString(cart)
        cart.id?.let { redisTemplate.opsForHash<String, String>().put("carts", it, cartJsonString) }
    }
    //endregion

    @GetMapping("/{cartId}")
    @ResponseStatus(code = HttpStatus.OK)
    fun getCartById(@PathVariable cartId: String): Any? {
        try {
            val cartJsonString = redisTemplate.opsForHash<String, String>().get("carts", cartId)
            if (cartJsonString != null) {
                val objectMapper = ObjectMapper()
                return objectMapper.readValue(cartJsonString, Cart::class.java)
            }
        } catch (ex: JsonParseException) {
            return ResponseEntity("Cart with id: $cartId not found", HttpStatus.NOT_FOUND)
        }
        return null
    }

    @PutMapping("/{cartId}")
    @ResponseStatus(code = HttpStatus.OK)
    fun updateCart(@PathVariable cartId: String, @RequestBody updatedCart: Cart): Cart? {
        val existingCartJson: String? = redisTemplate.opsForHash<String, String>().get("carts", cartId)
        if (existingCartJson != null) {
            val objectMapper = ObjectMapper()
            val existingCart: Cart = objectMapper.readValue(existingCartJson, Cart::class.java)

            existingCart.menuItems = updatedCart.menuItems
            val updatedCartJson = objectMapper.writeValueAsString(existingCart)
            redisTemplate.opsForHash<String, String>().put("carts", cartId, updatedCartJson)

            return existingCart
        }
        return null
    }

    @DeleteMapping("/{cartId}")
    @ResponseStatus(code = HttpStatus.OK)
    fun deleteCart(@PathVariable cartId: String): String {
        redisTemplate.opsForHash<String, Cart>().delete("carts", cartId)
        return "Cart with ID $cartId deleted successfully."
    }

    @DeleteMapping("/{cartId}/{nameMenuitem}")
    @ResponseStatus(code = HttpStatus.OK)
    fun deleteMenuItemFromCart(@PathVariable cartId: String, @PathVariable nameMenuitem: String): Serializable {
        val cartInJson = redisTemplate.opsForHash<String, String>().get("carts", cartId)
        if (cartInJson != null) {
            val objectMapper = ObjectMapper()
            val cart: Cart = objectMapper.readValue(cartInJson, Cart::class.java)

            cart.menuItems.removeIf { it.name == nameMenuitem }
            redisTemplate.opsForHash<String, Cart>().put("carts", cartId, cart)
            saveCartToRedis(cart)
            return cart
        }
        return "Something didn't work"
    }
}