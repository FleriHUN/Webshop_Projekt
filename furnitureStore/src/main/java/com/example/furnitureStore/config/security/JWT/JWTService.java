package com.example.furnitureStore.config.security.JWT;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.furnitureStore.config.security.JWT.RefreshToken.RefreshToken;
import com.example.furnitureStore.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import tools.jackson.databind.ObjectMapper;

import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class JWTService {
    private final UserRepository userRepository;
    private static final String AUTH = "auth";
    private final ObjectMapper mapper;

    private String issuer = "FormaLux";
    private Long expired = 86400000L; // 24 ora (volt: 7200000L = 2 ora)
    private String secret = "GPrdBIwcgYqXdlFjHM1tDG0slFCOekRaPOWJxTc3q9Bu9nq8sHjv7yXoVh2";

    public String createJwtToken(UserDetails principal) {
        System.out.println(principal.getUsername());
        com.example.furnitureStore.entity.User loggedUsers = userRepository.findByUsername(principal.getUsername()).orElseThrow(() -> new UsernameNotFoundException("User not found"));

        return JWT.create()
                .withSubject(loggedUsers.getEmail())
                .withArrayClaim(AUTH, principal.getAuthorities().stream().map(GrantedAuthority::getAuthority).toArray(String[]::new))
                .withExpiresAt(new Date(System.currentTimeMillis() + expired))
                .withIssuer(issuer)
                .sign(Algorithm.HMAC256(secret));
    }

    public UserDetails parseJwt(String jwtToken) {
        DecodedJWT jwt = JWT.require(Algorithm.HMAC256(secret)).withIssuer(issuer).build().verify(jwtToken);
        return new User(jwt.getSubject(), "dummy", jwt.getClaim(AUTH).asList(String.class).stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList()));
    }

    public String regenerateJwtToken(String refreshTokenValue) {
        if (refreshTokenValue != null) {
            byte[] decodedBytes = Base64.getUrlDecoder().decode(refreshTokenValue);
            String refreshTokenString = new String(decodedBytes, StandardCharsets.UTF_8);

            RefreshToken refreshToken = mapper.readValue(refreshTokenString, RefreshToken.class);
            if (!refreshToken.getExpiredDate().isBefore(Instant.now())) {

                com.example.furnitureStore.entity.User loggedUser = userRepository.findByUsername(refreshToken.getEmail()).orElse(null);
                if (loggedUser != null && !loggedUser.getIsDeleted()) {
                    List<GrantedAuthority> authorities = List.of(new SimpleGrantedAuthority(loggedUser.getRole().getName()));
                    String newJwt = createJwtToken(new User(loggedUser.getEmail(), loggedUser.getPassword(), authorities));
                    return newJwt;
                }
            }
        }
        return null;
    }
}
