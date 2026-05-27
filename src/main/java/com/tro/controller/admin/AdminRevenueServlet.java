package com.tro.controller.admin;

import com.tro.dao.PaymentDAO;
import com.tro.entity.Payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/revenue")
public class AdminRevenueServlet extends HttpServlet {

    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Payment> payments = paymentDAO.findAll();
        
        // Lọc các giao dịch thành công
        List<Payment> paidPayments = payments.stream()
                .filter(p -> "PAID".equals(p.getStatus()) && p.getPaidAt() != null)
                .collect(Collectors.toList());

        // Tổng doanh thu
        double totalRevenue = paidPayments.stream().mapToDouble(Payment::getAmount).sum();
        
        // Doanh thu hôm nay
        LocalDateTime now = LocalDateTime.now();
        double todayRevenue = paidPayments.stream()
                .filter(p -> p.getPaidAt().toLocalDate().equals(now.toLocalDate()))
                .mapToDouble(Payment::getAmount).sum();
                
        // Doanh thu tháng này
        double monthRevenue = paidPayments.stream()
                .filter(p -> p.getPaidAt().getYear() == now.getYear() && p.getPaidAt().getMonth() == now.getMonth())
                .mapToDouble(Payment::getAmount).sum();
                
        // Doanh thu năm nay
        double yearRevenue = paidPayments.stream()
                .filter(p -> p.getPaidAt().getYear() == now.getYear())
                .mapToDouble(Payment::getAmount).sum();

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("todayRevenue", todayRevenue);
        request.setAttribute("monthRevenue", monthRevenue);
        request.setAttribute("yearRevenue", yearRevenue);
        request.setAttribute("totalPaidTransactions", paidPayments.size());
        
        request.getRequestDispatcher("/WEB-INF/views/admin/revenue.jsp").forward(request, response);
    }
}
