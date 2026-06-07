/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.schoollms.controller;

import com.schoollms.dao.CourseDAO;
import com.schoollms.model.Course;
import com.schoollms.model.User;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CourseServlet")
public class CourseServlet extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        CourseDAO dao =
                new CourseDAO();

        List<Course> courses =
                dao.getAllCourses();

        request.setAttribute(
                "courses",
                courses);

        request.getRequestDispatcher(
                "courses.jsp")
                .forward(request,response);
    }

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
                (User)session.getAttribute("user");

        String courseName =
                request.getParameter("courseName");

        String description =
                request.getParameter("description");

        Course course =
                new Course();

        course.setCourseName(courseName);
        course.setDescription(description);
        course.setTeacherId(user.getUserId());

        CourseDAO dao =
                new CourseDAO();

        dao.addCourse(course);

        response.sendRedirect("CourseServlet");
    }

}