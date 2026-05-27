<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../layout/header.jsp"/>

<div class="row bg-white p-4 rounded shadow-sm">
    <div class="col-12 mb-4">
        <h3 class="fw-bold m-0"><i class="bi bi-clock-history me-2 text-warning"></i>Lịch sử đặt phòng</h3>
    </div>

    <c:if test="${not empty sessionScope.message}">
        <div class="col-12">
            <div class="alert alert-success">${sessionScope.message}</div>
            <c:remove var="message" scope="session"/>
        </div>
    </c:if>

    <div class="col-12">
        <div class="table-responsive">
            <table class="table table-hover align-middle border">
                <thead class="table-light">
                    <tr>
                        <th>Tên phòng</th>
                        <th>Chủ trọ</th>
                        <th>Ngày gửi YC</th>
                        <th>Ngày nhận phòng</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td class="fw-medium" style="max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                <a href="${pageContext.request.contextPath}/room-detail?id=${booking.room.id}" class="text-decoration-none">${booking.room.title}</a>
                            </td>
                            <td>${booking.room.owner.fullName}</td>
                            <td><fmt:formatDate value="${booking.createdAt}" type="both" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td><fmt:formatDate value="${booking.moveInDate}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${booking.status == 'PENDING'}"><span class="badge bg-warning text-dark">Chờ duyệt</span></c:when>
                                    <c:when test="${booking.status == 'APPROVED'}"><span class="badge bg-success">Đã duyệt</span></c:when>
                                    <c:when test="${booking.status == 'REJECTED'}"><span class="badge bg-danger">Từ chối</span></c:when>
                                    <c:when test="${booking.status == 'CANCELLED'}"><span class="badge bg-secondary">Đã hủy</span></c:when>
                                    <c:when test="${booking.status == 'CONFIRMED'}"><span class="badge bg-primary">Đã xác nhận</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:if test="${booking.status == 'PENDING'}">
                                    <form action="${pageContext.request.contextPath}/booking/cancel" method="post" class="d-inline">
                                        <input type="hidden" name="id" value="${booking.id}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn chắc chắn muốn hủy yêu cầu này?');">Hủy</button>
                                    </form>
                                </c:if>
                                <c:if test="${booking.status == 'APPROVED'}">
                                    <form action="${pageContext.request.contextPath}/payment/create" method="post" class="d-inline">
                                        <input type="hidden" name="bookingId" value="${booking.id}">
                                        <button type="submit" class="btn btn-sm btn-success fw-bold"><i class="bi bi-wallet2"></i> Thanh toán cọc</button>
                                    </form>
                                </c:if>
                                <c:if test="${booking.status == 'WAITING_PAYMENT'}">
                                    <a href="${pageContext.request.contextPath}/payment/history" class="btn btn-sm btn-info text-white">Chờ thanh toán</a>
                                </c:if>
                                <c:if test="${booking.status == 'CONFIRMED'}">
                                    <a href="${pageContext.request.contextPath}/contract/download?bookingId=${booking.id}" class="btn btn-sm btn-outline-primary fw-bold"><i class="bi bi-file-earmark-pdf-fill"></i> Tải Hợp Đồng</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty bookings}">
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">
                                Bạn chưa có yêu cầu thuê phòng nào. Hãy tìm và <a href="${pageContext.request.contextPath}/home">đặt phòng ngay</a>!
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
