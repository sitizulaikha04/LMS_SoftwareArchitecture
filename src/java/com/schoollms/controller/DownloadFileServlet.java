package com.schoollms.controller;

import com.schoollms.dao.SubmissionDAO;
import com.schoollms.model.Submission;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DownloadFileServlet")
public class DownloadFileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String submissionIdStr = request.getParameter("submissionId");
        if (submissionIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing Submission ID");
            return;
        }

        int submissionId = Integer.parseInt(submissionIdStr);
        SubmissionDAO dao = new SubmissionDAO();
        Submission submission = dao.getSubmissionById(submissionId);

        if (submission != null && submission.getFilePath() != null) {
            File file = new File(submission.getFilePath());
            
            if (file.exists()) {
                String mimeType = getServletContext().getMimeType(file.getAbsolutePath());
                if (mimeType == null) {        
                    mimeType = "application/octet-stream";
                }
                response.setContentType(mimeType);
                response.setContentLength((int) file.length());
                
                String headerKey = "Content-Disposition";
                String headerValue = String.format("attachment; filename=\"%s\"", submission.getFileName());
                response.setHeader(headerKey, headerValue);
                
                try (FileInputStream inStream = new FileInputStream(file);
                     OutputStream outStream = response.getOutputStream()) {
                     
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = inStream.read(buffer)) != -1) {
                        outStream.write(buffer, 0, bytesRead);
                    }
                }
            } else {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script>alert('File not found in the storage.'); window.history.back();</script>");
            }
        } else {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('Submission record doesn't exist.); window.history.back();</script>");
        }
    }
}