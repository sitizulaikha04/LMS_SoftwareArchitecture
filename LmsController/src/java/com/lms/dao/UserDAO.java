package com.lms.dao;

import com.lms.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public boolean register(User user) {

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                "INSERT INTO users(email,password,role) VALUES(?,?,?)";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public User login(String email, String password) {

        try {

            Connection con = DBConnection.getConnection();

            String sql =
              "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps =
              con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                User u = new User();

                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));

                return u;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}