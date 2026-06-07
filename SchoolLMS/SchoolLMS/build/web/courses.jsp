<%-- 
    Document   : courses
    Created on : 4 Jun 2026, 12:18:53?pm
    Author     : ADMIN
--%>

<%@page import="java.util.List"%>
<%@page import="com.schoollms.model.Course"%>
<%@page import="com.schoollms.model.User"%>

<%
User user =
(User)session.getAttribute("user");

if(user == null){

response.sendRedirect("login.jsp");
return;

}

List<Course> courses =
(List<Course>)request.getAttribute("courses");
%>

<!DOCTYPE html>
<html>

<head>

<title>Courses</title>

<link href=
"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<nav class="navbar navbar-dark bg-primary">

<div class="container-fluid">

<span class="navbar-brand">

Course Management

</span>

<a href="dashboard.jsp"
class="btn btn-light">

Dashboard

</a>

</div>

</nav>

<div class="container mt-4">

<% if(user.getRole().equals("Teacher")) { %>

<div class="card shadow mb-4">

<div class="card-header">

Create New Course

</div>

<div class="card-body">

<form action="CourseServlet"
method="post">

<div class="mb-3">

<label>Course Name</label>

<input type="text"
name="courseName"
class="form-control">

</div>

<div class="mb-3">

<label>Description</label>

<textarea
name="description"
class="form-control"></textarea>

</div>

<button class="btn btn-success">

Add Course

</button>

</form>

</div>

</div>

<% } %>

<div class="card shadow">

<div class="card-header">

Available Courses

</div>

<div class="card-body">

<table class="table table-bordered">

<tr>

<th>ID</th>
<th>Course</th>
<th>Description</th>

</tr>

<%

if(courses != null){

for(Course c : courses){

%>

<tr>

<td>
<%= c.getCourseId() %>
</td>

<td>
<%= c.getCourseName() %>
</td>

<td>
<%= c.getDescription() %>
</td>

</tr>

<%
}
}
%>

</table>

</div>

</div>

</div>

</body>

</html>