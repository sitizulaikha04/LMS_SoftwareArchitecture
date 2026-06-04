<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <title>LMS Portal</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="container">

<h1>Learning Management System</h1>

<p class="error">
<%= request.getParameter("msg") != null ?
request.getParameter("msg") : "" %>
</p>

<div class="box">

<h2>Register</h2>

<form action="LmsController" method="post">

<input type="hidden"
       name="action"
       value="register">

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

<div class="box">

<h2>Login</h2>

<form action="LmsController" method="post">

<input type="hidden"
       name="action"
       value="login">

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