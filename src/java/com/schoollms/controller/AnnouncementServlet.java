/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.schoollms.controller;

import com.schoollms.dao.AnnouncementDAO;
import com.schoollms.model.Announcement;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AnnouncementServlet")
public class AnnouncementServlet extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        AnnouncementDAO dao =
                new AnnouncementDAO();

        List<Announcement> announcements =
                dao.getAllAnnouncements();

        request.setAttribute(
                "announcements",
                announcements);

        request.getRequestDispatcher(
                "announcements.jsp")
                .forward(request,response);
    }

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Announcement announcement =
                new Announcement();

        announcement.setCourseId(
        Integer.parseInt(
        request.getParameter("courseId")));

        announcement.setTitle(
                request.getParameter("title"));

        announcement.setMessage(
                request.getParameter("message"));

        AnnouncementDAO dao =
                new AnnouncementDAO();

        dao.addAnnouncement(
                announcement);

        response.sendRedirect(
                "AnnouncementServlet");
    }
}