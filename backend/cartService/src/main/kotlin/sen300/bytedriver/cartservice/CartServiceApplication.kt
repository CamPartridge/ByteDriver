package sen300.bytedriver.cartservice

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.cloud.client.discovery.EnableDiscoveryClient
import org.springframework.context.annotation.Bean
import org.springframework.web.servlet.config.annotation.CorsRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer


@SpringBootApplication
@EnableDiscoveryClient
class CartServiceApplication

fun main(args: Array<String>) {
	runApplication<CartServiceApplication>(*args)
}

//@Bean
//fun corsConfigurer(): WebMvcConfigurer {
//	return object : WebMvcConfigurer {
//		override fun addCorsMappings(registry: CorsRegistry) {
//			registry.addMapping("/**").allowedOrigins("**").allowedMethods("**")
//		}
//	}
//}
