<%@page import="com.lms.model.User"%>

<%
User u =
(User)session.getAttribute("userSession");

if(u == null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>
<title>Dashboard</title>
<link rel="stylesheet" href="style.css">
</head>

<body>

<div class="dashboard-header">

<h1>
Welcome,
<%=u.getEmail()%>
</h1>

<h3>
Role :
<%=u.getRole()%>
</h3>

<form action="LmsController" method="post">

<input type="hidden"
       name="action"
       value="logout">

<button>
Logout
</button>

</form>

</div>

<div class="cards">

<div class="card">
<h2>Courses</h2>
<p>0</p>
</div>

<div class="card">
<h2>Assignments</h2>
<p>0</p>
</div>

<div class="card">
<h2>Announcements</h2>
<p>0</p>
</div>

</div>

<% if(u.getRole().equals("Teacher")) { %>

<div class="box">

<h2>Teacher Panel</h2>

<ul>
<li>Create Courses</li>
<li>Manage Assignments</li>
<li>Post Announcements</li>
<li>Grade Students</li>
</ul>

</div>

<% } else { %>

<div class="box">

<h2>Student Panel</h2>

<ul>
<li>View Courses</li>
<li>Submit Assignments</li>
<li>View Grades</li>
<li>Read Announcements</li>
</ul>

</div>

<% } %>

</body>
</html>