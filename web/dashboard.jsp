<%-- 
    Document   : dashboard
    Created on : 4 Jun 2026, 12:18:43?pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.schoollms.model.User"%>
<%@page import="com.schoollms.util.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%
// 1. Session Guard: Check user authentication status
User user = (User)session.getAttribute("user");
if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

// 2. Initialize metrics counters
int cardValue1 = 0;
int cardValue2 = 0;

String cardTitle1 = "";
String cardTitle2 = "";

String cardSub1 = "";
String cardSub2 = "";

// Configure display metadata labels up-front based on user role
if ("Teacher".equalsIgnoreCase(user.getRole())) {
    cardTitle1 = "Deployed Courses";
    cardSub1 = "Manage Course Matrix &rarr;";

    cardTitle2 = "Active Assignments";
    cardSub2 = "View Evaluation Registry &rarr;";
} else {
    cardTitle1 = "My Enrolled Courses";
    cardSub1 = "Explore active classrooms &rarr;";

    cardTitle2 = "Pending Tasks";
    cardSub2 = "Complete submission entries &rarr;";
}

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    // Utilize your unified connection manager pool to stay synchronized across pages
    conn = DBConnection.getConnection();

    if (user != null && "Teacher".equalsIgnoreCase(user.getRole())) {
        
        // Count all courses deployed globally across the system
        ps = conn.prepareStatement("SELECT COUNT(*) FROM courses");
        rs = ps.executeQuery();
        if(rs.next()) cardValue1 = rs.getInt(1);
        rs.close(); ps.close();

        // Count all assignments posted globally
        ps = conn.prepareStatement("SELECT COUNT(*) FROM assignments");
        rs = ps.executeQuery();
        if(rs.next()) cardValue2 = rs.getInt(1);
        
    } else {
        // Fallback checks for students to capture general course counts safely
        ps = conn.prepareStatement("SELECT COUNT(*) FROM courses");
        rs = ps.executeQuery();
        if(rs.next()) cardValue1 = rs.getInt(1);
        rs.close(); ps.close();

        ps = conn.prepareStatement("SELECT COUNT(*) FROM assignments");
        rs = ps.executeQuery();
        if(rs.next()) cardValue2 = rs.getInt(1);
    }
} catch (Exception e) {
    System.out.println("!!! EXCEPTION OCCURRED IN DASHBOARD SCRIPTLET QUERY BLOCK !!!");
    e.printStackTrace(); 
    cardValue1 = 0; 
    cardValue2 = 0; 
} finally {
    // Safe resource cleanup loop execution to guarantee connection return
    if(rs != null) try { rs.close(); } catch(Exception e){}
    if(ps != null) try { ps.close(); } catch(Exception e){}
    if(conn != null) try { conn.close(); } catch(Exception e){}
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Home | SchoolLMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            margin: 0;
            padding-top: 56px;
        }
        .lms-navbar {
            background-color: #0d6efd;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .dashboard-container {
            display: flex;
            min-height: calc(100vh - 56px);
        }
        .lms-sidebar {
            width: 260px;
            background-color: #ffffff;
            border-right: 1px solid #e2e8f0;
            padding: 1.5rem 1rem;
            flex-shrink: 0;
            position: relative; /* Add this */
            z-index: 10;        /* Add this to ensure it sits on top */
        }
        .sidebar-heading {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #94a3b8;
            font-weight: 700;
            margin-bottom: 0.75rem;
            padding-left: 0.5rem;
        }
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 0.35rem;
        }
        .sidebar-link {
            color: #475569;
            text-decoration: none;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.2s ease;
        }
        .sidebar-link:hover {
            color: #0d6efd;
            background-color: #f1f5f9;
        }
        .sidebar-link.active {
            color: #ffffff;
            background-color: #0d6efd;
            font-weight: 600;
        }
        .main-content {
            flex-grow: 1;
            padding: 2.5rem;
        }
        .welcome-panel {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
        }
        .metric-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .metric-card:hover {
            transform: translateY(-2px);
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
        @media (max-width: 768px) {
            .dashboard-container { flex-direction: column; }
            .lms-sidebar { width: 100%; border-right: none; border-bottom: 1px solid #e2e8f0; padding: 1rem; }
            .main-content { padding: 1.5rem; }
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
            <li>
                <a class="sidebar-link active" href="dashboard.jsp">
                    <span>📊</span> <span>Dashboard Home</span>
                </a>
            </li>
            <li>
                <a class="sidebar-link" href="CourseServlet">
                    <span>📚</span> <span>Courses Matrix</span>
                </a>
            </li>
            <li>
                <a class="sidebar-link" href="AssignmentServlet">
                    <span>📝</span> <span>Assignments Ledger</span>
                </a>
            </li>
            <li>
                <a class="sidebar-link" href="AnnouncementServlet">
                    <span>📢</span> <span>Announcements Board</span>
                </a>
            </li>
        </ul>
    </aside>

    <main class="main-content">
        <div class="welcome-panel mb-4">
            <h2 class="fw-bold text-dark mb-1">Welcome back, <%= user.getFullname() %>!</h2>
            <p class="text-muted mb-0">Here's a personalized look at your academic dashboard profile metrics today.</p>
        </div>
        
        <div class="row g-4">
            <div class="col-12 col-md-6">
                <div class="card metric-card bg-success text-white h-100">
                    <div class="card-body d-flex flex-column justify-content-between p-4">
                        <div>
                            <h6 class="text-uppercase fw-bold text-white-50 small mb-2"><%= cardTitle1 %></h6>
                            <h2 class="display-5 fw-bold mb-0"><%= cardValue1 %></h2>
                        </div>
                        <div class="mt-3 text-white-50 small">
                            <a href="CourseServlet" class="text-white text-decoration-none fw-semibold"><%= cardSub1 %></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="card metric-card bg-dark text-white h-100">
                    <div class="card-body d-flex flex-column justify-content-between p-4">
                        <div>
                            <h6 class="text-uppercase fw-bold text-white-50 small mb-2"><%= cardTitle2 %></h6>
                            <h2 class="display-5 fw-bold mb-0"><%= cardValue2 %></h2>
                        </div>
                        <div class="mt-3 text-white-50 small">
                            <a href="AssignmentServlet" class="text-white text-decoration-none fw-semibold"><%= cardSub2 %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelectorAll('.sidebar-link').forEach(link => {
        link.addEventListener('click', (e) => {
            console.log("Link clicked: " + e.target.innerText);
        });
    });
</script>
</body>
</html>