package com.example.furnitureStore.config.security;

import com.example.furnitureStore.config.security.JWT.JWTGeneratorFilter;
import com.example.furnitureStore.config.security.JWT.JWTValidatorFilter;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;

import java.util.Arrays;
import java.util.Collections;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(jsr250Enabled = true, securedEnabled = true)
@RequiredArgsConstructor
public class SecurityConfig {

    private final DbUserSetter userSetter;
    private final JWTValidatorFilter jwtValidatorFilter;
    private final JWTGeneratorFilter jwtGeneratorFilter;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http
                .cors(cors -> cors.configurationSource(new CorsConfigurationSource() {
                    @Override
                    public CorsConfiguration getCorsConfiguration(HttpServletRequest request) {
                        CorsConfiguration config = new CorsConfiguration();
                        config.setAllowedOrigins(Collections.singletonList("http://localhost:4200"));
                        config.setAllowedMethods(Collections.singletonList("*"));
                        config.setAllowedHeaders(Collections.singletonList("*"));
                        config.setAllowCredentials(true);
                        config.setExposedHeaders(Arrays.asList("Authorization", "Bearer "));
                        config.setMaxAge(3600L);
                        return config;
                    }
                }))
                .csrf(csrf -> csrf.disable())
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests((request) -> request
                        .requestMatchers(HttpMethod.GET, "/brand").permitAll()
                        .requestMatchers("/brand").hasRole("admin")
                        .requestMatchers(HttpMethod.DELETE, "/brand/*").hasRole("admin")
                        .requestMatchers("/cart/**").authenticated()
                        .requestMatchers("/category/parents", "/category/sub/*").permitAll()
                        .requestMatchers("/category", "/category/*").hasRole("admin")
                        .requestMatchers(HttpMethod.GET, "/order").hasRole("admin")
                        .requestMatchers(HttpMethod.GET, "/order/**").authenticated()
                        .requestMatchers("/paymentMethods", "/addressType").permitAll()
                        .requestMatchers("/product/category/*", "/product/homePage").permitAll()
                        .requestMatchers(HttpMethod.GET, "/product/*").permitAll()
                        .requestMatchers("/product/*", "/product").hasRole("admin")
                        .requestMatchers("/review", "/review/*").authenticated()
                        .requestMatchers("/user/login", "/user/register", "/user/vCode", "/user/check", "/user/password").permitAll()
                        .requestMatchers("/user/*", "/user/**").authenticated()
                        .requestMatchers("/user").hasRole("admin")
                )
                .addFilterBefore(jwtValidatorFilter, BasicAuthenticationFilter.class)
                .addFilterAfter(jwtGeneratorFilter, BasicAuthenticationFilter.class)
                .httpBasic(Customizer.withDefaults())
                .formLogin(Customizer.withDefaults());
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    AuthenticationProvider authProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider(userSetter);
        authenticationProvider.setPasswordEncoder(passwordEncoder());
        return authenticationProvider;
    }
}
