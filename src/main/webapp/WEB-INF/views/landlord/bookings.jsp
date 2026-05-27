<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../layout/header.jsp"/>

<div class="row bg-white p-4 rounded shadow-sm">
    <div class="col-12 mb-4">
        <h3 class="fw-bold m-0"><i class="bi bi-inboxes me-2 text-primary"></i>Quản lý Yêu cầu thuê phòng</h3>
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
                        <th>Người thuê</th>
                        <th>Phòng yêu cầu</th>
                        <th>Ngày nhận phòng</th>
                        <th>Ghi chú</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td>
                                <strong>${booking.student.fullName}</strong><br>
                                <small class="text-muted"><i class="bi bi-telephone"></i> ${booking.student.phone}</small>
                            </td>
                            <td class="fw-medium" style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                <a href="${pageContext.request.contextPath}/room-detail?id=${booking.room.id}" class="text-decoration-none" target="_blank">${booking.room.title}</a>
                            </td>
                            <td><fmt:formatDate value="${booking.moveInDate}" pattern="dd/MM/yyyy"/></td>
                            <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${booking.note}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${booking.status == 'PENDING'}"><span class="badge bg-warning text-dark">Chờ duyệt</span></c:when>
                                    <c:when test="${booking.status == 'APPROVED'}"><span class="badge bg-success">Đã duyệt</span></c:when>
                                    <c:when test="${booking.status == 'REJECTED'}"><span class="badge bg-danger">Đã từ chối</span></c:when>
                                    <c:when test="${booking.status == 'CANCELLED'}"><span class="badge bg-secondary">Khách hủy</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:if test="${booking.status == 'PENDING'}">
                                    <div class="btn-group" role="group">
                                        <form action="${pageContext.request.contextPath}/landlord/bookings/approve" method="post" class="d-inline">
                                            <input type="hidden" name="id" value="${booking.id}">
                                            <button type="submit" class="btn btn-sm btn-success" title="Duyệt"><i class="bi bi-check-lg"></i></button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/landlord/bookings/reject" method="post" class="d-inline ms-1">
                                            <input type="hidden" name="id" value="${booking.id}">
                                            <button type="submit" class="btn btn-sm btn-danger" title="Từ chối"><i class="bi bi-x-lg"></i></button>
                                        </form>
                                    </div>
                                </c:if>
                                <c:if test="${booking.status == 'CONFIRMED'}">
                                    <a href="${pageContext.request.contextPath}/contract/download?bookingId=${booking.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-file-earmark-pdf-fill"></i> Tải HĐ</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty bookings}">
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">
                                Chưa có ai gửi yêu cầu thuê phòng của bạn.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
