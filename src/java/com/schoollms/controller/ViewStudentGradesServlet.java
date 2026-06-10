package com.schoollms.controller;

import com.schoollms.dao.SubmissionDAO;
import com.schoollms.model.Submission;
import com.schoollms.model.User;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewStudentGradesServlet")
public class ViewStudentGradesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"Student".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        SubmissionDAO dao = new SubmissionDAO();
        List<Submission> studentSubmissions = dao.getSubmissionsByStudent(user.getUserId());

        request.setAttribute("studentSubmissions", studentSubmissions);
        request.getRequestDispatcher("studentGrades.jsp").forward(request, response);
    }
}