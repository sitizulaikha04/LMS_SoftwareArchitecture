<%-- 
    Document   : assignments
    Created on : 4 Jun 2026, 12:19:12?pm
    Author     : ADMIN
--%>

<%@page import="java.util.List"%>
<%@page import="com.schoollms.model.Assignment"%>
<%@page import="com.schoollms.model.User"%>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

List<Assignment> assignments =
        (List<Assignment>) request.getAttribute("assignments");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Assignments</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body>

<div class="container mt-4">

    <h2>Assignment Management</h2>

    <hr>

    <% if(user.getRole().equals("Teacher")) { %>

    <div class="card mb-4 shadow">

        <div class="card-header bg-success text-white">

            Create Assignment

        </div>

        <div class="card-body">

            <form action="AssignmentServlet"
                  method="post">

                <input type="number"
                       name="courseId"
                       class="form-control mb-2"
                       placeholder="Course ID"
                       required>

                <input type="text"
                       name="title"
                       class="form-control mb-2"
                       placeholder="Assignment Title"
                       required>

                <textarea
                    name="description"
                    class="form-control mb-2"
                    placeholder="Assignment Description"
                    required></textarea>

                <input type="date"
                       name="dueDate"
                       class="form-control mb-2"
                       required>

                <button class="btn btn-success">

                    Create Assignment

                </button>

            </form>

        </div>

    </div>

    <% } %>

    <table class="table table-bordered table-striped">

        <thead>

        <tr>

            <th>ID</th>
            <th>Course</th>
            <th>Title</th>
            <th>Description</th>
            <th>Due Date</th>
            <th>Action</th>

        </tr>

        </thead>

        <tbody>

        <%

        if(assignments != null){

            for(Assignment a : assignments){

        %>

        <tr>

            <td><%= a.getAssignmentId() %></td>

            <td><%= a.getCourseId() %></td>

            <td><%= a.getTitle() %></td>

            <td><%= a.getDescription() %></td>

            <td><%= a.getDueDate() %></td>

            <td>

                <% if(user.getRole().equals("Student")) { %>

                <form action="SubmitAssignmentServlet"
                      method="post"
                      enctype="multipart/form-data">

                    <input type="hidden"
                           name="assignmentId"
                           value="<%= a.getAssignmentId() %>">

                    <input type="file"
                           name="assignmentFile"
                           class="form-control mb-2"
                           accept=".pdf,.doc,.docx,.ppt,.pptx,.zip"
                           required>

                    <button type="submit"
                            class="btn btn-primary btn-sm">

                        Submit File

                    </button>

                </form>

                <% } else { %>

                    <span class="badge bg-success">

                        Available

                    </span>

                <% } %>

            </td>

        </tr>

        <%
            }
        }
        %>

        </tbody>

    </table>

    <a href="dashboard.jsp"
       class="btn btn-secondary">

       Back to Dashboard

    </a>

</div>

</body>

</html>