<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>LMS Entry</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h2>Learning Management System</h2>
        <p style="color:red;"><%= (request.getParameter("msg") != null) ? request.getParameter("msg") : "" %></p>

        <fieldset>
            <legend>New Registration</legend>
            <form action="LmsController" method="POST">
                <input type="hidden" name="action" value="register">
                Email: <input type="email" name="email" required>
                Password: <input type="password" name="password" required>
                <button type="submit">Register</button>
            </form>
        </fieldset>

        <br>

        <fieldset>
            <legend>Login</legend>
            <form action="LmsController" method="POST">
                <input type="hidden" name="action" value="login">
                Email: <input type="email" name="email" required>
                Password: <input type="password" name="password" required>
                <button type="submit">Login</button>
            </form>
        </fieldset>
    </body>
</html>
