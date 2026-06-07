<%-- 
    Document   : viewSubmissions
    Created on : 8 Jun 2026, 1:19:57 am
    Author     : ACER
--%>

<%-- 
    Document   : viewSubmissions
    Description: Lecturer view of student submissions
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.schoollms.model.Submission"%>
<%@page import="com.schoollms.model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Submission> submissions =
            (List<Submission>) request.getAttribute("submissions");

    int assignmentId =
            (request.getAttribute("assignmentId") != null)
            ? (Integer) request.getAttribute("assignmentId")
            : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Submissions | SchoolLMS</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial;
            background: #f8fafc;
            padding: 30px;
        }

        .card-box {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        table {
            background: white;
        }

        .file-link {
            text-decoration: none;
            color: #0d6efd;
        }

        .file-link:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>📂 Assignment Submissions</h3>
        <a href="AssignmentServlet" class="btn btn-secondary btn-sm">
            ← Back
        </a>
    </div>

    <div class="card-box">

        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Submission ID</th>
                    <th>Student ID</th>
                    <th>File</th>
                    <th>Submit Date</th>
                    <th>Grade</th>
                    <th>Feedback</th>
                </tr>
            </thead>

            <tbody>

            <%
                if (submissions != null && !submissions.isEmpty()) {

                    for (Submission s : submissions) {
            %>

                <tr>
                    <td><%= s.getSubmissionId() %></td>
                    <td><%= s.getStudentId() %></td>

                    <td>
                        <a class="file-link"
                           href="<%= s.getFilePath() %>"
                           target="_blank">
                            <%= s.getFileName() %>
                        </a>
                    </td>

                    <td>
                        <%= s.getSubmitDate() %>
                    </td>

                    <td>

<form action="GradeSubmissionServlet"
      method="post">

    <input type="hidden"
           name="submissionId"
           value="<%= s.getSubmissionId() %>">

    <input type="number"
           step="0.01"
           name="grade"
           value="<%= s.getGrade() %>"
           class="form-control mb-2">

</td>

                    <td>

                        <textarea
                            name="feedback"
                            class="form-control mb-2"><%= s.getFeedback()==null?"":s.getFeedback() %></textarea>

                        <button type="submit"
                                class="btn btn-success btn-sm">

                            Save

                        </button>

                    </form>

                    </td>
                </tr>

            <%
                    }

                } else {
            %>

                <tr>
                    <td colspan="6" class="text-center text-muted">
                        No submissions found for this assignment.
                    </td>
                </tr>

            <%
                }
            %>

            </tbody>
        </table>

    </div>
</div>

</body>
</html>