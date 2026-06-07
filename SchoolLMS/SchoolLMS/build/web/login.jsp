<%-- 
    Document   : login
    Created on : 4 Jun 2026, 12:18:20 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <title>SchoolLMS Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<%
String success = request.getParameter("success");
%>

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-5">

            <div class="card shadow">

                <div class="card-header bg-primary text-white text-center">

                    <h3>SchoolLMS Login</h3>

                </div>

                <div class="card-body">

                    <%
                    if(success != null){
                    %>

                    <div class="alert alert-success">

                        Registration successful!
                        Please login using your account.

                    </div>

                    <%
                    }
                    %>

                    <form action="LoginServlet" method="post">

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

                        <button type="submit"
                                class="btn btn-primary w-100">

                            Login

                        </button>

                    </form>

                    <hr>

                    <div class="text-center">

                        Don't have an account?

                        <a href="register.jsp">

                            Register Here

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>