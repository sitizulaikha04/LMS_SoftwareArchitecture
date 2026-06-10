package com.schoollms.controller;

import com.schoollms.dao.SubmissionDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GradeSubmissionServlet")
public class GradeSubmissionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String submissionIdStr = request.getParameter("submissionId");
        String gradeStr = request.getParameter("grade");
        String feedback = request.getParameter("feedback");
        String assignmentIdStr = request.getParameter("assignmentId");

        if (submissionIdStr == null || submissionIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing Submission ID");
            return;
        }

        try {
            int submissionId = Integer.parseInt(submissionIdStr.trim());
            double grade = 0.0;
            
            if (gradeStr != null && !gradeStr.trim().isEmpty()) {
                grade = Double.parseDouble(gradeStr.trim());
            }

            SubmissionDAO dao = new SubmissionDAO();
            boolean success = dao.gradeSubmission(submissionId, grade, feedback);

            if (success) {
                // FIXED: Ditambah parameter msg=saved untuk memicu notifikasi kejayaan
                if (assignmentIdStr != null && !assignmentIdStr.trim().isEmpty()) {
                    response.sendRedirect("ViewSubmissionsServlet?assignmentId=" + assignmentIdStr.trim() + "&msg=saved");
                } else {
                    response.sendRedirect("AssignmentServlet");
                }
            } else {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script>alert('Gagal mengemas kini gred.'); window.history.back();</script>");
            }

        } catch (NumberFormatException e) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('Format gred atau ID tidak sah.'); window.history.back();</script>");
        }
    }
}