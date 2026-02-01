package com.example.furnitureStore.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name = "order_product")
@Getter
@Setter
@ToString
@NoArgsConstructor
public class OrderProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "modified_at")
    @Null
    private LocalDateTime modifiedAt;

    @Column(name = "amount")
    @NotNull
    private Integer amount;

    //Kapcsolatok:
    @ManyToOne(cascade = {})
    @JoinColumn(name = "product_id")
    @JsonIgnoreProperties({"productReviewList", "cartProductList"})
    private Product orderProduct;

    @ManyToOne(cascade = {})
    @JoinColumn(name = "order_id")
    private OrderHistory orderHistory;
}
