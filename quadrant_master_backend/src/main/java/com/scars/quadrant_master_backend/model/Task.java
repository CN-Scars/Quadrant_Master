package com.scars.quadrant_master_backend.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Task {

    @Id
    private String id;
    private String title;
    private String description;
    private LocalDateTime dueDate;
    private int quadrant;
    private boolean isCompleted;
    private LocalDateTime completedAt;
    private int priority;

    // Getters and Setters

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDateTime dueDate) {
        this.dueDate = dueDate;
    }

    public int getQuadrant() {
        return quadrant;
    }

    public void setQuadrant(int quadrant) {
        this.quadrant = quadrant;
    }

    public boolean isCompleted() {
        return isCompleted;
    }

    public void setCompleted(boolean completed) {
        isCompleted = completed;
    }

    public LocalDateTime getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(LocalDateTime completedAt) {
        this.completedAt = completedAt;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }
}
