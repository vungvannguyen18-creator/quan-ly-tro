package com.tro.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Tạm thời điều hướng sang Quản lý sinh viên hoặc Chủ trọ
        // Sau này có thể thiết kế biểu đồ thống kê tổng quan ở đây
        response.sendRedirect(request.getContextPath() + "/admin/landlords");
    }
}
