<%-- 
    Document   : register
    Created on : 4 Jun 2026, 12:18:30 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SchoolLMS Registration</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f1f5f9; min-height: 100vh; display: flex; align-items: center; }
        .auth-card { border: none; border-radius: 16px; background: #ffffff; box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05); overflow: hidden; width: 100%; max-width: 400px; }
        .card-header-custom { background: #4338ca; padding: 2.5rem 2rem; border: none; }
        .form-control { border-radius: 8px; padding: 0.75rem; }
        .btn-auth { background: #4338ca; border: none; padding: 0.75rem; font-weight: 600; border-radius: 8px; transition: all 0.2s ease; }
        .btn-auth:hover { background: #3730a3; }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="card auth-card">
        <div class="card-header-custom text-white text-center">
            <h3 class="fw-bold mb-1">Create Account</h3>
            <p class="text-white-50 small mb-0">Join your virtual campus today</p>
        </div>
        <div class="card-body p-4">
            <% if(request.getParameter("error") != null){ %>
                <div class="alert alert-danger border-0 bg-danger-subtle text-danger small rounded-3 mb-3">
                    Registration failed. Please check your details.
                </div>
            <% } %>

            <form action="RegisterServlet" method="post">
                <div class="mb-3">
                    <label class="form-label small fw-semibold text-secondary">Full Name</label>
                    <input type="text" name="fullname" class="form-control" placeholder="John Doe" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold text-secondary">Email Address</label>
                    <input type="email" name="email" class="form-control" placeholder="name@school.com" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold text-secondary">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                </div>
                <div class="mb-4">
                    <label class="form-label small fw-semibold text-secondary">Account Role</label>
                    <select name="role" class="form-select rounded-3">
                        <option value="Student">Student</option>
                        <option value="Teacher">Teacher</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary btn-auth w-100 mb-3">Register Account</button>
            </form>
            <div class="text-center">
                <p class="small text-muted mb-0">Already have an account? 
                    <a href="login.jsp" class="text-decoration-none fw-semibold" style="color: #4338ca;">Login Here</a>
                </p>
            </div>
        </div>
    </div>
</div>

</body>
</html>