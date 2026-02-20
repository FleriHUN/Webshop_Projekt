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
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "user")
@Getter
@Setter
@ToString
@NoArgsConstructor
@NamedStoredProcedureQuery(name = "login", procedureName = "login", parameters = {
        @StoredProcedureParameter(name = "emailIN", mode = ParameterMode.IN, type = String.class),
        @StoredProcedureParameter(name = "passwordIN", mode = ParameterMode.IN, type = String.class),
}, resultClasses = User.class)
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "username")
    @NotNull
    @Size(max = 100)
    private String username;

    @Column(name = "com/example/furnitureStore/config/email")
    @Size(max = 255)
    @NotNull
    private String email;

    @Column(name = "phone")
    @Size(max = 255)
    @NotNull
    private String phone;

    @Column(name = "password")
    @NotNull
    private String password;

    @Column(name = "pfp_path")
    @NotNull
    private String pfpPath = "";

    @Column(name = "is_deleted")
    private Boolean isDeleted = false;

    @Column(name = "deleted_at")
    @Null
    private LocalDateTime deletedAt;

    @Column(name = "last_login")
    @Null
    private LocalDateTime lastLogin;

    @Column(name = "register_finished_at")
    private Date registerFinishedAt;

    //Kapcsolatok:
    @OneToMany(mappedBy = "author", fetch = FetchType.LAZY, cascade = {})
    @JsonIgnoreProperties({"author"})
    @Null
    private List<Review> reviewList;

    @OneToMany(mappedBy = "orderUser", fetch = FetchType.LAZY, cascade = {})
    @Null
    @JsonIgnoreProperties({"orderUser"})
    private List<OrderHistory> orderHistoryList;

    @OneToMany(mappedBy = "cancelerUser", fetch = FetchType.LAZY, cascade = {})
    @JsonIgnore
    @Null
    private List<OrderHistory> canceledOrderHistory;

    @OneToOne(mappedBy = "cartUser", fetch = FetchType.LAZY, cascade = {})
    private Cart cart;

    @ManyToOne(cascade = {})
    @JoinColumn(name = "role_id")
    private Role role;
}
