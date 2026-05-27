<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../layout/header.jsp"/>

<div class="row mb-4">
    <div class="col-md-3">
        <div class="card text-white bg-primary shadow-sm border-0">
            <div class="card-body">
                <h6 class="card-title"><i class="bi bi-receipt"></i> Tổng giao dịch</h6>
                <h3 class="fw-bold mb-0">${total}</h3>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-success shadow-sm border-0">
            <div class="card-body">
                <h6 class="card-title"><i class="bi bi-check-circle-fill"></i> Đã thanh toán</h6>
                <h3 class="fw-bold mb-0">${paid}</h3>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-dark bg-warning shadow-sm border-0">
            <div class="card-body">
                <h6 class="card-title"><i class="bi bi-hourglass-split"></i> Chờ thanh toán</h6>
                <h3 class="fw-bold mb-0">${pending}</h3>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-danger shadow-sm border-0">
            <div class="card-body">
                <h6 class="card-title"><i class="bi bi-x-circle-fill"></i> Thất bại / Đã hủy</h6>
                <h3 class="fw-bold mb-0">${failed}</h3>
            </div>
        </div>
    </div>
</div>

<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-white py-3">
        <h4 class="mb-0 fw-bold"><i class="bi bi-wallet2 text-success"></i> Quản lý Giao dịch PayOS</h4>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover align-middle border">
                <thead class="table-light">
                    <tr>
                        <th>Mã đơn (OrderCode)</th>
                        <th>Khách hàng</th>
                        <th>Chủ trọ</th>
                        <th>Số tiền (VNĐ)</th>
                        <th>Phương thức</th>
                        <th>Thời gian tạo</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="payment" items="${payments}">
                        <tr>
                            <td class="fw-bold text-primary">#${payment.orderCode}</td>
                            <td>${payment.booking.student.fullName}</td>
                            <td>${payment.booking.room.owner.fullName}</td>
                            <td class="text-danger fw-bold"><fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol=""/></td>
                            <td>
                                <span class="badge bg-info text-dark"><i class="bi bi-bank"></i> ${not empty payment.paymentMethod ? payment.paymentMethod : 'VietQR'}</span>
                            </td>
                            <td><fmt:formatDate value="${payment.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${payment.status == 'PAID'}">
                                        <span class="badge bg-success">Đã thanh toán</span>
                                    </c:when>
                                    <c:when test="${payment.status == 'PENDING'}">
                                        <span class="badge bg-warning text-dark">Chờ thanh toán</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Thất bại/Hủy</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/payments/detail?orderCode=${payment.orderCode}" class="btn btn-sm btn-outline-primary"><i class="bi bi-eye"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty payments}">
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">Chưa có giao dịch nào</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
