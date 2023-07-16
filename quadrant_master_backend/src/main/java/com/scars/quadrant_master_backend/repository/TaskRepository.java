package com.scars.quadrant_master_backend.repository;

import com.scars.quadrant_master_backend.model.Task;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TaskRepository extends JpaRepository<Task, String> {
    List<Task> findByQuadrantAndIsCompleted(int quadrant, boolean isCompleted);
}
