<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../layout/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                <h4 class="mb-0 fw-bold"><i class="bi bi-receipt text-primary"></i> Chi tiết Giao dịch #${payment.orderCode}</h4>
                <a href="${pageContext.request.contextPath}/admin/payments" class="btn btn-sm btn-outline-secondary"><i class="bi bi-arrow-left"></i> Quay lại</a>
            </div>
            <div class="card-body p-4">
                <div class="row mb-4 text-center">
                    <div class="col-12">
                        <h1 class="text-danger fw-bold"><fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="VNĐ"/></h1>
                        <c:choose>
                            <c:when test="${payment.status == 'PAID'}">
                                <span class="badge rounded-pill bg-success fs-6 px-4 py-2"><i class="bi bi-check-circle"></i> Giao dịch thành công</span>
                            </c:when>
                            <c:when test="${payment.status == 'PENDING'}">
                                <span class="badge rounded-pill bg-warning text-dark fs-6 px-4 py-2"><i class="bi bi-hourglass-split"></i> Đang chờ thanh toán</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge rounded-pill bg-danger fs-6 px-4 py-2"><i class="bi bi-x-circle"></i> Giao dịch thất bại / Đã hủy</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <h6 class="fw-bold text-muted border-bottom pb-2">Thông tin Chung</h6>
                        <table class="table table-borderless table-sm">
                            <tr>
                                <td class="text-muted">Mã đơn hàng:</td>
                                <td class="fw-bold text-end">${payment.orderCode}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Mã yêu cầu thuê:</td>
                                <td class="text-end"><a href="${pageContext.request.contextPath}/admin/bookings/detail?id=${payment.booking.id}">#${payment.booking.id}</a></td>
                            </tr>
                            <tr>
                                <td class="text-muted">Thời gian tạo:</td>
                                <td class="text-end"><fmt:formatDate value="${payment.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                            </tr>
                            <tr>
                                <td class="text-muted">Thời gian thanh toán:</td>
                                <td class="text-end">
                                    <c:choose>
                                        <c:when test="${not empty payment.paidAt}">
                                            <fmt:formatDate value="${payment.paidAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted fst-italic">Chưa thanh toán</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-muted">Phương thức:</td>
                                <td class="text-end fw-bold text-primary">PayOS VietQR</td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h6 class="fw-bold text-muted border-bottom pb-2">Đối tác Giao dịch</h6>
                        <table class="table table-borderless table-sm">
                            <tr>
                                <td class="text-muted">Người thanh toán:</td>
                                <td class="fw-bold text-end">${payment.booking.student.fullName}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Người thụ hưởng:</td>
                                <td class="fw-bold text-end">${payment.booking.room.owner.fullName}</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Nội dung thanh toán:</td>
                                <td class="text-end fst-italic">Coc phong ${payment.booking.room.title}</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <c:if test="${payment.status == 'PENDING'}">
                        <a href="${payment.checkoutUrl}" target="_blank" class="btn btn-warning"><i class="bi bi-box-arrow-up-right"></i> Xem Link Thanh Toán PayOS</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
