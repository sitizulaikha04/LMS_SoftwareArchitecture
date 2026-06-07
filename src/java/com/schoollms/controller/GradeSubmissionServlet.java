/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.schoollms.controller;

import com.schoollms.dao.SubmissionDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/GradeSubmissionServlet")
public class GradeSubmissionServlet
        extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int submissionId =
                Integer.parseInt(
                        request.getParameter(
                                "submissionId"));

        double grade =
                Double.parseDouble(
                        request.getParameter(
                                "grade"));

        String feedback =
                request.getParameter(
                        "feedback");

        SubmissionDAO dao =
                new SubmissionDAO();

        dao.gradeSubmission(
                submissionId,
                grade,
                feedback);

        response.sendRedirect(
                request.getHeader("referer"));
    }
}