<%-- 
    Document   : viewSubmissions
    Description: Lecturer view of student submissions
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.schoollms.model.Submission"%>
<%@page import="com.schoollms.model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    if (!"Teacher".equals(user.getRole())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    List<Submission> submissions = (List<Submission>) request.getAttribute("submissions");

    int assignmentId = (request.getAttribute("assignmentId") != null)
            ? (Integer) request.getAttribute("assignmentId")
            : 0;
            
    String msg = request.getParameter("msg"); // Ambil parameter status mesej simpan
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Submissions | SchoolLMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f8fafc; padding: 30px; }
        .card-box { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); border: 1px solid #e2e8f0; }
        .file-link { text-decoration: none; color: #0d6efd; font-weight: 600; display: inline-flex; align-items: center; gap: 6px; }
        .file-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <%-- FIXED: Memicu mesej alert terapung sekiranya penanda 'saved' aktif --%>
    <% if ("saved".equals(msg)) { %>
        <div class="alert alert-success border-0 shadow-sm rounded-3 alert-dismissible fade show mb-4" role="alert">
            ✨ <strong>Successfully saved!</strong> The assignment grade and feedback have been updated to the student's profile.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">📂 Assignment Submissions</h3>
            <p class="text-muted small mb-0">Managing submissions for Assignment ID: #<%= assignmentId %></p>
        </div>
        <a href="AssignmentServlet" class="btn btn-outline-secondary btn-sm px-3 rounded-pill fw-semibold">
            ← Back to Ledger
        </a>
    </div>

    <div class="card-box">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="py-3">Submission ID</th>
                        <th class="py-3">Student ID</th>
                        <th class="py-3">Submitted File Resource</th>
                        <th class="py-3">Submission Description</th> <%-- FIXED: Tambah Header Kolum Deskripsi --%>
                        <th class="py-3">Submit Date</th>
                        <th class="py-3" style="width: 150px;">Grade (100)</th>
                        <th class="py-3">Feedback Comments</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (submissions != null && !submissions.isEmpty()) {
                        for (Submission s : submissions) {
                %>
                    <tr>
                        <td class="fw-semibold text-secondary">#<%= s.getSubmissionId() %></td>
                        <td><span class="badge bg-secondary">Student #<%= s.getStudentId() %></span></td>
                        <td>
                            <a class="file-link" href="DownloadFileServlet?submissionId=<%= s.getSubmissionId() %>">
                                📄 <%= s.getFileName() %>
                            </a>
                        </td>
                        
                        <%-- FIXED: Memaparkan teks deskripsi komit asal milik student --%>
                        <td class="small text-dark-emphasis fw-medium">
                            <%= (s.getSubmissionNotes() == null || s.getSubmissionNotes().trim().isEmpty()) ? "<span class='text-muted italic small'>No description.</span>" : s.getSubmissionNotes() %>
                        </td>
                        
                        <td class="small text-muted"><%= s.getSubmitDate() %></td>
                        
                        <td colspan="2">
                            <form action="GradeSubmissionServlet" method="post" class="m-0">
                                <input type="hidden" name="submissionId" value="<%= s.getSubmissionId() %>">
                                <input type="hidden" name="assignmentId" value="<%= assignmentId %>">
                                
                                <div class="row g-2">
                                    <div class="col-md-4">
                                        <input type="number" step="0.01" min="0" max="100" name="grade" 
                                               value="<%= s.getGrade() %>" class="form-control form-control-sm rounded-3" required>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="d-flex gap-2">
                                            <textarea name="feedback" class="form-control form-control-sm rounded-3" 
                                                      rows="1" placeholder="Add custom feedback..."><%= s.getFeedback() == null ? "" : s.getFeedback() %></textarea>
                                            <button type="submit" class="btn btn-success btn-sm px-3 rounded-3 fw-semibold">Save</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="7" class="text-center text-muted py-4">No submissions found for this assignment active status.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>