package com.example.furnitureStore.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name = "cart_product")
@Getter
@Setter
@ToString
@NoArgsConstructor
@NamedStoredProcedureQueries({
        @NamedStoredProcedureQuery(name = "deleteProductFromCart", procedureName = "deleteProductFromCart", parameters = {
                @StoredProcedureParameter(name = "idIN", mode = ParameterMode.IN, type = Integer.class)
        })
})
public class CartProduct {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "last_modified_at")
    private LocalDateTime lastModifiedAt;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "amount")
    @NotNull
    private Integer amount;

    //Kapcsolatok
    @ManyToOne
    @JoinColumn(name = "product_id")
    @JsonIgnoreProperties({"productReviewList", "orderHistoryList", "cartProductList"})
    private Product cartProduct;

    @ManyToOne
    @JoinColumn(name = "cart_id")
    @JsonIgnore
    private Cart cart;

    public CartProduct(Integer amount ,Product cartProduct, Cart cart) {
        this.amount = amount;
        this.cartProduct = cartProduct;
        this.cart = cart;
        createdAt = new Date();
    }
}
