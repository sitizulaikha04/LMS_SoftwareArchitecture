/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lms.dao;

import com.lms.model.User;
import java.sql.*;
/**
 *
 * @author ACER
 */
public class UserDAO {

    public boolean registerUser(User user) {

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "INSERT INTO users(email,password,role) VALUES(?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1,
                    user.getEmail());

            ps.setString(2,
                    user.getPassword());

            ps.setString(3,
                    user.getRole());

            return ps.executeUpdate() > 0;

        } catch(Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    public User login(
            String email,
            String password
    ) {

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                User user =
                        new User();

                user.setUserId(
                        rs.getInt("user_id")
                );

                user.setEmail(
                        rs.getString("email")
                );

                user.setRole(
                        rs.getString("role")
                );

                return user;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return null;
    }
}