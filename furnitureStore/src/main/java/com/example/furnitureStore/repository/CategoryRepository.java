package com.example.furnitureStore.repository;

import com.example.furnitureStore.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
    //
    @Procedure(name = "getParentCategories", procedureName = "getParentCategories")
    List<Category> getParentCategories();

    @Procedure(name = "getSubCategoriesOfParentCategory", procedureName = "getSubCategoriesOfParentCategory")
    List<Category> getSubCategoriesOfParentCategory(@Param("idIN") Integer id);
}
