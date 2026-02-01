package com.example.furnitureStore.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.Null;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "cart")
@Getter
@Setter
@ToString
@NoArgsConstructor
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "last_modified")
    private LocalDateTime lastModified;

    @Column(name = "created_at")
    private Date createdAt;

    //Kapcsolatok
    @ManyToOne(cascade = {})
    @JoinColumn(name = "user_id")
    @JsonIgnore
    private User cartUser;

    @OneToMany(mappedBy = "cart", fetch = FetchType.LAZY, cascade = {})
    @JsonIgnoreProperties({"cart", "brand"})
    private List<CartProduct> cartProductList;
}

