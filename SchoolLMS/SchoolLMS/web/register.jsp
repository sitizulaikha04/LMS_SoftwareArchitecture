<%-- 
    Document   : register
    Created on : 4 Jun 2026, 12:18:30 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <title>SchoolLMS Registration</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<%
String error = request.getParameter("error");
%>

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-6">

            <div class="card shadow">

                <div class="card-header bg-success text-white text-center">

                    <h3>Create Account</h3>

                </div>

                <div class="card-body">

                    <%
                    if(error != null){
                    %>

                    <div class="alert alert-danger">

                        Registration failed.
                        Email already exists or invalid data.

                    </div>

                    <%
                    }
                    %>

                    <form action="RegisterServlet"
                          method="post">

                        <div class="mb-3">

                            <label>Full Name</label>

                            <input type="text"
                                   name="fullname"
                                   class="form-control"
                                   required>

                        </div>

                        <div class="mb-3">

                            <label>Email</label>

                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   required>

                        </div>

                        <div class="mb-3">

                            <label>Password</label>

                            <input type="password"
                                   name="password"
                                   class="form-control"
                                   required>

                        </div>

                        <div class="mb-3">

                            <label>Role</label>

                            <select name="role"
                                    class="form-control">

                                <option value="Teacher">

                                    Teacher

                                </option>

                                <option value="Student">

                                    Student

                                </option>

                            </select>

                        </div>

                        <button type="submit"
                                class="btn btn-success w-100">

                            Register

                        </button>

                    </form>

                    <hr>

                    <div class="text-center">

                        Already have an account?

                        <a href="login.jsp">

                            Login Here

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>