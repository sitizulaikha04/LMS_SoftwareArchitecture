/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.schoollms.controller;

import com.schoollms.dao.SubmissionDAO;
import com.schoollms.model.Submission;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewSubmissionsServlet")
public class ViewSubmissionsServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get assignment ID from URL
        String assignmentIdStr =
                request.getParameter("assignmentId");

        // Safety check
        if (assignmentIdStr == null) {
            response.sendRedirect("AssignmentServlet");
            return;
        }

        int assignmentId =
                Integer.parseInt(assignmentIdStr);

        // DAO call
        SubmissionDAO dao =
                new SubmissionDAO();

        List<Submission> submissions =
                dao.getSubmissionsByAssignment(
                        assignmentId);

        // Send data to JSP
        request.setAttribute(
                "submissions",
                submissions);

        request.setAttribute(
                "assignmentId",
                assignmentId);

        // Forward to view page
        request.getRequestDispatcher(
                "viewSubmissions.jsp")
                .forward(request, response);
    }
}