package com.schoollms.controller;

import com.schoollms.dao.UserDAO;
import com.schoollms.model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String expectedRole = request.getParameter("expectedRole");

        UserDAO dao = new UserDAO();
        User user = dao.login(email, password);

        if (user != null) {
            // Menyekat kemasukan sekiranya murid cuba masuk portal cikgu atau sebaliknya
            if (expectedRole != null && !expectedRole.equalsIgnoreCase("User") && !user.getRole().equalsIgnoreCase(expectedRole)) {
                response.sendRedirect("login.jsp?error=unauthorized&role=" + expectedRole);
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?error=invalid&role=" + expectedRole);
        }
    }
}