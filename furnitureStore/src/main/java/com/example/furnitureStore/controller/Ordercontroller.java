package com.example.furnitureStore.controller;

import com.example.furnitureStore.entity.OrderHistory;
import com.example.furnitureStore.service.OrderService;
import com.fasterxml.jackson.databind.JsonNode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/order")
@RequiredArgsConstructor
public class OrderController {

    private OrderService orderService;

    @GetMapping("/user/{id}")
    public ResponseEntity<Object> getOrderHistoryByUserId(@PathVariable("id") Integer userId) {
        return orderService.getOrderHistoryByUserId(userId);
    }

    @DeleteMapping("/cancel/{id}")
    public ResponseEntity<Object> cancelOrder(@PathVariable("id") Integer orderId, @RequestBody JsonNode requestBody) {
        return orderService.cancelOrder(orderId, requestBody.get("cancelerUserId").asInt());
    }

    @GetMapping("/search")
    public ResponseEntity<Object> getOrderHistoryByVCode(@RequestParam("com/example/furnitureStore/config/email") String email, @RequestParam("vCode") String vCode) {
        return orderService.getOrderHistoryByVCode(email, vCode);
    }

    @GetMapping("")
    public ResponseEntity<Object> getAllOrder() {
        return orderService.getAllOrder();
    }

    @PostMapping("/basket/{id}")
    public ResponseEntity<Object> sendOrder(@RequestBody OrderHistory newOrder, @PathVariable("id") Integer basketId) {
        return orderService.sendOrder(newOrder, basketId);
    }
}

