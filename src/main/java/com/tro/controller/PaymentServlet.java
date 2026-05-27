package com.tro.controller;

import com.tro.dao.BookingDAO;
import com.tro.dao.PaymentDAO;
import com.tro.entity.Booking;
import com.tro.entity.Payment;
import com.tro.entity.User;
import com.tro.util.PayOSUtil;
import vn.payos.model.v2.paymentRequests.PaymentLinkItem;
import vn.payos.model.v2.paymentRequests.CreatePaymentLinkRequest;
import vn.payos.model.v2.paymentRequests.CreatePaymentLinkResponse;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/payment/create", "/payment/history", "/payment/return", "/payment/cancel"})
public class PaymentServlet extends HttpServlet {

    private PaymentDAO paymentDAO;
    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        User user = (User) request.getSession().getAttribute("user");

        if (user == null && !path.equals("/payment/return") && !path.equals("/payment/cancel")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("/payment/history".equals(path)) {
            List<Payment> payments = paymentDAO.findByStudentId(user.getId());
            request.setAttribute("payments", payments);
            request.getRequestDispatcher("/WEB-INF/views/student/payment-history.jsp").forward(request, response);
            
        } else if ("/payment/return".equals(path)) {
            // Hiển thị giao diện báo đang xử lý, webhook sẽ lo việc update status
            request.setAttribute("message", "Thanh toán của bạn đang được xử lý. Vui lòng kiểm tra lại lịch sử thanh toán trong vài phút tới.");
            request.getRequestDispatcher("/WEB-INF/views/student/payment-return.jsp").forward(request, response);
            
        } else if ("/payment/cancel".equals(path)) {
            Long orderCode = Long.parseLong(request.getParameter("orderCode"));
            Payment payment = paymentDAO.findByOrderCode(orderCode);
            if (payment != null && "PENDING".equals(payment.getStatus())) {
                payment.setStatus("CANCELLED");
                paymentDAO.update(payment);
                
                Booking booking = payment.getBooking();
                if ("WAITING_PAYMENT".equals(booking.getStatus())) {
                    booking.setStatus("APPROVED"); // Reset back to APPROVED to allow paying again
                    bookingDAO.update(booking);
                }
            }
            request.setAttribute("error", "Bạn đã hủy thanh toán!");
            request.getRequestDispatcher("/WEB-INF/views/student/payment-return.jsp").forward(request, response);
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

        if ("/payment/create".equals(path)) {
            try {
                Long bookingId = Long.parseLong(request.getParameter("bookingId"));
                Booking booking = bookingDAO.findById(bookingId);

                // Check condition: Booking must be APPROVED and belongs to student
                if (booking != null && booking.getStudent().getId().equals(user.getId()) && "APPROVED".equals(booking.getStatus())) {
                    
                    // Fixed deposit amount or calculated based on room price (e.g., 50%)
                    int depositAmount = booking.getRoom().getPrice().intValue() / 2;
                    Long orderCode = System.currentTimeMillis(); // Generate unique order code
                    
                    // 1. Save pending payment
                    Payment payment = new Payment();
                    payment.setBooking(booking);
                    payment.setOrderCode(orderCode);
                    payment.setAmount((double) depositAmount);
                    payment.setPaymentMethod("PayOS");
                    payment.setStatus("PENDING");
                    
                    // 2. Prepare PayOS Request
                    String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
                    String returnUrl = baseUrl + "/payment/return";
                    String cancelUrl = baseUrl + "/payment/cancel";

                    PaymentLinkItem item = PaymentLinkItem.builder()
                            .name("Tiền cọc phòng " + booking.getRoom().getTitle())
                            .quantity(1)
                            .price((long) depositAmount)
                            .build();

                    CreatePaymentLinkRequest paymentData = CreatePaymentLinkRequest.builder()
                            .orderCode(orderCode)
                            .amount((long) depositAmount)
                            .description("Coc phong " + booking.getRoom().getId())
                            .returnUrl(returnUrl)
                            .cancelUrl(cancelUrl)
                            .build();
                            
                    // Mặc dù item có thể add, nhưng đối với v2, nếu không add list item thì chỉ cần description là đủ

                    CreatePaymentLinkResponse checkoutData = PayOSUtil.getPayOS().paymentRequests().create(paymentData);
                    
                    payment.setCheckoutUrl(checkoutData.getCheckoutUrl());
                    paymentDAO.create(payment);
                    
                    // Update booking status to prevent concurrent payments
                    booking.setStatus("WAITING_PAYMENT");
                    bookingDAO.update(booking);

                    // 3. Redirect to checkout
                    response.sendRedirect(checkoutData.getCheckoutUrl());
                } else {
                    response.sendRedirect(request.getContextPath() + "/booking/history");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("error", "Lỗi tạo thanh toán. Vui lòng thử lại!");
                response.sendRedirect(request.getContextPath() + "/booking/history");
            }
        }
    }
}
