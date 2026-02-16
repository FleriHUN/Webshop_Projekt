package com.example.furnitureStore.service;

import com.example.furnitureStore.repository.AddressTypeRepository;
import com.example.furnitureStore.repository.PaymentMethodRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OtherService {

    PaymentMethodRepository paymentMethodRepository;
    AddressTypeRepository addressTypeRepository;

    //kesz
    public ResponseEntity<Object> getAllPaymentMethod() {
        try {
            return ResponseEntity.ok().body(paymentMethodRepository.findAll());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz
    public ResponseEntity<Object> getAllAddressType() {
        try {
            return ResponseEntity.ok().body(addressTypeRepository.findAll());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}

