<%-- 
    Document   : announcements
    Created on : 4 Jun 2026, 12:19:27?pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.schoollms.model.User"%>
<%@page import="com.schoollms.model.Announcement"%>
<%
    User user = (User)session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
    List<Announcement> announcements = (List<Announcement>) request.getAttribute("announcements");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Announcements Board | SchoolLMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; margin: 0; padding-top: 56px; }
        .lms-navbar { background-color: #0d6efd; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .dashboard-container { display: flex; min-height: calc(100vh - 56px); }
        
        /* FIXED: Added positioning and z-index to ensure sidebar is clickable */
        .lms-sidebar { 
            width: 260px; 
            background-color: #ffffff; 
            border-right: 1px solid #e2e8f0; 
            padding: 1.5rem 1rem; 
            flex-shrink: 0; 
            position: relative;
            z-index: 1000;
        }
        
        .sidebar-heading { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; color: #94a3b8; font-weight: 700; margin-bottom: 0.75rem; padding-left: 0.5rem; }
        .sidebar-menu { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 0.35rem; }
        .sidebar-link { color: #475569; text-decoration: none; padding: 0.75rem 1rem; border-radius: 8px; font-weight: 500; display: flex; align-items: center; gap: 0.75rem; transition: all 0.2s ease; }
        .sidebar-link:hover { color: #0d6efd; background-color: #f1f5f9; }
        .sidebar-link.active { color: #ffffff; background-color: #0d6efd; font-weight: 600; }
        .main-content { flex-grow: 1; padding: 2.5rem; background-color: #f8fafc; }
        .custom-card { border: none; border-radius: 12px; background: #fff; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        .announcement-box { border-left: 4px solid #ffc107 !important; border-radius: 8px; }
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
            <li><a class="sidebar-link" href="CourseServlet"><span>📚</span> <span>Courses Matrix</span></a></li>
            <li><a class="sidebar-link" href="AssignmentServlet"><span>📝</span> <span>Assignments Ledger</span></a></li>
            <li><a class="sidebar-link active" href="AnnouncementServlet"><span>📢</span> <span>Announcements Board</span></a></li>
        </ul>
    </aside>

    <main class="main-content">
        <%-- Teacher Broadcast Form --%>
        <% if("Teacher".equals(user.getRole())) { %>
        <div class="card custom-card mb-4 p-2">
            <div class="card-header bg-white fw-bold text-dark border-0 pt-3 fs-5">Broadcast Announcement</div>
            <div class="card-body">
                <form action="AnnouncementServlet" method="post">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <input type="number" name="courseId" placeholder="Course ID" class="form-control rounded-3" required>
                        </div>
                        <div class="col-md-9">
                            <input type="text" name="title" placeholder="Announcement Title" class="form-control rounded-3" required>
                        </div>
                        <div class="col-12">
                            <textarea name="message" class="form-control rounded-3" rows="2" placeholder="Type message details..." required></textarea>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-warning px-4 fw-semibold mt-3 text-dark">Post Notice</button>
                </form>
            </div>
        </div>
        <% } %>

        <h3 class="fw-bold text-dark mb-3">Notice Board</h3>
        <% if(announcements != null && !announcements.isEmpty()) {
            for(Announcement a : announcements) { %>
                <div class="card mb-3 custom-card announcement-box border-0 shadow-sm">
                    <div class="card-body p-3">
                        <div class="d-flex justify-content-between align-items-start">
                            <h5 class="fw-bold text-dark mb-1"><%= a.getTitle() %></h5>
                            <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle">Course: #<%= a.getCourseId() %></span>
                        </div>
                        <p class="text-secondary mb-0 small"><%= a.getMessage() %></p>
                    </div>
                </div>
        <% } } else { %>
            <div class="card custom-card p-4 text-center text-muted">No announcements available at the moment.</div>
        <% } %>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>