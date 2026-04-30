package com.example.furnitureStore.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * A /productImg/** URL-eket explicit mappolja a projekt gyokereben levo
 * productImg/ mappara. Ez kell ahhoz, hogy a DB-ben tarolt
 * "http://localhost:8080/productImg/kanape1.avif" jellegu URL-ek mukodjenek.
 *
 * A spring.web.resources.static-locations property nem alkalmas erre, mert
 * az csak gyoker URL-en (/) szolgalna ki, nem /productImg/** prefix-en.
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/productImg/**")
                .addResourceLocations("file:./productImg/");
    }
}
