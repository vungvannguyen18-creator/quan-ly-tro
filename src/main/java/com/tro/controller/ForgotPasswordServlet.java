package com.tro.controller;

import com.tro.dao.UserDAO;
import com.tro.entity.User;
import com.tro.util.EmailUtil;
import com.tro.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/forgot-password", "/verify-otp", "/reset-password"})
public class ForgotPasswordServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        
        switch (path) {
            case "/forgot-password":
                request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
                break;
            case "/verify-otp":
                if (request.getSession().getAttribute("resetEmail") == null) {
                    response.sendRedirect(request.getContextPath() + "/forgot-password");
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(request, response);
                break;
            case "/reset-password":
                if (request.getSession().getAttribute("otpVerified") == null) {
                    response.sendRedirect(request.getContextPath() + "/forgot-password");
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/forgot-password".equals(path)) {
            handleForgotPassword(request, response);
        } else if ("/verify-otp".equals(path)) {
            handleVerifyOtp(request, response);
        } else if ("/reset-password".equals(path)) {
            handleResetPassword(request, response);
        }
    }

    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        User user = userDAO.findByEmail(email);

        if (user != null) {
            String otp = EmailUtil.generateOtp();
            boolean isSent = EmailUtil.sendOtpEmail(email, otp);

            if (isSent) {
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("resetEmail", email);
                // OTP expires in 5 minutes (for simple logic we just set session timeout or let it live for session)
                response.sendRedirect(request.getContextPath() + "/verify-otp");
            } else {
                request.setAttribute("error", "Lỗi gửi email! Vui lòng kiểm tra lại cấu hình SMTP.");
                request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Email không tồn tại trong hệ thống.");
            request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
        }
    }

    private void handleVerifyOtp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputOtp = request.getParameter("otp");
        HttpSession session = request.getSession();
        String sessionOtp = (String) session.getAttribute("otp");

        if (sessionOtp != null && sessionOtp.equals(inputOtp)) {
            session.setAttribute("otpVerified", true);
            response.sendRedirect(request.getContextPath() + "/reset-password");
        } else {
            request.setAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn.");
            request.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(request, response);
        }
    }

    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
            return;
        }

        String email = (String) session.getAttribute("resetEmail");
        if (email != null) {
            User user = userDAO.findByEmail(email);
            if (user != null) {
                user.setPassword(PasswordUtil.hashPassword(newPassword));
                userDAO.update(user);
                
                // Clear session data
                session.removeAttribute("otp");
                session.removeAttribute("resetEmail");
                session.removeAttribute("otpVerified");
                
                session.setAttribute("message", "Đổi mật khẩu thành công! Bạn có thể đăng nhập.");
                response.sendRedirect(request.getContextPath() + "/login");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/forgot-password");
        }
    }
}
