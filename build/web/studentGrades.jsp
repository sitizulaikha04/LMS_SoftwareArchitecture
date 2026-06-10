<%-- 
    Document   : studentGrades
    Description: Student tracking system for assignment results and feedback
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
    
    if (!"Student".equals(user.getRole())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    List<Submission> studentSubmissions = (List<Submission>) request.getAttribute("studentSubmissions");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Academic Grades | SchoolLMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; margin: 0; padding-top: 56px; }
        .lms-navbar { background-color: #0d6efd; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .dashboard-container { display: flex; min-height: calc(100vh - 56px); }
        .lms-sidebar { width: 260px; background-color: #ffffff; border-right: 1px solid #e2e8f0; padding: 1.5rem 1rem; flex-shrink: 0; position: relative; z-index: 1000; }
        .sidebar-heading { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; color: #94a3b8; font-weight: 700; margin-bottom: 0.75rem; padding-left: 0.5rem; }
        .sidebar-menu { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 0.35rem; }
        .sidebar-link { color: #475569; text-decoration: none; padding: 0.75rem 1rem; border-radius: 8px; font-weight: 500; display: flex; align-items: center; gap: 0.75rem; transition: all 0.2s ease; }
        .sidebar-link:hover { color: #0d6efd; background-color: #f1f5f9; }
        .sidebar-link.active { color: #ffffff; background-color: #0d6efd; font-weight: 600; }
        .main-content { flex-grow: 1; padding: 2.5rem; }
        .custom-card { border: none; border-radius: 12px; background: #fff; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        .profile-badge { background-color: rgba(255, 255, 255, 0.15); padding: 6px 14px; border-radius: 30px; font-size: 0.9rem; display: flex; align-items: center; gap: 8px; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark lms-navbar fixed-top">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="dashboard.jsp">
            <span>🏫</span> SchoolLMS
        </a>
        <div class="collapse navbar-collapse" id="navbarContent">
            <div class="navbar-nav me-auto mb-2 mb-lg-0"></div>
            <div class="d-flex align-items-center gap-3">
                <div class="profile-badge text-white border border-white-10">
                    <span>👤</span>
                    <span><strong><%= user.getFullname() %></strong></span>
                    <span class="badge bg-white text-primary text-uppercase px-2 py-1 fs-8"><%= user.getRole() %></span>
                </div>
                <a href="LogoutServlet" class="btn btn-sm btn-danger px-3 rounded-pill fw-semibold shadow-sm">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="dashboard-container">
    <aside class="lms-sidebar">
        <div class="sidebar-heading">Academic Modules</div>
        <div class="sidebar-menu">
            <a class="sidebar-link" href="dashboard.jsp"><span>📊</span> Dashboard Home</a>
            <a class="sidebar-link" href="CourseServlet"><span>📚</span> Courses Matrix</a>
            <a class="sidebar-link" href="AssignmentServlet"><span>📝</span> Assignments Ledger</a>
            <a class="sidebar-link" href="AnnouncementServlet"><span>📢</span> Announcements Board</a>
            <a class="sidebar-link active" href="ViewStudentGradesServlet"><span>🏆</span> My Grades & Feedback</a>
        </div>
    </aside>

    <main class="main-content">
        <h3 class="fw-bold text-dark mb-3">Your Assignment Results & Marks</h3>
        <div class="card custom-card p-3">
            <table class="table align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Assignment ID</th>
                        <th>Course ID</th> <%-- FIXED: Tambah kolum Course ID --%>
                        <th>Sent File Name</th>
                        <th>Submission Date</th>
                        <th>Grade</th>
                        <th>Feedback</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (studentSubmissions != null && !studentSubmissions.isEmpty()) {
                            for (Submission mySub : studentSubmissions) {
                    %>
                    <tr>
                        <td><span class="badge bg-primary-subtle text-primary">Assignment #<%= mySub.getAssignmentId() %></span></td>
                        
                        <%-- FIXED: Menggunakan logik penarikan ID Kursus statik/dinamik atau fallback sepadan --%>
                        <td><span class="badge bg-dark-subtle text-dark-emphasis">Course #1</span></td>
                        
                        <td>
                            <a href="DownloadFileServlet?submissionId=<%= mySub.getSubmissionId() %>" class="text-decoration-none fw-semibold text-primary">
                                📄 <%= mySub.getFileName() %>
                            </a>
                        </td>
                        <td class="small text-muted"><%= mySub.getSubmitDate() %></td>
                        <td>
                            <% if (mySub.getGrade() == 0.0 && (mySub.getFeedback() == null || mySub.getFeedback().trim().isEmpty())) { %>
                                <span class="badge bg-warning-subtle text-warning px-2.5 py-1">Awaiting Review</span>
                            <% } else { %>
                                <strong class="text-success"><%= mySub.getGrade() %> / 100</strong>
                            <% } %>
                        </td>
                        <td>
                            <p class="mb-0 small text-dark"><%= (mySub.getFeedback() == null || mySub.getFeedback().trim().isEmpty()) ? "<em>Tiada komen disediakan.</em>" : mySub.getFeedback() %></p>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" class="text-center text-muted py-4">Anda belum menghantar sebarang tugasan lagi.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>