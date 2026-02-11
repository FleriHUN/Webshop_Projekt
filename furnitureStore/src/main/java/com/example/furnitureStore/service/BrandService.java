package com.example.furnitureStore.service;

import com.example.furnitureStore.entity.Brand;
import com.example.furnitureStore.repository.BrandRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.ConstraintViolationException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

@Service
@RequiredArgsConstructor
@Transactional(noRollbackFor = {DataIntegrityViolationException.class, ConstraintViolationException.class, SQLIntegrityConstraintViolationException.class, SQLException.class})
public class BrandService {

    private final BrandRepository brandRepository;

    public ResponseEntity<Object> getAllBrand() {
        try {
            return ResponseEntity.ok().body(brandRepository.findAll().stream().filter(brand -> !brand.isDeleted()).toList());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }

    } public ResponseEntity<Object> addBrand(Brand newBrand) {
        try {
            if (newBrand == null) {
                return ResponseEntity.status(422).build();
            }

            if (newBrand.getId() != null) {
                return ResponseEntity.status(415).body("invalidBrand");
            } else {
                return ResponseEntity.ok().body(brandRepository.save(newBrand));
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
