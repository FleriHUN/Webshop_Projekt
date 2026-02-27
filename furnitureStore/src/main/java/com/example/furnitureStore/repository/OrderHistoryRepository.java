package com.example.furnitureStore.repository;

import com.example.furnitureStore.entity.OrderHistory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderHistoryRepository extends JpaRepository<OrderHistory, Integer> {

    List<OrderHistory> findByEmail(String email);
}
