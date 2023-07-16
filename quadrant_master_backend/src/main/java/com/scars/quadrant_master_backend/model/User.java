package com.scars.quadrant_master_backend.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.*;
import java.util.List;

// 使用 @Entity 注解标记这个类是一个 JPA 实体，对应数据库中的一个表。
@Entity
public class User {

    // 使用 @Id 注解标记这个字段是实体的主键。
    // 使用 @GeneratedValue 注解指定主键的生成策略。这里的策略是 IDENTITY，表示主键的值由数据库自动生成。
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 用户名和密码字段
    private String username;
    private String password;

    @OneToMany(mappedBy = "user")
    private List<Task> tasks;

    public User() {
    }

    // Getter 和 Setter 方法

    // getId 返回这个用户的 id。由于 id 是数据库自动生成的，所以我们通常只需要一个 getter 方法，不需要 setter 方法。
    public Long getId() {
        return id;
    }

    // setId 用来设置用户的 id。虽然在这个例子中我们不会直接使用它，但是 JPA 框架在内部需要用到它。
    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Task> getTasks() {
        return tasks;
    }

    public void setTasks(List<Task> tasks) {
        this.tasks = tasks;
    }
}
