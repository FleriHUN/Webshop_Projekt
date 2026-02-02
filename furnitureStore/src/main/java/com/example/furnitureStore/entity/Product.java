package com.example.furnitureStore.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "product")
@Getter
@Setter
@ToString
@NoArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "name")
    @NotNull
    @Size(max = 100)
    private String name;

    @Column(name = "description")
    @NotNull
    private String description;

    @Column(name = "height_in_cm")
    @NotNull
    private Double heightInCm;

    @Column(name = "width_in_cm")
    @NotNull
    private Double widthInCm;

    @Column(name = "depth_in_cm")
    @NotNull
    private Double depthInCm;@Column(name = "weight_in_kg")
    @NotNull
    private Double weightInKg;

    @Column(name = "price")
    @NotNull
    @Size(max = 6)
    private Integer price;

    @Column(name = "is_deleted")
    @JsonIgnore
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    @Null
    private Date deletedAt;

    //
    @ManyToOne(cascade = {})
    @JoinColumn(name = "brand_id")
    @JsonIgnoreProperties({"productList"})
    private Brand brand;

    @OneToOne(cascade = {})
    @JoinColumn(name = "photo_list_id")
    private ProductImages images;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = {})
    private List<Review> productReviewList;

    @OneToMany(mappedBy = "orderProduct", fetch = FetchType.LAZY, cascade = {})
    @JsonIgnore
    private List<OrderProduct> orderHistoryList;

    @ManyToMany(fetch = FetchType.LAZY, cascade = {}, mappedBy = "productList")
    @JsonIgnoreProperties({"productList"})
    private List<Category> categories;

    @OneToMany(mappedBy = "cartProduct", fetch = FetchType.LAZY, cascade = {})
    @JsonIgnore
    private List<CartProduct> cartProductList;

}
