package com.example.furnitureStore.service;

import com.example.furnitureStore.entity.Product;
import com.example.furnitureStore.entity.Review;
import com.example.furnitureStore.entity.User;
import com.example.furnitureStore.repository.ProductRepository;
import com.example.furnitureStore.repository.ReviewRepository;
import com.example.furnitureStore.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@Transactional
@RequiredArgsConstructor
public class ReviewService {

    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final ReviewRepository reviewRepository;

    public ResponseEntity<Object> addReview(Review newReview) {
        try {
            if (newReview == null) {
                return ResponseEntity.status(422).build();
            }

            Product searchedProduct = productRepository.findById(newReview.getProduct().getId()).orElse(null);
            User author = userRepository.getUserById(newReview.getAuthor().getId()).orElse(null);

            if (searchedProduct == null || searchedProduct.getIsDeleted()) {
                return ResponseEntity.status(404).body("bookNotFound");
            } else if (author == null || author.getIsDeleted()) {
                return ResponseEntity.status(404).body("authorNotFound");
            }

            if (newReview.getRating() > 5 || newReview.getRating() < 1) {
                return ResponseEntity.status(415).body("invalidRating");
            } else if (newReview.getId() != null) {
                return ResponseEntity.status(415).body("invalidObject");
            }

            return ResponseEntity.ok().body(reviewRepository.save(newReview));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz
    public ResponseEntity<Object> updateReview(Integer reviewId, String updatedText) {
        try {
            if (reviewId == 0 || updatedText == null) {
                return ResponseEntity.status(422).build();
            }

            Review searchedReview = reviewRepository.findById(reviewId).orElse(null);
            if (searchedReview == null || searchedReview.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }
            searchedReview.setReviewText(updatedText.trim());

            return ResponseEntity.ok().body(reviewRepository.save(searchedReview));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    //kesz
    public ResponseEntity<Object> deleteReview(Integer id) {
        try {
            if (id == null) {
                return ResponseEntity.status(422).build();
            }
            Review searchedReview = reviewRepository.findById(id).orElse(null);
            if (searchedReview == null || searchedReview.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }

            searchedReview.setIsDeleted(true);
            searchedReview.setDeletedAt(LocalDateTime.now());
            reviewRepository.save(searchedReview);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
