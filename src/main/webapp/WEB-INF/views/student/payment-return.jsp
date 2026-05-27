<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5 mb-5 text-center">
    <div class="row justify-content-center">
        <div class="col-md-6 bg-white p-5 rounded shadow-sm">
            <c:choose>
                <c:when test="${not empty error}">
                    <i class="bi bi-x-circle-fill text-danger" style="font-size: 5rem;"></i>
                    <h3 class="mt-3 fw-bold text-danger">Thanh toán thất bại / Bị hủy</h3>
                    <p class="text-muted mt-3">${error}</p>
                    <a href="${pageContext.request.contextPath}/booking/history" class="btn btn-outline-danger mt-3">Quay lại lịch sử</a>
                </c:when>
                <c:otherwise>
                    <div class="spinner-border text-success" style="width: 5rem; height: 5rem;" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <h3 class="mt-4 fw-bold text-success">Đang xử lý thanh toán...</h3>
                    <p class="text-muted mt-3">${message}</p>
                    <p>Hệ thống đang chờ xác nhận từ PayOS. Quá trình này có thể mất từ 1-3 phút.</p>
                    <a href="${pageContext.request.contextPath}/payment/history" class="btn btn-success mt-3">Xem lịch sử thanh toán</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
