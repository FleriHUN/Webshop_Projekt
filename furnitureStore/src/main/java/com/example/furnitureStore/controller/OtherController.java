package com.example.furnitureStore.controller;

import com.example.furnitureStore.service.OtherService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class OtherController {

    private final OtherService otherService;

    @GetMapping("/paymentMethods")
    public ResponseEntity<Object> getAllPaymentMethod() {
        return otherService.getAllPaymentMethod();
    }

    @GetMapping("/addressType")
    public ResponseEntity<Object> getAllAddressType() {
        return otherService.getAllAddressType();
    }
}

