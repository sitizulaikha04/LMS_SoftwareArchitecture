<%-- 
    Document   : courses
    Created on : 4 Jun 2026, 12:18:53?pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.schoollms.model.Course"%>
<%@page import="com.schoollms.model.User"%>
<%
User user = (User)session.getAttribute("user");
if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
List<Course> courses = (List<Course>)request.getAttribute("courses");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses Matrix | SchoolLMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; margin: 0; padding-top: 56px; }
        .lms-navbar { background-color: #0d6efd; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .dashboard-container { display: flex; min-height: calc(100vh - 56px); }
        .lms-sidebar { width: 260px; background-color: #ffffff; border-right: 1px solid #e2e8f0; padding: 1.5rem 1rem; flex-shrink: 0; }
        .sidebar-heading { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; color: #94a3b8; font-weight: 700; margin-bottom: 0.75rem; padding-left: 0.5rem; }
        .sidebar-menu { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 0.35rem; }
        .sidebar-link { color: #475569; text-decoration: none; padding: 0.75rem 1rem; border-radius: 8px; font-weight: 500; display: flex; align-items: center; gap: 0.75rem; transition: all 0.2s ease; }
        .sidebar-link:hover { color: #0d6efd; background-color: #f1f5f9; }
        .sidebar-link.active { color: #ffffff; background-color: #0d6efd; font-weight: 600; }
        .main-content { flex-grow: 1; padding: 2.5rem; background-color: #f8fafc; }
        .custom-card { border: none; border-radius: 12px; background: #fff; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        .table-custom th { background-color: #f1f5f9; color: #475569; font-weight: 600; }
        @media (max-width: 768px) {
            .dashboard-container { flex-direction: column; }
            .lms-sidebar { width: 100%; border-right: none; border-bottom: 1px solid #e2e8f0; padding: 1rem; }
            .main-content { padding: 1.5rem; }
        }
        .profile-badge {
            background-color: rgba(255, 255, 255, 0.15);
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark lms-navbar fixed-top">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="dashboard.jsp">
            <span>🏫</span> SchoolLMS
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-3">
                <li class="nav-item">
                    <a class="nav-link active fw-semibold" href="dashboard.jsp">🏠 Home</a>
                </li>
            </ul>
            
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
            <li><a class="sidebar-link active" href="CourseServlet"><span>📚</span> <span>Courses Matrix</span></a></li>
            <li><a class="sidebar-link" href="AssignmentServlet"><span>📝</span> <span>Assignments Ledger</span></a></li>
            <li><a class="sidebar-link" href="AnnouncementServlet"><span>📢</span> <span>Announcements Board</span></a></li>
        </ul>
    </aside>

    <main class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-dark mb-0">Course Management</h2>
        </div>

        <% if(user.getRole().equals("Teacher")) { %>
        <div class="card custom-card mb-4 p-2">
            <div class="card-header bg-white fw-bold text-dark border-0 pt-3 fs-5">Create New Course</div>
            <div class="card-body">
                <form action="CourseServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Course Name</label>
                        <input type="text" name="courseName" class="form-control rounded-3" placeholder="e.g., Object Oriented Systems Design" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Description</label>
                        <textarea name="description" class="form-control rounded-3" rows="2" placeholder="Enter course description criteria..." required></textarea>
                    </div>
                    <button class="btn btn-primary px-4 fw-semibold">Add Course</button>
                </form>
            </div>
        </div>
        <% } %>

        <div class="card custom-card">
            <div class="card-header bg-white fw-bold text-dark border-0 pt-3 fs-5">Available Course Catalog</div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom mb-0 table-hover">
                        <thead>
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Course Name</th>
                                <th class="pe-4">Description</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if(courses != null) {
                                for(Course c : courses) { %>
                                <tr>
                                    <td class="ps-4 fw-semibold text-secondary">#<%= c.getCourseId() %></td>
                                    <td class="fw-bold text-dark"><%= c.getCourseName() %></td>
                                    <td class="pe-4 text-muted small"><%= c.getDescription() %></td>
                                </tr>
                            <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>