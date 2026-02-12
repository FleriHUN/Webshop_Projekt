package com.example.furnitureStore.repository;

import com.example.furnitureStore.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Integer> {

    @Procedure(name = "getFirstThreeProduct", procedureName = "getFirstThreeProduct")
    List<Product> getFirstThreeProduct();

    @Procedure(name = "getProductById", procedureName = "getProductById")
    Optional<Product> getProductById(@Param("idIN") Integer id);
}