package com.tro.controller;

import com.tro.dao.BookingDAO;
import com.tro.dao.RoomDAO;
import com.tro.entity.Booking;
import com.tro.entity.Room;
import com.tro.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(urlPatterns = {"/booking/create", "/booking/history", "/booking/cancel"})
public class BookingServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private RoomDAO roomDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
        roomDAO = new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("/booking/history".equals(path)) {
            List<Booking> bookings = bookingDAO.findByStudentId(user.getId());
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/WEB-INF/views/student/booking-history.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("/booking/create".equals(path)) {
            Long roomId = Long.parseLong(request.getParameter("roomId"));
            String moveInDateStr = request.getParameter("moveInDate");
            Integer peopleCount = Integer.parseInt(request.getParameter("peopleCount"));
            String note = request.getParameter("note");

            Room room = roomDAO.findById(roomId);
            if (room != null && room.getStatus()) {
                Booking booking = new Booking();
                booking.setRoom(room);
                booking.setStudent(user);
                booking.setMoveInDate(LocalDate.parse(moveInDateStr));
                booking.setPeopleCount(peopleCount);
                booking.setNote(note);
                booking.setStatus("PENDING");

                bookingDAO.create(booking);
                request.getSession().setAttribute("message", "Gửi yêu cầu thuê phòng thành công!");
                response.sendRedirect(request.getContextPath() + "/booking/history");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else if ("/booking/cancel".equals(path)) {
            Long bookingId = Long.parseLong(request.getParameter("id"));
            Booking booking = bookingDAO.findById(bookingId);

            if (booking != null && booking.getStudent().getId().equals(user.getId()) && "PENDING".equals(booking.getStatus())) {
                booking.setStatus("CANCELLED");
                bookingDAO.update(booking);
                request.getSession().setAttribute("message", "Hủy yêu cầu thành công!");
            }
            response.sendRedirect(request.getContextPath() + "/booking/history");
        }
    }
}
