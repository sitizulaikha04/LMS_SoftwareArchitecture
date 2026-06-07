/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.schoollms.dao;

import com.schoollms.model.User;
import com.schoollms.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public boolean registerUser(User user) {

        boolean status = false;

        try {

            Connection conn = DBConnection.getConnection();

            String sql =
                    "INSERT INTO users(fullname,email,password,role) VALUES(?,?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());

            int row = ps.executeUpdate();

            if(row > 0){
                status = true;
            }

        } catch(Exception e){
            System.out.println(e);
            return false;
        }

        return status;
    }

    public User login(String email,String password){

        User user = null;

        try{

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1,email);
            ps.setString(2,password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setFullname(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));

            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return user;
    }

}