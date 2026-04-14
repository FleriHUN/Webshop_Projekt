package com.example.furnitureStore.service;

import com.example.furnitureStore.entity.Category;
import com.example.furnitureStore.entity.Product;
import com.example.furnitureStore.repository.CategoryRepository;
import com.example.furnitureStore.repository.ProductRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
@Transactional
@RequiredArgsConstructor
public class ProductService {

    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;

    public ResponseEntity<Object> getProductsByCategory(Integer categoryId) {
        try {
            Category searchedCategory = categoryRepository.findById(categoryId).orElse(null);
            if (searchedCategory == null || searchedCategory.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            } else {
                return ResponseEntity.ok().body(searchedCategory.getProductList());
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }

    }

    public ResponseEntity<Object> getFirstThreeProduct() {
        try {
            return ResponseEntity.ok(productRepository.getFirstThreeProduct());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> addProduct(Product newProduct) {
        return null;
    }

    public ResponseEntity<Object> deleteProduct(Integer id) {
        try {
            Product searchedProduct = productRepository.getProductById(id).orElse(null);
            if (searchedProduct == null) {
                return ResponseEntity.notFound().build();
            } else {
                searchedProduct.setIsDeleted(true);
                searchedProduct.setDeletedAt(new Date());
                productRepository.save(searchedProduct);
                return ResponseEntity.ok().build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> getAllProduct() {
        try {
            return ResponseEntity.ok().body(productRepository.getAllProduct());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> getProductById(Integer id) {
        Product searchedProduct = productRepository.getProductById(id).orElse(null);
        if (searchedProduct == null || searchedProduct.getIsDeleted()) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(searchedProduct);
    }
}
