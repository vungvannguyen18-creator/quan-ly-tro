package com.tro.controller;

import com.tro.dao.ReviewDAO;
import com.tro.dao.RoomDAO;
import com.tro.entity.Review;
import com.tro.entity.Room;
import com.tro.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/review/create")
public class ReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO;
    private RoomDAO roomDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
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
        Integer rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Room room = roomDAO.findById(roomId);

        if (room != null && rating >= 1 && rating <= 5) {
            Review review = new Review();
            review.setUser(user);
            review.setRoom(room);
            review.setRating(rating);
            review.setComment(comment);
            
            reviewDAO.create(review);
            request.getSession().setAttribute("message", "Đánh giá của bạn đã được gửi thành công!");
        }

        response.sendRedirect(request.getContextPath() + "/room-detail?id=" + roomId);
    }
}
