package com.example.furnitureStore.controller;

import com.example.furnitureStore.entity.Category;
import com.example.furnitureStore.repository.CategoryRepository;
import com.example.furnitureStore.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController()
@RequestMapping("/category")
@RequiredArgsConstructor
public class CategoryController {
    private final CategoryService categoryService;

//    @GetMapping("")
//    private ResponseEntity<Object> getAllCategory() {
//        return null;
//    }

    @PostMapping("")
    private ResponseEntity<Object> addCategory(@RequestBody Category newCategory) {
        return categoryService.addCategory(newCategory);
    }

    @DeleteMapping("/{id}")
    private ResponseEntity<Object> deleteCategory(@PathVariable("id") Integer id) {
        return categoryService.deleteCategory(id);
    }

    @PutMapping("")
    private ResponseEntity<Object> updateCategory(@RequestBody Category updatedCategory) {
        return categoryService.updateCategory(updatedCategory);
    }
}
