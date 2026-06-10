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

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        AnnouncementDAO dao = new AnnouncementDAO();

        // Mengendalikan operasi pemadaman rekod melalui pautan URL
        if ("delete".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                int id = Integer.parseInt(idStr.trim());
                dao.deleteAnnouncement(id);
            }
            response.sendRedirect("AnnouncementServlet");
            return;
        }

        List<Announcement> announcements = dao.getAllAnnouncements();
        request.setAttribute("announcements", announcements);
        request.getRequestDispatcher("announcements.jsp").forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        AnnouncementDAO dao = new AnnouncementDAO();

        if ("update".equalsIgnoreCase(action)) {
            // Logik bagi pengemaskinian data (Update)
            Announcement a = new Announcement();
            a.setAnnouncementId(Integer.parseInt(request.getParameter("announcementId")));
            a.setCourseId(Integer.parseInt(request.getParameter("courseId")));
            a.setTitle(request.getParameter("title"));
            a.setMessage(request.getParameter("message"));

            dao.updateAnnouncement(a);
        } else {
            // Logik lalai asal bagi penambahan data (Add)
            Announcement announcement = new Announcement();
            announcement.setCourseId(Integer.parseInt(request.getParameter("courseId")));
            announcement.setTitle(request.getParameter("title"));
            announcement.setMessage(request.getParameter("message"));

            dao.addAnnouncement(announcement);
        }

        response.sendRedirect("AnnouncementServlet");
    }
}