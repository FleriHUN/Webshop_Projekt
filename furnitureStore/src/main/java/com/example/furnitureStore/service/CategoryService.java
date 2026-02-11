package com.example.furnitureStore.service;

import com.example.furnitureStore.entity.Brand;
import com.example.furnitureStore.entity.Category;
import com.example.furnitureStore.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryService {
    private final CategoryRepository categoryRepository;


    public ResponseEntity<Object> addCategory(Category newCategory) {
        try {
            if (newCategory == null) {
                return ResponseEntity.status(422).build();
            }

            if (newCategory.getId() != null) {
                return ResponseEntity.status(415).body("invalidBrand");
            } else {
                return ResponseEntity.ok().body(categoryRepository.save(newCategory));
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> updateCategory(Category updatedCategory) {
        try {
            if (updatedCategory == null) {
                return ResponseEntity.status(422).build();
            }

            if (updatedCategory.getId() == null) {
                return ResponseEntity.status(415).body("invalidObject");
            } else {
                return ResponseEntity.ok().body(categoryRepository.save(updatedCategory));
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> deleteCategory(Integer id) {
        try {
            if (id == null) {
                return ResponseEntity.status(422).build();
            }

            Category searchedBrand = categoryRepository.findById(id).orElse(null);
            if (searchedBrand == null) {
                return ResponseEntity.notFound().build();
            } else {

                return ResponseEntity.ok().build();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}