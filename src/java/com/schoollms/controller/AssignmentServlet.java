/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.schoollms.controller;

import com.schoollms.dao.AssignmentDAO;
import com.schoollms.model.Assignment;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AssignmentServlet")
public class AssignmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String courseIdStr = request.getParameter("courseId");
    AssignmentDAO dao = new AssignmentDAO();
    List<Assignment> list;

    if (courseIdStr != null) {
        // Fetch only for the selected course
        list = dao.getAssignmentsByCourse(Integer.parseInt(courseIdStr));
    } else {
        // Fallback: fetch all if no ID is provided
        list = dao.getAllAssignments();
    }

    request.setAttribute("assignments", list);
    request.getRequestDispatcher("assignments.jsp").forward(request, response);
}

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

        dao.addAssignment(assignment);

        response.sendRedirect(
                "AssignmentServlet");
    }
}