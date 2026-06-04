package com.lms.controller;

import com.lms.dao.UserDAO;
import com.lms.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LmsController")
public class LmsController extends HttpServlet {

    UserDAO dao = new UserDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        HttpSession session =
                request.getSession();

        if ("register".equals(action)) {

            String email =
                    request.getParameter("email");

            String password =
                    request.getParameter("password");

            String role =
                    request.getParameter("role");

            User user =
                new User(email,password,role);

            if (dao.register(user)) {

                response.sendRedirect(
                        "index.jsp?msg=Registration Success");

            } else {

                response.sendRedirect(
                        "index.jsp?msg=Registration Failed");
            }

        }

        else if ("login".equals(action)) {

            String email =
                    request.getParameter("email");

            String password =
                    request.getParameter("password");

            User user =
                    dao.login(email,password);

            if(user != null){

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

        else if ("logout".equals(action)) {

            session.invalidate();

            response.sendRedirect("index.jsp");
        }
    }
}