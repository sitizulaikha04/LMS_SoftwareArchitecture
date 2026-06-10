/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.schoollms.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Mengambil sesi aktif tanpa mencipta sesi baharu (false)
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Memadamkan semua data maklumat pengguna di dalam sesi (Clear session data)
            session.invalidate();
        }

        // FIXED: Menukar hala tuju dari 'login.jsp' ke 'index.jsp' (Halaman Portal Selection)
        response.sendRedirect("index.jsp");
    }
}