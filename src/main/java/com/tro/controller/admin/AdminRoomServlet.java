package com.tro.controller.admin;

import com.tro.dao.RoomDAO;
import com.tro.entity.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/rooms", "/admin/rooms/toggleStatus", "/admin/rooms/delete"})
public class AdminRoomServlet extends HttpServlet {

    private RoomDAO roomDAO;

    @Override
    public void init() throws ServletException {
        roomDAO = new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/rooms".equals(path)) {
            String ownerIdParam = request.getParameter("ownerId");
            List<Room> rooms;
            
            if (ownerIdParam != null && !ownerIdParam.isEmpty()) {
                Long ownerId = Long.parseLong(ownerIdParam);
                // Lọc theo ownerId, dùng stream lọc list hiện tại cho đơn giản vì đây là view Admin
                rooms = roomDAO.findAll().stream()
                        .filter(r -> r.getOwner() != null && r.getOwner().getId().equals(ownerId))
                        .toList();
                request.setAttribute("ownerFilter", ownerId);
            } else {
                rooms = roomDAO.findAll();
            }
            
            long total = rooms.size();
            long active = rooms.stream().filter(r -> r.getStatus() != null && r.getStatus()).count();
            long hidden = rooms.stream().filter(r -> r.getStatus() == null || !r.getStatus()).count();
            
            request.setAttribute("rooms", rooms);
            request.setAttribute("total", total);
            request.setAttribute("active", active);
            request.setAttribute("hidden", hidden);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/rooms.jsp").forward(request, response);
            
        } else if ("/admin/rooms/toggleStatus".equals(path)) {
            try {
                Long roomId = Long.parseLong(request.getParameter("id"));
                Room room = roomDAO.findById(roomId);
                if (room != null) {
                    room.setStatus(room.getStatus() != null ? !room.getStatus() : true);
                    roomDAO.update(room);
                    request.getSession().setAttribute("message", "Đã cập nhật trạng thái phòng thành công!");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
            
        } else if ("/admin/rooms/delete".equals(path)) {
            try {
                Long roomId = Long.parseLong(request.getParameter("id"));
                roomDAO.delete(roomId);
                request.getSession().setAttribute("message", "Đã xóa vĩnh viễn phòng trọ thành công!");
            } catch (Exception e) {
                request.getSession().setAttribute("error", e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
        }
    }
}
