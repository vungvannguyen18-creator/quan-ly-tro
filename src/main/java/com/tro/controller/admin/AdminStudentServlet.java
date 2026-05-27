package com.tro.controller.admin;

import com.tro.dao.UserDAO;
import com.tro.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/students", "/admin/students/toggleStatus"})
public class AdminStudentServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/students".equals(path)) {
            List<User> students = userDAO.findAllByRole("STUDENT");
            request.setAttribute("students", students);
            request.getRequestDispatcher("/WEB-INF/views/admin/students.jsp").forward(request, response);
            
        } else if ("/admin/students/toggleStatus".equals(path)) {
            try {
                Long id = Long.parseLong(request.getParameter("id"));
                User student = userDAO.findById(id);
                if (student != null) {
                    student.setStatus(!student.getStatus());
                    userDAO.update(student);
                    request.getSession().setAttribute("message", "Đã cập nhật trạng thái tài khoản sinh viên thành công!");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/students");
        }
    }
}
