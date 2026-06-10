<%-- 
    Document   : assignments
    Created on : 4 Jun 2026, 12:19:12 pm
    Author     : ADMIN
--%>

<%@page import="com.schoollms.dao.AssignmentDAO"%>
<%@page import="com.schoollms.dao.SubmissionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.schoollms.model.User"%>
<%@page import="com.schoollms.model.Assignment"%>
<%
    User user = (User)session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
    List<Assignment> assignments = (List<Assignment>) request.getAttribute("assignments");
    AssignmentDAO assignmentDao = new AssignmentDAO(); // Sediakan objek DAO untuk kegunaan skrip
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assignments Ledger | SchoolLMS</title>
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
        .notification-badge { display: inline-flex; align-items: center; justify-content: center; background-color: #dc3545; color: white; font-weight: 700; font-size: 0.75rem; min-width: 20px; height: 20px; padding: 0 6px; border-radius: 50%; margin-left: 8px; animation: pulse 2s infinite; }
        @keyframes pulse { 0% { transform: scale(1); } 50% { transform: scale(1.1); } 100% { transform: scale(1); } }
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
        <ul class="sidebar-menu">
            <li><a class="sidebar-link" href="dashboard.jsp"><span>📊</span> <span>Dashboard Home</span></a></li>
            <li><a class="sidebar-link" href="CourseServlet"><span>📚</span> <span>Courses Matrix</span></a></li>
            <li><a class="sidebar-link active" href="AssignmentServlet"><span>📝</span> <span>Assignments Ledger</span></a></li>
            <li><a class="sidebar-link" href="AnnouncementServlet"><span>📢</span> <span>Announcements Board</span></a></li>
            <% if (user != null && "Student".equals(user.getRole())) { %>
            <li><a class="sidebar-link" href="ViewStudentGradesServlet"><span>🏆</span> <span>My Grades & Feedback</span></a></li>
            <% } %>
        </ul>
    </aside>

    <main class="main-content">
        <% if("Teacher".equals(user.getRole())) { %>
        <div class="card custom-card mb-4 p-2">
            <div class="card-header bg-white fw-bold text-dark border-0 pt-3 fs-5">Publish New Assignment</div>
            <div class="card-body">
                <form action="AssignmentServlet" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="row g-3">
                        <div class="col-md-2"><label class="small fw-semibold text-secondary">Course ID</label><input type="number" name="courseId" class="form-control" required></div>
                        <div class="col-md-4"><label class="small fw-semibold text-secondary">Assignment Title</label><input type="text" name="title" class="form-control" required></div>
                        <div class="col-md-3"><label class="small fw-semibold text-secondary">Due Date</label><input type="date" name="dueDate" class="form-control" required></div>
                        <div class="col-md-12"><label class="small fw-semibold text-secondary">Description</label><textarea name="description" class="form-control" rows="2" required></textarea></div>
                    </div>
                    <button type="submit" class="btn btn-primary mt-3 px-4">Post Assignment</button>
                </form>
            </div>
        </div>
        <% } %>

        <h3 class="fw-bold text-dark mb-3">Assignment Ledger</h3>
        <div class="card custom-card p-3">
            <table class="table align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Assignment ID</th>
                        <th>Course ID</th>
                        <th>Title</th>
                        <th>Due Date</th>
                        <th>Description</th>
                        <th style="width: 340px;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(assignments != null) {
                        for(Assignment a : assignments) { %>
                        <tr>
                            <td class="fw-semibold text-secondary">#<%= a.getAssignmentId() %></td>
                            <td>#<%= a.getCourseId() %></td>
                            <td class="fw-bold text-dark"><%= a.getTitle() %></td>
                            <td><span class="badge bg-danger-subtle text-danger"><%= a.getDueDate() %></span></td>
                            <td class="small text-muted"><%= a.getDescription() %></td>
                            <td>
                            <% if(user.getRole().equals("Student")) { 
                                SubmissionDAO sdao = new SubmissionDAO();
                                boolean submitted = sdao.hasSubmitted(a.getAssignmentId(), user.getUserId());
                                if(submitted){ %>
                                <span class="badge bg-success px-3 py-1.5 fs-7 rounded-2">Submitted</span>
                            <% } else { %>
                            <form action="SubmitAssignmentServlet" method="post" enctype="multipart/form-data" class="p-2 border rounded-3 bg-light-subtle">
                                <input type="hidden" name="assignmentId" value="<%= a.getAssignmentId() %>">
                                <div class="mb-1.5">
                                    <label class="form-label d-block text-secondary fw-bold small mb-1">Choose Submission File:</label>
                                    <input type="file" name="assignmentFile" class="form-control form-control-sm" required>
                                </div>
                                <div class="mb-2">
                                    <label class="form-label d-block text-secondary fw-bold small mb-1">Submission Description:</label>
                                    <input type="text" name="submissionNotes" class="form-control form-control-sm placeholder-sm" placeholder="e.g., Final draft upload" required>
                                </div>
                                <button type="submit" class="btn btn-success btn-sm w-100 fw-semibold shadow-sm">Submit Assignment</button>
                            </form>
                            <% } } else { 
                                // FIXED: Dapatkan bilangan tugasan pelajar yang belum disemak oleh pengajar
                                int pendingCount = assignmentDao.getPendingSubmissionsCount(a.getAssignmentId());
                            %>
                            <div class="d-inline-flex align-items-center">
                                <a href="ViewSubmissionsServlet?assignmentId=<%= a.getAssignmentId() %>" class="btn btn-primary btn-sm rounded-pill px-3 fw-semibold">
                                    View Submissions
                                </a>
                                <% if (pendingCount > 0) { %>
                                    <%-- Papar notifikasi badge berbentuk bulat berwarna merah jika ada data masuk --%>
                                    <span class="notification-badge shadow-sm" title="<%= pendingCount %> Not Yet Reviewed"><%= pendingCount %></span>
                                <% } %>
                            </div>
                            <% } %>
                            </td>
                        </tr>
                    <% } } else { %>
                        <tr><td colspan="6" class="text-center text-muted">No assignments available.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>