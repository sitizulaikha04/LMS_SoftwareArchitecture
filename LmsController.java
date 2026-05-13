package com.lms.controller;

import com.lms.model.User;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LmsController", urlPatterns = {"/LmsController"})
public class LmsController extends HttpServlet {

    // Simpan data dalam senarai (Memory) sebagai ganti Database
    private static List<User> userDatabase = new ArrayList<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("register".equals(action)) {
            // PROSES REGISTER
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            userDatabase.add(new User(email, pass, "Student"));
            response.sendRedirect("index.jsp?msg=Registration Success! Please Login.");

        } else if ("login".equals(action)) {
            // PROSES LOGIN VALIDATION
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            
            User found = null;
            for (User u : userDatabase) {
                if (u.getEmail().equals(email) && u.getPassword().equals(pass)) {
                    found = u;
                    break;
                }
            }

            if (found != null) {
                session.setAttribute("userSession", found);
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("index.jsp?msg=WRONG Email or Password!");
            }

        } else if ("submitTask".equals(action)) {
            // PROSES ASSIGNMENT SUBMISSION
            String task = request.getParameter("taskName");
            response.sendRedirect("dashboard.jsp?status=Submission Successful : " + task);
        }
    }
}
