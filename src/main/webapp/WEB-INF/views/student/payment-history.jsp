<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../layout/header.jsp"/>

<div class="row bg-white p-4 rounded shadow-sm">
    <div class="col-12 mb-4 d-flex justify-content-between align-items-center">
        <h3 class="fw-bold m-0"><i class="bi bi-wallet2 me-2 text-success"></i>Lịch sử thanh toán</h3>
        <a href="${pageContext.request.contextPath}/booking/history" class="btn btn-outline-primary">Lịch sử đặt phòng</a>
    </div>

    <div class="col-12">
        <div class="table-responsive">
            <table class="table table-hover align-middle border">
                <thead class="table-light">
                    <tr>
                        <th>Mã đơn (Order Code)</th>
                        <th>Phòng</th>
                        <th>Số tiền</th>
                        <th>PT Thanh toán</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th>Ngày thanh toán</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="payment" items="${payments}">
                        <tr>
                            <td><strong>#${payment.orderCode}</strong></td>
                            <td class="fw-medium">
                                <a href="${pageContext.request.contextPath}/room-detail?id=${payment.booking.room.id}" class="text-decoration-none">${payment.booking.room.title}</a>
                            </td>
                            <td class="text-danger fw-bold"><fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="VNĐ"/></td>
                            <td>${payment.paymentMethod}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${payment.status == 'PENDING'}">
                                        <span class="badge bg-warning text-dark">Chờ thanh toán</span>
                                        <a href="${payment.checkoutUrl}" class="btn btn-sm btn-primary ms-2" target="_blank">Thanh toán lại</a>
                                    </c:when>
                                    <c:when test="${payment.status == 'PAID'}"><span class="badge bg-success">Đã thanh toán</span></c:when>
                                    <c:when test="${payment.status == 'CANCELLED'}"><span class="badge bg-secondary">Đã hủy</span></c:when>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${payment.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <c:if test="${not empty payment.paidAt}">
                                    <fmt:formatDate value="${payment.paidAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty payments}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">
                                Bạn chưa có giao dịch thanh toán nào.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
