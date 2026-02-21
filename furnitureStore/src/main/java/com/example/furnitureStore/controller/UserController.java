package com.example.furnitureStore.controller;

import com.example.furnitureStore.entity.User;
import com.example.furnitureStore.service.UserService;
import com.fasterxml.jackson.databind.JsonNode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/login")
    private ResponseEntity<Object> login(@RequestBody JsonNode requestBody) {
        return userService.login(requestBody.get("username").asText(null), requestBody.get("password").asText(null));
    }

    @PostMapping("/register")
    private ResponseEntity<Object> register(@RequestBody User newUser) {
        return userService.register(newUser);
    }

    @PatchMapping("/{id}")
    private ResponseEntity<Object> update(@RequestBody JsonNode requestBody, @PathVariable("id") Integer id) {
        return userService.update(id, requestBody.get("username").asText(null), requestBody.get("com/example/furnitureStore/config/email").asText(null));
    }

    @DeleteMapping("/{id}")
    private ResponseEntity<Object> delete(@PathVariable("id") Integer id) {
        return userService.delete(id);
    }

    @PatchMapping("/pfp/{id}")
    private ResponseEntity<Object> changePfp(@RequestParam("pfpFile") MultipartFile newPfpImage, @PathVariable("id") Integer id) {
        return userService.changePfp(newPfpImage, id);
    }

    @GetMapping("/vCode")
    private ResponseEntity<Object> getVerificationCode(@RequestParam("com/example/furnitureStore/config/email") String email) {
        return userService.getVerificationCode(email);
    }

    @PostMapping("/check")
    private ResponseEntity<Object> checkVerificationCode(@RequestBody JsonNode requestBody) {
        return userService.checkVerificationCode(requestBody.get("vCode").asText(null), requestBody.get("com/example/furnitureStore/config/email").asText(null));
    }

    @PatchMapping("/password")
    private ResponseEntity<Object> changePassword(@RequestBody JsonNode requestBody) {
        return userService.changePassword(requestBody.get("com/example/furnitureStore/config/email").asText(null), requestBody.get("newPassword").asText(null));
    }
}
