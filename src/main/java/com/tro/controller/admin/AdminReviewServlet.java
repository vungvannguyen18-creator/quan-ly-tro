package com.tro.controller.admin;

import com.tro.dao.ReportDAO;
import com.tro.dao.ReviewDAO;
import com.tro.entity.Report;
import com.tro.entity.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {
    "/admin/reviews", 
    "/admin/reviews/delete", 
    "/admin/reports/resolve", 
    "/admin/reports/dismiss"
})
public class AdminReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO;
    private ReportDAO reportDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
        reportDAO = new ReportDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/reviews".equals(path)) {
            List<Review> reviews = reviewDAO.findAll();
            List<Report> reports = reportDAO.findAll();
            
            long totalReviews = reviews.size();
            long pendingReports = reports.stream().filter(r -> "PENDING".equals(r.getStatus())).count();
            
            request.setAttribute("reviews", reviews);
            request.setAttribute("reports", reports);
            request.setAttribute("totalReviews", totalReviews);
            request.setAttribute("pendingReports", pendingReports);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/reviews.jsp").forward(request, response);
            
        } else if ("/admin/reviews/delete".equals(path)) {
            try {
                Long reviewId = Long.parseLong(request.getParameter("id"));
                reviewDAO.delete(reviewId);
                request.getSession().setAttribute("message", "Đã xóa đánh giá thành công!");
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Không thể xóa đánh giá: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/reviews");
            
        } else if ("/admin/reports/resolve".equals(path)) {
            try {
                Long reportId = Long.parseLong(request.getParameter("id"));
                Report report = reportDAO.findById(reportId);
                if (report != null) {
                    report.setStatus("RESOLVED");
                    reportDAO.update(report);
                    // Có thể tự động ẩn phòng (Room status = false) ở đây nếu muốn
                    request.getSession().setAttribute("message", "Đã xử lý (Khóa phòng/Giải quyết) báo cáo vi phạm!");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Lỗi xử lý báo cáo: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/reviews#reports");
            
        } else if ("/admin/reports/dismiss".equals(path)) {
            try {
                Long reportId = Long.parseLong(request.getParameter("id"));
                Report report = reportDAO.findById(reportId);
                if (report != null) {
                    report.setStatus("DISMISSED");
                    reportDAO.update(report);
                    request.getSession().setAttribute("message", "Đã bỏ qua báo cáo do không có vi phạm!");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Lỗi xử lý báo cáo: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/reviews#reports");
        }
    }
}
