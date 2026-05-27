package com.tro.controller;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.properties.TextAlignment;
import com.tro.dao.BookingDAO;
import com.tro.entity.Booking;
import com.tro.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/contract/download")
public class ContractServlet extends HttpServlet {

    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Long bookingId = Long.parseLong(request.getParameter("bookingId"));
        Booking booking = bookingDAO.findById(bookingId);

        if (booking == null || !booking.getStatus().equals("CONFIRMED")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking");
            return;
        }

        // Only landlord or student involved can download
        if (!booking.getStudent().getId().equals(user.getId()) && !booking.getRoom().getOwner().getId().equals(user.getId())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=hop_dong_thue_nha_" + booking.getId() + ".pdf");

        try {
            PdfWriter writer = new PdfWriter(response.getOutputStream());
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);

            document.add(new Paragraph("CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM").setTextAlignment(TextAlignment.CENTER));
            document.add(new Paragraph("Độc lập - Tự do - Hạnh phúc").setTextAlignment(TextAlignment.CENTER));
            document.add(new Paragraph("\n"));
            document.add(new Paragraph("HỢP ĐỒNG THUÊ PHÒNG TRỌ").setTextAlignment(TextAlignment.CENTER));
            document.add(new Paragraph("\n"));

            document.add(new Paragraph("BÊN CHO THUÊ (BÊN A):"));
            document.add(new Paragraph("- Họ và tên: " + booking.getRoom().getOwner().getFullName()));
            document.add(new Paragraph("- SĐT: " + booking.getRoom().getOwner().getPhone()));
            document.add(new Paragraph("- Email: " + booking.getRoom().getOwner().getEmail()));

            document.add(new Paragraph("\n"));
            document.add(new Paragraph("BÊN THUÊ (BÊN B):"));
            document.add(new Paragraph("- Họ và tên: " + booking.getStudent().getFullName()));
            document.add(new Paragraph("- SĐT: " + booking.getStudent().getPhone()));
            document.add(new Paragraph("- Email: " + booking.getStudent().getEmail()));

            document.add(new Paragraph("\n"));
            document.add(new Paragraph("NỘI DUNG HỢP ĐỒNG:"));
            document.add(new Paragraph("Bên A đồng ý cho Bên B thuê phòng trọ tại địa chỉ: " + booking.getRoom().getAddress()));
            document.add(new Paragraph("- Loại phòng: " + booking.getRoom().getCategory().getName()));
            document.add(new Paragraph("- Tiền thuê phòng: " + booking.getRoom().getPrice() + " VNĐ / tháng"));
            document.add(new Paragraph("- Tiền cọc đã nhận: " + (booking.getRoom().getPrice() / 2) + " VNĐ"));
            document.add(new Paragraph("- Ngày bắt đầu thuê dự kiến: " + booking.getMoveInDate().toString()));

            document.add(new Paragraph("\nHai bên đồng ý các điều khoản trên và cùng ký tên."));

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
