package com.lms.model;

public class User {
    private String email;
    private String password;
    private String role;

    public User(String email, String password, String role) {
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Getter untuk akses data
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
}
