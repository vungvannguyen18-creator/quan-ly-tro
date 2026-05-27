package com.tro.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tro.dao.BookingDAO;
import com.tro.dao.PaymentDAO;
import com.tro.dao.TransactionDAO;
import com.tro.entity.Booking;
import com.tro.entity.Payment;
import com.tro.entity.PaymentTransaction;
import com.tro.util.PayOSUtil;
import vn.payos.model.webhooks.WebhookData;
import vn.payos.model.webhooks.Webhook;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/payment/webhook")
public class WebhookServlet extends HttpServlet {

    private PaymentDAO paymentDAO;
    private BookingDAO bookingDAO;
    private TransactionDAO transactionDAO;
    private ObjectMapper mapper;

    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
        bookingDAO = new BookingDAO();
        transactionDAO = new TransactionDAO();
        mapper = new ObjectMapper();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StringBuilder jsonBuffer = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }
        String requestBody = jsonBuffer.toString();

        try {
            JsonNode bodyNode = mapper.readTree(requestBody);
            // Verify signature using PayOS SDK
            Webhook webhookBody = mapper.treeToValue(bodyNode, Webhook.class);
            WebhookData data = PayOSUtil.getPayOS().webhooks().verify(webhookBody);

            if (data != null) {
                Long orderCode = data.getOrderCode();
                Payment payment = paymentDAO.findByOrderCode(orderCode);

                if (payment != null && "PENDING".equals(payment.getStatus())) {
                    if ("00".equals(data.getCode()) || "PAID".equals(data.getCode())) { // Assuming 00/PAID is success
                        // Update Payment
                        payment.setStatus("PAID");
                        payment.setPaidAt(LocalDateTime.now());
                        paymentDAO.update(payment);

                        // Save Transaction
                        PaymentTransaction transaction = new PaymentTransaction();
                        transaction.setPayment(payment);
                        transaction.setPayosTransactionId(data.getReference());
                        transaction.setAmount((double) data.getAmount());
                        transaction.setStatus("SUCCESS");
                        transaction.setRawData(requestBody);
                        transactionDAO.create(transaction);

                        // Update Booking
                        Booking booking = payment.getBooking();
                        booking.setStatus("CONFIRMED");
                        bookingDAO.update(booking);
                        
                        // Send email to student
                        new Thread(() -> {
                            com.tro.util.EmailUtil.sendNotificationEmail(
                                booking.getStudent().getEmail(),
                                "XÁC NHẬN GIỮ PHÒNG THÀNH CÔNG - " + booking.getRoom().getTitle(),
                                "Xin chào " + booking.getStudent().getFullName() + ",\n\n" +
                                "Giao dịch thanh toán cọc (" + data.getAmount() + " VNĐ) cho phòng '" + booking.getRoom().getTitle() + "' đã thành công!\n" +
                                "Phòng đã được giữ cho bạn. Vui lòng liên hệ chủ trọ để tiến hành làm Hợp đồng thuê nhà.\n\n" +
                                "Trân trọng."
                            );
                        }).start();
                        
                        // Send email to landlord
                        new Thread(() -> {
                            com.tro.util.EmailUtil.sendNotificationEmail(
                                booking.getRoom().getOwner().getEmail(),
                                "CÓ KHÁCH VỪA THANH TOÁN CỌC - " + booking.getRoom().getTitle(),
                                "Xin chào " + booking.getRoom().getOwner().getFullName() + ",\n\n" +
                                "Sinh viên " + booking.getStudent().getFullName() + " vừa thanh toán tiền cọc thành công.\n" +
                                "Vui lòng kiểm tra và liên hệ sinh viên để làm hợp đồng.\n\n" +
                                "Trân trọng."
                            );
                        }).start();
                    }
                }
                
                response.setStatus(200);
                response.getWriter().write("{\"success\":true}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(400);
            response.getWriter().write("{\"success\":false}");
        }
    }
}
