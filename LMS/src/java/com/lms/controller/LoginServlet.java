/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.lms.controller;

import com.lms.dao.UserDAO;
import com.lms.model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
/**
 *
 * @author ACER
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        UserDAO dao = new UserDAO();

        User user =
                dao.login(email, password);

        if (user != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "userSession",
                    user
            );

            response.sendRedirect(
                    "dashboard.jsp"
            );

        } else {

            response.sendRedirect(
                    "index.jsp?msg=Invalid Login"
            );
        }
    }
}