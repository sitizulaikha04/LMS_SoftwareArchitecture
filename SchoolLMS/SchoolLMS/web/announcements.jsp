<%-- 
    Document   : announcements
    Created on : 4 Jun 2026, 12:19:27?pm
    Author     : ADMIN
--%>

<%@page import="java.util.List"%>
<%@page import="com.schoollms.model.User"%>
<%@page import="com.schoollms.model.Announcement"%>

<%
User user =
(User)session.getAttribute("user");

if(user == null){

response.sendRedirect("login.jsp");
return;

}

List<Announcement> announcements =
(List<Announcement>)
request.getAttribute("announcements");
%>

<!DOCTYPE html>
<html>
<head>

<title>Announcements</title>

<link href=
"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<nav class="navbar navbar-dark bg-warning">

<div class="container-fluid">

<span class="navbar-brand">

School Announcements

</span>

<a href="dashboard.jsp"
class="btn btn-dark">

Dashboard

</a>

</div>

</nav>

<div class="container mt-4">

<% if(user.getRole().equals("Teacher")) { %>

<div class="card mb-4 shadow">

<div class="card-header">

Create Announcement

</div>

<div class="card-body">

<form action="AnnouncementServlet"
method="post">

<input type="number"
name="courseId"
placeholder="Course ID"
class="form-control mb-2">

<input type="text"
name="title"
placeholder="Announcement Title"
class="form-control mb-2">

<textarea
name="message"
class="form-control mb-2"
placeholder="Announcement Message">
</textarea>

<button class="btn btn-warning">

Post Announcement

</button>

</form>

</div>

</div>

<% } %>

<h3>Latest Announcements</h3>

<%

if(announcements != null){

for(Announcement a : announcements){

%>

<div class="card mb-3 shadow-sm">

<div class="card-body">

<h5>

<%= a.getTitle() %>

</h5>

<p>

<%= a.getMessage() %>

</p>

<small>

Course ID:
<%= a.getCourseId() %>

</small>

</div>

</div>

<%
}
}
%>

</div>

</body>

</html>