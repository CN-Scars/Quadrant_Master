package com.scars.quadrant_master_backend.repository;

import com.scars.quadrant_master_backend.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
