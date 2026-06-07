<%-- 
    Document   : dashboard
    Created on : 4 Jun 2026, 12:18:43?pm
    Author     : ADMIN
--%>

<%@page import="com.schoollms.model.User"%>

<%
User user =
(User)session.getAttribute("user");

if(user == null){

response.sendRedirect("login.jsp");
return;

}
%>

<!DOCTYPE html>

<html>

<head>

<title>Dashboard</title>

<link href=
"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<nav class="navbar navbar-dark bg-primary">

<div class="container-fluid">

<span class="navbar-brand">

School LMS

</span>

<a href="LogoutServlet"
class="btn btn-danger">

Logout

</a>

</div>

</nav>

<div class="container mt-4">

<h2>

Welcome
<%= user.getFullname() %>

</h2>

<h5>

Role :
<%= user.getRole() %>

</h5>

<hr>

<div class="row">

<div class="col-md-4">

<div class="card shadow">

<div class="card-body">

<h4>Courses</h4>

<a href="CourseServlet" class="btn btn-primary">
    Open
</a>


</div>

</div>

</div>

<div class="col-md-4">

<div class="card shadow">

<div class="card-body">

<h4>Assignments</h4>

<a href="AssignmentServlet"
class="btn btn-success">
Open
</a>

</div>

</div>

</div>

<div class="col-md-4">

<div class="card shadow">

<div class="card-body">

<h4>Announcements</h4>

<a href="AnnouncementServlet"
class="btn btn-warning">
Open
</a>

</div>

</div>

</div>

</div>

</div>

</body>

</html>