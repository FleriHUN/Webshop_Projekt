package com.example.furnitureStore.controller;

import com.example.furnitureStore.entity.Brand;
import com.example.furnitureStore.entity.Category;
import com.example.furnitureStore.entity.Product;
import com.example.furnitureStore.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    @GetMapping("/category/{id}")
    private ResponseEntity<Object> getProductsByCategory(@PathVariable("id") Integer id) {
        return productService.getProductsByCategory(id);
    }

    @GetMapping("/homePage")
    private ResponseEntity<Object> getFirstThreeProduct() {
        return productService.getFirstThreeProduct();
    }

    @PostMapping("")
    private ResponseEntity<Object> addProduct(@RequestBody Product newProduct) {
        return null;
    }

    @DeleteMapping("/{id}")
    private ResponseEntity<Object> deleteProduct(@PathVariable("id") Integer id) {
        return productService.deleteProduct(id);
    }

    @PutMapping("")
    private ResponseEntity<Object> updateProduct(@RequestBody Product updatedProduct) {
        return null;
    }


}