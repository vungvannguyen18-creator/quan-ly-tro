package com.tro.controller.admin;

import com.tro.dao.BookingDAO;
import com.tro.entity.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/bookings", "/admin/bookings/detail"})
public class AdminBookingServlet extends HttpServlet {

    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/bookings".equals(path)) {
            String studentIdParam = request.getParameter("studentId");
            List<Booking> bookings;

            if (studentIdParam != null && !studentIdParam.isEmpty()) {
                Long studentId = Long.parseLong(studentIdParam);
                bookings = bookingDAO.findAll().stream()
                        .filter(b -> b.getStudent() != null && b.getStudent().getId().equals(studentId))
                        .toList();
                request.setAttribute("studentFilter", studentId);
            } else {
                bookings = bookingDAO.findAll();
            }
            
            // Statistics
            long total = bookings.size();
            long approved = bookings.stream().filter(b -> "APPROVED".equals(b.getStatus())).count();
            long rejected = bookings.stream().filter(b -> "REJECTED".equals(b.getStatus())).count();
            long pending = bookings.stream().filter(b -> "PENDING".equals(b.getStatus())).count();
            
            request.setAttribute("bookings", bookings);
            request.setAttribute("total", total);
            request.setAttribute("approved", approved);
            request.setAttribute("rejected", rejected);
            request.setAttribute("pending", pending);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/bookings.jsp").forward(request, response);
            
        } else if ("/admin/bookings/detail".equals(path)) {
            Long bookingId = Long.parseLong(request.getParameter("id"));
            Booking booking = bookingDAO.findById(bookingId);
            
            if (booking != null) {
                request.setAttribute("booking", booking);
                request.getRequestDispatcher("/WEB-INF/views/admin/booking-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/bookings");
            }
        }
    }
}
