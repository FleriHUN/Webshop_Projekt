package repository;

import com.example.furnitureStore.entity.ProductImages;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductImagesRepository extends JpaRepository<ProductImages, Integer> {
}
