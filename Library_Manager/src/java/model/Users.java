/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author MSI
 */
public class Users {
    private int id;
    private String name;
    private String username;
    private String password;
    private String email;
   
    private String role;
   

    public Users() {
    }

    public Users(int id, String name, String username, String password, String email, String role) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.password = password;
        this.email = email;
        this.role = role;
    }

   

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String usernname) {
        this.username = usernname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }



    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

   
    
    
    
    
}

