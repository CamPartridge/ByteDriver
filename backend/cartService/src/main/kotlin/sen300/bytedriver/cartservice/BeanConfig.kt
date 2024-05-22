package sen300.bytedriver.cartservice

import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.data.redis.connection.RedisConnectionFactory
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.data.redis.repository.configuration.EnableRedisRepositories
import org.springframework.data.redis.support.collections.RedisProperties
import java.awt.MenuItem

@Configuration
@EnableRedisRepositories
class BeanConfig {

    @Bean
    fun redisTemplate(connectionFactory: RedisConnectionFactory, objectMapper: ObjectMapper): RedisTemplate<String, Cart> {
        return RedisTemplate<String, Cart>().apply {
            setConnectionFactory(connectionFactory)
            setDefaultSerializer(org.springframework.data.redis.serializer.StringRedisSerializer())
            setHashKeySerializer(org.springframework.data.redis.serializer.StringRedisSerializer())
            setHashValueSerializer(
                org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer(
                    objectMapper
                )
            )
        }
    }

    @Bean
    fun objectMapper(): ObjectMapper {
        val objectMapper = ObjectMapper()
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
        return objectMapper
    }
}