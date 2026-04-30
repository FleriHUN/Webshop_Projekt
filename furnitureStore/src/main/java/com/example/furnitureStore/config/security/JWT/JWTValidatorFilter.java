package com.example.furnitureStore.config.security.JWT;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import tools.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

@Component
@RequiredArgsConstructor
public class JWTValidatorFilter extends OncePerRequestFilter {

    private final JWTService jwtService;
    private static final String AUTHORIZATION = "Authorization";
    private static final String BEARER = "Bearer ";
    private final ObjectMapper mapper;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String header = request.getHeader(AUTHORIZATION);
        System.out.println("header: " + header);
        if (header != null && header.startsWith(BEARER)) {
            String jwt = header.substring(BEARER.length());
            System.out.println(jwt);
            UserDetails principal = null;
            try {
                principal = jwtService.parseJwt(jwt);
            } catch (Exception e) {
                // Lejart vagy ervenytelen JWT - probaljuk regeneralni a refresh token-bol
                System.out.println("JWT parse failed: " + e.getMessage() + " - trying refresh token");
                String refreshTokenHeader = request.getHeader("refreshToken");
                if (refreshTokenHeader != null && !refreshTokenHeader.isEmpty()) {
                    try {
                        String newJwt = jwtService.regenerateJwtToken(refreshTokenHeader);
                        if (newJwt != null) {
                            principal = jwtService.parseJwt(newJwt);
                            response.setHeader("Bearer ", newJwt);
                            System.out.println("JWT regenerated successfully");
                        } else {
                            System.out.println("Refresh token expired or invalid - user must re-login");
                        }
                    } catch (Exception ex) {
                        System.out.println("JWT regeneration failed: " + ex.getMessage());
                    }
                } else {
                    System.out.println("No refresh token in request - user must re-login");
                }
            }

            // Csak akkor allitsuk be az authentication-t, ha tenyleg sikerult
            if (principal != null) {
                UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(principal, null, principal.getAuthorities());
                authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        }

        filterChain.doFilter(request, response);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        System.out.println(request.getServletPath());
        ArrayList<String> allowedUrlPaths = new ArrayList<String>(Arrays.asList(
                "/user/login", "/user/register", "/brand", "/category/parents", "/category/sub/", "/paymentMethods", "/addressType", "/product/category/*", "/product/homePage", "/user/login", "/user/register", "/user/vCode", "/user/check", "/user/password"
        ));

        return allowedUrlPaths.contains(request.getServletPath()) ||
                request.getServletPath().contains("/category/sub") ||
                request.getServletPath().contains("/product/category") ||
                request.getServletPath().contains("/product/") ||
                request.getServletPath().contains("/productImg/");
    }
}
