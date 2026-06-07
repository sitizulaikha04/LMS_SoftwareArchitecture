/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.schoollms.controller;

import com.schoollms.dao.UserDAO;
import com.schoollms.model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();

        user.setFullname(fullname);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        UserDAO dao = new UserDAO();

        if (dao.registerUser(user)) {

            response.sendRedirect("login.jsp?success=1");

        } else {

            response.sendRedirect("register.jsp?error=1");

        }
    }
}