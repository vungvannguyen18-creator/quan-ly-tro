package com.tro.controller;

import com.tro.dao.UserDAO;
import com.tro.entity.User;
import com.tro.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/register", "/logout"})
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        try {
            // Tự động tạo tài khoản Admin mặc định khi server khởi động nếu chưa có
            if (userDAO.findByEmail("vung1602") == null) {
                User admin = new User();
                admin.setFullName("System Admin");
                admin.setEmail("vung1602"); // Sử dụng vung1602 làm tài khoản đăng nhập thay cho email
                admin.setPhone("0999999999");
                admin.setPassword(PasswordUtil.hashPassword("Tvjuvung1@"));
                admin.setRole("ADMIN");
                admin.setStatus(true);
                userDAO.create(admin);
                System.out.println("====== ĐÃ TẠO THÀNH CÔNG TÀI KHOẢN ADMIN: vung1602 ======");
            }
        } catch (Exception e) {
            System.err.println("Không thể tạo Admin tự động: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        
        switch (path) {
            case "/login":
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                break;
            case "/register":
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                break;
            case "/logout":
                request.getSession().invalidate();
                response.sendRedirect(request.getContextPath() + "/login");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/register".equals(path)) {
            handleRegister(request, response);
        } else if ("/login".equals(path)) {
            handleLogin(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.findByEmail(email) != null) {
            request.setAttribute("error", "Email đã tồn tại!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setRole("STUDENT"); // Admin is responsible for creating Landlords
        user.setStatus(true);

        try {
            userDAO.create(user);
            request.getSession().setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        User user = userDAO.findByEmail(email);

        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            if (!user.getStatus()) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }
            
            // Xử lý cookie Nhớ mật khẩu
            if ("on".equals(remember)) {
                Cookie emailCookie = new Cookie("userEmail", email);
                Cookie passCookie = new Cookie("userPassword", password);
                emailCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                passCookie.setMaxAge(30 * 24 * 60 * 60);
                response.addCookie(emailCookie);
                response.addCookie(passCookie);
            } else {
                Cookie emailCookie = new Cookie("userEmail", "");
                Cookie passCookie = new Cookie("userPassword", "");
                emailCookie.setMaxAge(0);
                passCookie.setMaxAge(0);
                response.addCookie(emailCookie);
                response.addCookie(passCookie);
            }
            
            request.getSession().setAttribute("user", user);
            // Chuyển hướng theo role (VD: ADMIN -> /admin, Khác -> /home)
            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard"); 
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("error", "Email hoặc mật khẩu không đúng.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}
