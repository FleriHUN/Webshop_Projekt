package com.example.furnitureStore.service;

import com.example.furnitureStore.entity.Cart;
import com.example.furnitureStore.entity.CartProduct;
import com.example.furnitureStore.entity.Product;
import com.example.furnitureStore.entity.User;
import com.example.furnitureStore.repository.CartProductRepository;
import com.example.furnitureStore.repository.CartRepository;
import com.example.furnitureStore.repository.ProductRepository;
import com.example.furnitureStore.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class CartService {
    private final CartRepository cartRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final CartProductRepository cartProductRepository;

    public ResponseEntity<Object> getCartByUserId(Integer userId) {
        try {
            if (userId == null) {
                return ResponseEntity.status(422).build();
            }

            User searchedUser = userRepository.findById(userId).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }

            Cart cart = cartRepository.getCartByUserId(userId).orElse(null);
            cart.setCartProductList(cart.getCartProductList());
            return ResponseEntity.ok().body(cart);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> deleteProductFromCart(Integer cartProductId, Integer userId) {
        try {
            if (cartProductId == null || userId == null) {
                return ResponseEntity.status(422).build();
            }

            Cart searchedCart = cartRepository.getCartByUserId(userId).orElse(null);
            if (searchedCart == null) {
                return ResponseEntity.status(404).body("basketNotFound");
            }
            CartProduct searchedProduct = cartProductRepository.findById(cartProductId).orElse(null);
            if (searchedProduct == null) {
                return ResponseEntity.status(404).body("productNotFound");
            }

            cartProductRepository.deleteProductFromCart(searchedProduct.getId());
            searchedProduct.getCartProduct().setAmount(searchedProduct.getCartProduct().getAmount() + searchedProduct.getAmount());
            productRepository.save(searchedProduct.getCartProduct());

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> changeAmountOfProduct(Integer userId, Integer productId, Integer newAmount) {
        try {
            if (userId == null || productId == 0 || newAmount == -1) {
                return ResponseEntity.status(422).build();
            }

            Cart searchedCart = cartRepository.getCartByUserId(userId).orElse(null);
            CartProduct searchedBasketProduct = cartProductRepository.findById(productId).orElse(null);

            if (searchedCart == null) {
                return ResponseEntity.status(404).body("basketNotFound");
            } else if (searchedBasketProduct == null) {
                return ResponseEntity.status(404).body("bookNotFound");
            } else if (newAmount > searchedBasketProduct.getCartProduct().getAmount() || newAmount < 0) {
                return ResponseEntity.status(415).body("invalidAmount");
            } else if (newAmount == 0) {
                cartProductRepository.deleteProductFromCart(searchedBasketProduct.getId());
                searchedBasketProduct.getCartProduct().setAmount(searchedBasketProduct.getCartProduct().getAmount() + searchedBasketProduct.getAmount());
                productRepository.save(searchedBasketProduct.getCartProduct());
            } else {
                searchedBasketProduct.setAmount(newAmount);
                cartProductRepository.save(searchedBasketProduct);
            }

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> clearCart(Integer cartId) {
        try {
            if (cartId == null) {
                return ResponseEntity.status(422).build();
            }
            Cart searchedCart = cartRepository.findById(cartId).orElse(null);
            if (searchedCart == null) {
                return ResponseEntity.notFound().build();
            }

            cartRepository.clearCart(cartId);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> addProductToCart(Integer productId, Integer amount, Integer userId) {
        try {
            if (productId == 0 || userId == null || amount == -1) {
                return ResponseEntity.status(422).build();
            }

            Cart searchedCart = cartRepository.getCartByUserId(userId).orElse(null);
            if (searchedCart == null) {
                return ResponseEntity.notFound().build();
            }

            Product searchedProduct = productRepository.findById(productId).orElse(null);
            if (searchedProduct == null) {
                return ResponseEntity.notFound().build();
            }

            if (amount > searchedProduct.getAmount()) {
                return ResponseEntity.status(415).body("");
            }

            cartProductRepository.save(new CartProduct(amount, searchedProduct, searchedCart));
            cartRepository.save(searchedCart);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
