package com.example.furnitureStore.controller;

import com.example.furnitureStore.entity.User;
import com.example.furnitureStore.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
@CrossOrigin({"http://localhost:4200"})
public class UserController {

    private final UserService userService;

    @PostMapping("/login")
    public ResponseEntity<Object> login(@RequestBody Map<String, String> body) {
        return userService.login(body.get("com/example/furnitureStore/config/email"), body.get("password"));
    }

    @PostMapping("/register")
    public ResponseEntity<Object> register(@RequestBody User newUser) {
        return userService.register(newUser);
    }
}