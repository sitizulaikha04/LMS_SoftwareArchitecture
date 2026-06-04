<%-- 
    Document   : index
    Created on : 4 Jun 2026, 12:09:01 pm
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>School LMS</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">

    <h1>School LMS</h1>

    <p style="color:red;">
        <%= request.getParameter("msg") != null ?
                request.getParameter("msg") : "" %>
    </p>

    <div class="card">

        <h2>Register</h2>

        <form action="RegisterServlet" method="post">

            <input type="email"
                   name="email"
                   placeholder="Email"
                   required>

            <input type="password"
                   name="password"
                   placeholder="Password"
                   required>

            <select name="role">

                <option value="Student">
                    Student
                </option>

                <option value="Teacher">
                    Teacher
                </option>

            </select>

            <button type="submit">
                Register
            </button>

        </form>

    </div>

    <div class="card">

        <h2>Login</h2>

        <form action="LoginServlet" method="post">

            <input type="email"
                   name="email"
                   placeholder="Email"
                   required>

            <input type="password"
                   name="password"
                   placeholder="Password"
                   required>

            <button type="submit">
                Login
            </button>

        </form>

    </div>

</div>

</body>
</html>