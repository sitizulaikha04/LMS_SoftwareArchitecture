/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.schoollms.controller;

import com.schoollms.dao.AssignmentDAO;
import com.schoollms.dao.SubmissionDAO;
import com.schoollms.model.Assignment;
import com.schoollms.model.User;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AssignmentServlet")
public class AssignmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String courseIdStr =
                request.getParameter("courseId");

        AssignmentDAO dao =
                new AssignmentDAO();

        List<Assignment> list;

        if (courseIdStr != null) {

            list =
                    dao.getAssignmentsByCourse(
                            Integer.parseInt(courseIdStr));

        } else {

            list =
                    dao.getAllAssignments();
        }

        request.setAttribute(
                "assignments",
                list);

        // ==========================
        // NEW PART FOR STUDENT STATUS
        // ==========================

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute("user");

        if (user != null
                && user.getRole().equals("Student")) {

            SubmissionDAO submissionDAO =
                    new SubmissionDAO();

            List<Integer> submittedAssignments =
                    new ArrayList<>();

            for (Assignment a : list) {

                boolean submitted =
                        submissionDAO.hasSubmitted(
                                a.getAssignmentId(),
                                user.getUserId());

                if (submitted) {

                    submittedAssignments.add(
                            a.getAssignmentId());
                }
            }

            request.setAttribute(
                    "submittedAssignments",
                    submittedAssignments);
        }

        request.getRequestDispatcher(
                "assignments.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Assignment assignment =
                new Assignment();

        assignment.setCourseId(
                Integer.parseInt(
                        request.getParameter("courseId")));

        assignment.setTitle(
                request.getParameter("title"));

        assignment.setDescription(
                request.getParameter("description"));

        assignment.setDueDate(
                Date.valueOf(
                        request.getParameter("dueDate")));

        AssignmentDAO dao =
                new AssignmentDAO();

        dao.addAssignment(
                assignment);

        response.sendRedirect(
                "AssignmentServlet");
    }
}