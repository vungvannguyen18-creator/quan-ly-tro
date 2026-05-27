package com.tro.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class EmailUtil {

    // Thay đổi thông tin email của bạn để test gửi thật
    private static final String APP_EMAIL = "vungvannguyen18@gmail.com"; 
    private static final String APP_PASSWORD = "eqkjhnsacivybdlv"; 

    public static boolean sendOtpEmail(String toEmail, String otp) {
        return sendNotificationEmail(toEmail, "Mã xác nhận OTP - Hệ thống Phòng Trọ", 
            "Xin chào,\n\nMã OTP của bạn là: " + otp + "\n\nVui lòng không chia sẻ mã này cho bất kỳ ai.\n\nTrân trọng.");
    }

    public static boolean sendNotificationEmail(String toEmail, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(APP_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(APP_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            // Cấu hình UTF-8 cho content
            message.setContent(content, "text/plain; charset=UTF-8");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
}
