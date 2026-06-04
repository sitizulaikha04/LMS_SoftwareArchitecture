/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lms.dao;

import java.sql.Connection;
import java.sql.DriverManager;
/**
 *
 * @author ACER
 */
public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3307/LMS";

    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() {

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

            System.out.println("Database Connected!");

        } catch (Exception e) {

            e.printStackTrace();
        }

        return con;
    }
}