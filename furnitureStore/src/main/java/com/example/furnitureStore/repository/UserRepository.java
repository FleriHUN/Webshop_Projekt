package com.example.furnitureStore.repository;

import com.example.furnitureStore.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {

    @Procedure(name = "getUserByUsername", procedureName = "getUserByUsername")
    Optional<User> getUserByUsername(@Param("usernameIN") String username);

    @Procedure(name = "getUserById", procedureName = "getUserById")
    Optional<User> getUserById(@Param("idIN") Integer id);

    @Procedure(name = "getUserByEmail", procedureName = "getUserByEmail")
    Optional<User> getUserByEmail(@Param("emailIN") String email);

    @Procedure(name = "deleteUserById", procedureName = "deleteUserById")
    void deleteUserById(@Param("idIN") Integer id);
}

