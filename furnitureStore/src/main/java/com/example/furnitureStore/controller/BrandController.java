package com.example.furnitureStore.controller;

import com.example.furnitureStore.entity.Brand;
import com.example.furnitureStore.entity.Category;
import com.example.furnitureStore.service.BrandService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController()
@RequestMapping("/brand")
@RequiredArgsConstructor
public class BrandController {

    private final BrandService brandService;

    @GetMapping("")
    private ResponseEntity<Object> getAllBrand() {
        return brandService.getAllBrand();
    }

    @PostMapping("")
    private ResponseEntity<Object> addBrand(@RequestBody Brand newBrand) {
        return brandService.addBrand(newBrand);
    }

    @PutMapping("")
    private ResponseEntity<Object> updateBrand(@RequestBody Brand updatedBrand) {
        return brandService.updateBrand(updatedBrand);
    }

    @DeleteMapping("/{id}")
    private ResponseEntity<Object> deleteBrand(@PathVariable("id") Integer id) {
        return brandService.deleteBrand(id);
    }
}