package com.example.furnitureStore.service;

import com.example.furnitureStore.entity.Cart;
import com.example.furnitureStore.entity.OrderHistory;
import com.example.furnitureStore.entity.PaymentMethod;
import com.example.furnitureStore.entity.User;
import com.example.furnitureStore.repository.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class OrderService {

    private final OrderHistoryRepository orderHistoryRepository;
    private final UserRepository userRepository;
    private final StatusRepository statusRepository;
    private final PaymentMethodRepository paymentMethodRepository;
    private final AddressTypeRepository addressTypeRepository;
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final EmailSender emailSender;
    private final PasswordEncoder passwordEncoder;

    //kesz:
    public ResponseEntity<Object> getOrderHistoryByUserId(Integer userId) {
        try {
            if (userId == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserById(userId).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }

            return ResponseEntity.ok().body(searchedUser.getOrderHistoryList());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    //kesz
    public ResponseEntity<Object> cancelOrder(Integer orderId, Integer cancelerUserId) {
        try {
            if (orderId == null) {
                return ResponseEntity.status(422).build();
            }
            OrderHistory searchedOrderHistory = orderHistoryRepository.findById(orderId).orElse(null);
            if (searchedOrderHistory == null || searchedOrderHistory.getIsCanceled()) {
                return ResponseEntity.status(404).body("orderNotFound");
            }
            if (cancelerUserId != 0) {
                User cancelerUser = userRepository.getUserById(cancelerUserId).orElse(null);
                if (cancelerUser == null || cancelerUser.getIsDeleted()) {
                    return ResponseEntity.status(404).body("userNotFound");
                }
                searchedOrderHistory.setCancelerUser(cancelerUser);
            } else {
//                searchedOrderHistory.setCancelerEmail(searchedOrderHistory.getEmail());
            }
            try {
                emailSender.sendEmailAboutCancelledOrder(searchedOrderHistory.getEmail());
            } catch (Exception e) {
                return ResponseEntity.internalServerError().body("emailSenderError");
            }

            searchedOrderHistory.setStatus(statusRepository.findById(3).get());
            searchedOrderHistory.setCanceledAt(LocalDateTime.now());
            searchedOrderHistory.setIsCanceled(true);
            orderHistoryRepository.save(searchedOrderHistory);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    //kesz
    public ResponseEntity<Object> getOrderHistoryByVCode(String email, String vCode) {
        try {
            if (email == null || vCode == null) {
                return ResponseEntity.status(422).build();
            }

            List<OrderHistory> histories = orderHistoryRepository.findByEmail(email);
            for (int i = 0; i < histories.size(); i++) {
//                if (passwordEncoder.matches(vCode, histories.get(i).getCancelerVCode())) {
//                    return ResponseEntity.ok().body(histories.get(i));
//                }
            }
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    //kesz:
    public ResponseEntity<Object> sendOrder(OrderHistory newOrder, Integer basketId) {
        try {
            if (newOrder == null || basketId == null) {
                return ResponseEntity.status(422).build();
            }

            if (newOrder.getOrderUser() != null) {
                User searchedUser = userRepository.getUserById(newOrder.getOrderUser().getId()).orElse(null);
                if (searchedUser == null || searchedUser.getIsDeleted()) {
                    return ResponseEntity.status(404).body("userNotFound");
                }
            }

            PaymentMethod searchedPaymentMethod = paymentMethodRepository.findById(newOrder.getPaymentMethod().getId()).orElse(null);
            Cart searchedCart = cartRepository.findById(basketId).orElse(null);

            if (searchedPaymentMethod == null) {
                return ResponseEntity.status(404).body("paymentMethodNotFound");
            } else if (searchedCart == null) {
                return ResponseEntity.status(404).body("basketNotFound");
            }


        }
