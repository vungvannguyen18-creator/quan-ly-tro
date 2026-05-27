package com.tro.controller;

import com.tro.dao.ReportDAO;
import com.tro.dao.RoomDAO;
import com.tro.entity.Report;
import com.tro.entity.Room;
import com.tro.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/report/create")
public class ReportServlet extends HttpServlet {

    private ReportDAO reportDAO;
    private RoomDAO roomDAO;

    @Override
    public void init() throws ServletException {
        reportDAO = new ReportDAO();
        roomDAO = new RoomDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Long roomId = Long.parseLong(request.getParameter("roomId"));
        String reason = request.getParameter("reason");
        String description = request.getParameter("description");

        Room room = roomDAO.findById(roomId);

        if (room != null && reason != null) {
            Report report = new Report();
            report.setUser(user);
            report.setRoom(room);
            report.setReason(reason);
            report.setDescription(description);
            
            reportDAO.create(report);
            request.getSession().setAttribute("message", "Báo cáo của bạn đã được gửi và đang chờ Admin xử lý. Cảm ơn bạn!");
        }

        response.sendRedirect(request.getContextPath() + "/room-detail?id=" + roomId);
    }
}
