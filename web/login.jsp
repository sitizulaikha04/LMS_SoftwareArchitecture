<%-- 
    Document   : login
    Created on : 4 Jun 2026, 12:18:20 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SchoolLMS Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-card {
            border: none;
            border-radius: 16px;
            background: #ffffff;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        .card-header-custom {
            background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%);
            padding: 2.5rem 2rem;
            border: none;
        }
        .form-control:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.12);
        }
        .btn-login {
            background: #4f46e5;
            border: none;
            padding: 0.75rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .btn-login:hover {
            background: #4338ca;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

<% 
String success = request.getParameter("success"); 
String role = request.getParameter("role"); // Captures 'Teacher' or 'Student' from home page
String error = request.getParameter("error"); // Captures error messages
if(role == null) { role = "User"; }
%>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card login-card">
                <div class="card-header-custom text-white text-center">
                    <h3 class="fw-bold mb-1">Welcome Back</h3>
                    <p class="text-white-50 small mb-0">Sign in to the <strong><%= role %> Portal</strong></p>
                </div>
                <div class="card-body p-4">
                    <% if(success != null){ %>
                    <div class="alert alert-success border-0 bg-success-subtle text-success small rounded-3">
                        Registration successful! Please login using your credentials.
                    </div>
                    <% } %>

                    <%-- ERROR MESSAGE DISPLAY --%>
                    <% if("unauthorized".equals(error)){ %>
                    <div class="alert alert-danger border-0 bg-danger-subtle text-danger small rounded-3 mb-3">
                        Access Denied: You are not authorized for this portal.
                    </div>
                    <% } else if("invalid".equals(error)){ %>
                    <div class="alert alert-danger border-0 bg-danger-subtle text-danger small rounded-3 mb-3">
                        Invalid email or password.
                    </div>
                    <% } %>

                    <form action="LoginServlet" method="post">
                        <input type="hidden" name="expectedRole" value="<%= role %>">

                        <div class="mb-3">
                            <label class="form-label small fw-semibold text-secondary">Email Address</label>
                            <input type="email" name="email" class="form-control p-2.5 rounded-3" placeholder="name@school.com" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label small fw-semibold text-secondary">Password</label>
                            <input type="password" name="password" class="form-control p-2.5 rounded-3" placeholder="••••••••" required>
                        </div>
                        <button type="submit" class="btn btn-primary btn-login w-100 mb-3">Sign In</button>
                    </form>
                    
                    <div class="text-center mt-3">
                        <p class="small text-muted mb-0">Don't have an account? <a href="register.jsp" class="text-decoration-none fw-semibold" style="color: #4f46e5;">Register Here</a></p>
                        <a href="index.jsp" class="d-block small text-secondary mt-3 text-decoration-none">← Back to Portal Selection</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>