package com.example.furnitureStore.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "product_image")
@Getter
@Setter
@ToString
@NoArgsConstructor
public class ProductImages {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "photo_1")
    @NotNull
    private String photo1;

    @Column(name = "photo_2")
    @NotNull
    private String photo2;

    @Column(name = "photo_3")
    @NotNull
    private String photo3;

    @Column(name = "photo_4")
    @NotNull
    private String photo4;

    @Column(name = "photo_5")
    @NotNull
    private String photo5;

    //Kapcsolatok
    @OneToOne(mappedBy = "images", cascade = {})
    @JsonIgnore
    private Product product;
}
