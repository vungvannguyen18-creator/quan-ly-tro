package com.tro.controller.landlord;

import com.tro.dao.BookingDAO;
import com.tro.entity.Booking;
import com.tro.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(urlPatterns = {"/landlord/bookings", "/landlord/bookings/approve", "/landlord/bookings/reject"})
public class BookingManagementServlet extends HttpServlet {

    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        User user = (User) request.getSession().getAttribute("user");

        if ("/landlord/bookings".equals(path)) {
            List<Booking> bookings = bookingDAO.findByLandlordId(user.getId());
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/WEB-INF/views/landlord/bookings.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        User user = (User) request.getSession().getAttribute("user");

        Long bookingId = Long.parseLong(request.getParameter("id"));
        Booking booking = bookingDAO.findById(bookingId);

        // Security check: Make sure this booking belongs to a room owned by this landlord
        if (booking != null && booking.getRoom().getOwner().getId().equals(user.getId()) && "PENDING".equals(booking.getStatus())) {
            if ("/landlord/bookings/approve".equals(path)) {
                booking.setStatus("APPROVED");
                booking.setApprovedAt(LocalDateTime.now());
                bookingDAO.update(booking);
                
                // Send email to student
                new Thread(() -> {
                    com.tro.util.EmailUtil.sendNotificationEmail(
                        booking.getStudent().getEmail(),
                        "Yêu cầu thuê phòng ĐÃ ĐƯỢC DUYỆT - " + booking.getRoom().getTitle(),
                        "Chúc mừng!\n\nYêu cầu thuê phòng '" + booking.getRoom().getTitle() + "' của bạn đã được chủ trọ duyệt.\n" +
                        "Vui lòng đăng nhập hệ thống và tiến hành THANH TOÁN TIỀN CỌC để giữ phòng.\n\nTrân trọng."
                    );
                }).start();
                
                request.getSession().setAttribute("message", "Đã duyệt yêu cầu thuê phòng!");
            } else if ("/landlord/bookings/reject".equals(path)) {
                booking.setStatus("REJECTED");
                booking.setRejectedAt(LocalDateTime.now());
                bookingDAO.update(booking);
                request.getSession().setAttribute("message", "Đã từ chối yêu cầu thuê phòng!");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/landlord/bookings");
    }
}
