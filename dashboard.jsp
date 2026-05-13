<%@page import="com.lms.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Dashboard</title>
    </head>
    <body>
        <%
            User u = (User) session.getAttribute("userSession");
            if (u == null) { response.sendRedirect("index.jsp"); return; }
        %>
        <h1>WELCOME, <%= u.getEmail() %></h1>
        <p>Logged in as : <b><%= u.getRole() %></b></p>

        <hr>
        <h3>Course Management</h3>
        <ul>
            <li>CSE3433 - Software Architecture</li>
            <li>CSE3413 - Software Testing</li>
        </ul>

        <hr>
        <h3>Assignment Submission</h3>
        <form action="LmsController" method="POST">
            <input type="hidden" name="action" value="submitTask">
            File Name : <input type="text" name="taskName" required>
            <button type="submit">Submit</button>
        </form>

        <p style="color:green;"><%= (request.getParameter("status") != null) ? request.getParameter("status") : "" %></p>
        
        <br><a href="index.jsp">Logout</a>
    </body>
</html>
