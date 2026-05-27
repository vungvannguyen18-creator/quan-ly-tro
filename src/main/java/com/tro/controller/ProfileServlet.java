package com.tro.controller;

import com.tro.dao.UserDAO;
import com.tro.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String cccd = request.getParameter("cccd");

        try {
            // Update current user object
            currentUser.setFullName(fullName);
            currentUser.setPhone(phone);
            currentUser.setAddress(address);
            currentUser.setCccd(cccd);

            // Update in DB
            userDAO.update(currentUser);

            // Update session
            session.setAttribute("user", currentUser);
            session.setAttribute("message", "Cập nhật hồ sơ thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra khi cập nhật hồ sơ.");
        }

        response.sendRedirect(request.getContextPath() + "/profile");
    }
}
