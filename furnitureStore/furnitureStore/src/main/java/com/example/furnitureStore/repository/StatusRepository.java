package com.example.furnitureStore.repository;

import com.example.furnitureStore.entity.Status;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatusRepository extends JpaRepository<Status, Integer> {
}
