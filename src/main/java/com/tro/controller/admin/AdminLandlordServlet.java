package com.tro.controller.admin;

import com.tro.dao.UserDAO;
import com.tro.entity.User;
import com.tro.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/landlords", "/admin/landlords/create", "/admin/landlords/edit", "/admin/landlords/toggleStatus"})
public class AdminLandlordServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/landlords".equals(path)) {
            List<User> landlords = userDAO.findAllByRole("LANDLORD");
            request.setAttribute("landlords", landlords);
            request.getRequestDispatcher("/WEB-INF/views/admin/landlords.jsp").forward(request, response);
            
        } else if ("/admin/landlords/create".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/views/admin/landlord-form.jsp").forward(request, response);
        } else if ("/admin/landlords/edit".equals(path)) {
            try {
                Long id = Long.parseLong(request.getParameter("id"));
                User landlord = userDAO.findById(id);
                if (landlord != null) {
                    request.setAttribute("landlord", landlord);
                    request.getRequestDispatcher("/WEB-INF/views/admin/landlord-form.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/landlords");
                }
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin/landlords");
            }
        } else if ("/admin/landlords/toggleStatus".equals(path)) {
            try {
                Long id = Long.parseLong(request.getParameter("id"));
                User landlord = userDAO.findById(id);
                if (landlord != null) {
                    landlord.setStatus(!landlord.getStatus());
                    userDAO.update(landlord);
                    request.getSession().setAttribute("message", "Đã cập nhật trạng thái chủ trọ thành công!");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/landlords");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/landlords/create".equals(path) || "/admin/landlords/edit".equals(path)) {
            String idParam = request.getParameter("id");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String cccd = request.getParameter("cccd");

            try {
                User user;
                if (idParam != null && !idParam.isEmpty()) {
                    // Update
                    user = userDAO.findById(Long.parseLong(idParam));
                    if (user == null) {
                        response.sendRedirect(request.getContextPath() + "/admin/landlords");
                        return;
                    }
                    user.setFullName(fullName);
                    user.setPhone(phone);
                    user.setAddress(address);
                    user.setCccd(cccd);
                    if (password != null && !password.trim().isEmpty()) {
                        user.setPassword(PasswordUtil.hashPassword(password));
                    }
                    userDAO.update(user);
                    request.getSession().setAttribute("message", "Đã cập nhật thông tin Chủ trọ thành công!");
                } else {
                    // Create
                    if (userDAO.findByEmail(email) != null) {
                        request.setAttribute("error", "Email đã tồn tại trong hệ thống!");
                        request.getRequestDispatcher("/WEB-INF/views/admin/landlord-form.jsp").forward(request, response);
                        return;
                    }

                    user = new User();
                    user.setFullName(fullName);
                    user.setEmail(email);
                    user.setPhone(phone);
                    user.setPassword(PasswordUtil.hashPassword(password));
                    user.setAddress(address);
                    user.setCccd(cccd);
                    user.setRole("LANDLORD");
                    user.setStatus(true);
                    userDAO.create(user);
                    request.getSession().setAttribute("message", "Đã tạo tài khoản Chủ trọ mới thành công!");
                }
                response.sendRedirect(request.getContextPath() + "/admin/landlords");
            } catch (Exception e) {
                request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/admin/landlord-form.jsp").forward(request, response);
            }
        }
    }
}
