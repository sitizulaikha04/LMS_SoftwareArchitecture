package com.schoollms.controller;

import com.schoollms.dao.SubmissionDAO;
import com.schoollms.model.Submission;
import com.schoollms.model.User;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SubmitAssignmentServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 20
)
public class SubmitAssignmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
        String submissionNotes = request.getParameter("submissionNotes"); // Menangkap deskripsi hantaran

        Part filePart = request.getPart("assignmentFile");
        String fileName = filePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String fullPath = uploadPath + File.separator + fileName;
        filePart.write(fullPath);

        Submission submission = new Submission();
        submission.setAssignmentId(assignmentId);
        submission.setStudentId(user.getUserId());
        submission.setFileName(fileName);
        submission.setFilePath(fullPath);
        submission.setSubmissionNotes(submissionNotes); // Simpan deskripsi ke objek model

        SubmissionDAO dao = new SubmissionDAO();
        dao.submitAssignment(submission);

        response.sendRedirect("AssignmentServlet");
    }
}