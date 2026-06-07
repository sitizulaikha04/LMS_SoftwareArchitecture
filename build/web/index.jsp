<%-- 
    Document   : index
    Created on : 6 Jun 2026, 4:50:11 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to SchoolLMS</title>
    <!-- Google Fonts & Bootstrap 5 -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .hero-section {
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 20px 40px -15px rgba(15, 23, 42, 0.08);
            padding: 4rem 3rem;
            border: 1px solid rgba(226, 232, 240, 0.8);
        }
        .portal-card {
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            text-decoration: none;
            background: #ffffff;
        }
        .portal-card:hover {
            transform: translateY(-5px);
            background: #fdfdfd;
        }
        .teacher-hover:hover {
            border-color: #059669;
            box-shadow: 0 12px 20px -8px rgba(5, 150, 105, 0.15);
        }
        .student-hover:hover {
            border-color: #4f46e5;
            box-shadow: 0 12px 20px -8px rgba(79, 70, 229, 0.15);
        }
        .icon-circle {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
            margin: 0 auto 1.25rem;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-9 col-md-11 text-center">
            
            <div class="hero-section">
                <!-- App Badge -->
                <div class="mb-4">
                    <span class="badge px-3 py-2 rounded-pill fw-bold text-uppercase small tracking-wider" style="background-color: #e0e7ff; color: #4338ca;">
                        Next-Gen Learning
                    </span>
                </div>
                
                <h1 class="display-5 fw-bold text-slate-900 mb-2" style="color: #0f172a;">Welcome to SchoolLMS</h1>
                <p class="text-muted lead mb-5 mx-auto" style="max-width: 580px;">
                    Your unified digital campus dashboard. Please select your dedicated portal below to access courses, deployments, and announcements.
                </p>
                
                <div class="row g-4 justify-content-center">
                    <!-- Teacher Portal Button Card -->
                    <div class="col-sm-6 col-md-5">
                        <a href="login.jsp?role=Teacher" class="card h-100 p-4 portal-card teacher-hover">
                            <div class="card-body">
                                <div class="icon-circle text-success" style="background-color: #d1fae5; color: #065f46 !important;">
                                    👨‍🏫
                                </div>
                                <h4 class="fw-bold text-dark mb-2">Teacher Portal</h4>
                                <p class="text-muted small mb-0">Manage course classrooms, launch custom assignments, and broadcast news feed notices.</p>
                            </div>
                        </a>
                    </div>
                    
                    <!-- Student Portal Button Card -->
                    <div class="col-sm-6 col-md-5">
                        <a href="login.jsp?role=Student" class="card h-100 p-4 portal-card student-hover">
                            <div class="card-body">
                                <div class="icon-circle text-primary" style="background-color: #e0e7ff; color: #3730a3 !important;">
                                    🎓
                                </div>
                                <h4 class="fw-bold text-dark mb-2">Student Portal</h4>
                                <p class="text-muted small mb-0">Track academic tracks, download syllabus resources, and upload completed task files.</p>
                            </div>
                        </a>
                    </div>
                </div>
                
            </div>
            
        </div>
    </div>
</div>

</body>
</html>