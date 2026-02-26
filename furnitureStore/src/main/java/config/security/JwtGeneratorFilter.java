package config.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Date;
import java.util.concurrent.TimeUnit;

@Component
public class JwtGeneratorFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        Authentication givenAuthentication = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("ASD");
        if (givenAuthentication != null) {
            System.out.println("givenAuthentication != null");
            UserDetails details = (UserDetails) givenAuthentication.getPrincipal();

            String jwt = JWT.create()
                    .withSubject(details.getUsername())
                    .withArrayClaim("auth", details.getAuthorities().stream().map(GrantedAuthority::getAuthority).toArray(String[]::new))
                    .withExpiresAt(new Date(System.currentTimeMillis() + TimeUnit.HOURS.toMillis(7200000)))
                    .withIssuer("universityTeam")
                    .sign(Algorithm.HMAC256("cbfb19aeab8b95b39eb3f190f6ce305445b1eaf0ea19c417ceae59f887b723cf"));

            response.setHeader("Bearer ", jwt);
        }

        filterChain.doFilter(request, response);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        return !request.getServletPath().equals("/user/login");
    }
}
