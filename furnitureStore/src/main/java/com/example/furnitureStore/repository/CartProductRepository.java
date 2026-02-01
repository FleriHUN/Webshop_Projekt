package com.example.furnitureStore.repository;

import com.example.furnitureStore.entity.CartProduct;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CartProductRepository extends JpaRepository<CartProduct, Integer> {
}