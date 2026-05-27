package com.tro.controller.admin;

import com.tro.dao.PaymentDAO;
import com.tro.entity.Payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/payments", "/admin/payments/detail"})
public class AdminPaymentServlet extends HttpServlet {

    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/payments".equals(path)) {
            List<Payment> payments = paymentDAO.findAll();
            
            long total = payments.size();
            long paid = payments.stream().filter(p -> "PAID".equals(p.getStatus())).count();
            long pending = payments.stream().filter(p -> "PENDING".equals(p.getStatus())).count();
            long failed = payments.stream().filter(p -> "CANCELLED".equals(p.getStatus()) || "FAILED".equals(p.getStatus())).count();
            
            request.setAttribute("payments", payments);
            request.setAttribute("total", total);
            request.setAttribute("paid", paid);
            request.setAttribute("pending", pending);
            request.setAttribute("failed", failed);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/payments.jsp").forward(request, response);
            
        } else if ("/admin/payments/detail".equals(path)) {
            try {
                Long orderCode = Long.parseLong(request.getParameter("orderCode"));
                Payment payment = paymentDAO.findByOrderCode(orderCode);
                if (payment != null) {
                    request.setAttribute("payment", payment);
                    request.getRequestDispatcher("/WEB-INF/views/admin/payment-detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/payments");
                }
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin/payments");
            }
        }
    }
}
