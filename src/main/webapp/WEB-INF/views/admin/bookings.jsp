<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../layout/header.jsp"/>

<div class="row bg-white p-4 rounded shadow-sm">
    <div class="col-12 mb-4">
        <h3 class="fw-bold m-0"><i class="bi bi-shield-lock me-2 text-danger"></i>Quản trị - Toàn bộ yêu cầu thuê</h3>
    </div>

    <!-- Thống kê -->
    <div class="col-12 mb-4">
        <div class="row g-3 text-center">
            <div class="col-md-3">
                <div class="p-3 bg-primary bg-opacity-10 rounded border border-primary">
                    <h5 class="text-primary fw-bold mb-1">Tổng số yêu cầu</h5>
                    <h3 class="fw-bold m-0">${total}</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="p-3 bg-success bg-opacity-10 rounded border border-success">
                    <h5 class="text-success fw-bold mb-1">Đã duyệt</h5>
                    <h3 class="fw-bold m-0">${approved}</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="p-3 bg-warning bg-opacity-10 rounded border border-warning">
                    <h5 class="text-warning fw-bold mb-1">Chờ duyệt</h5>
                    <h3 class="fw-bold m-0">${pending}</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="p-3 bg-danger bg-opacity-10 rounded border border-danger">
                    <h5 class="text-danger fw-bold mb-1">Từ chối</h5>
                    <h3 class="fw-bold m-0">${rejected}</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Bảng dữ liệu -->
    <div class="col-12">
        <div class="table-responsive">
            <table class="table table-hover align-middle border">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Sinh viên</th>
                        <th>Chủ trọ</th>
                        <th>Phòng</th>
                        <th>Ngày tạo YC</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td>#${booking.id}</td>
                            <td>${booking.student.fullName}</td>
                            <td>${booking.room.owner.fullName}</td>
                            <td class="fw-medium" style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                ${booking.room.title}
                            </td>
                            <td><fmt:formatDate value="${booking.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${booking.status == 'PENDING'}"><span class="badge bg-warning text-dark">Chờ duyệt</span></c:when>
                                    <c:when test="${booking.status == 'APPROVED'}"><span class="badge bg-success">Đã duyệt</span></c:when>
                                    <c:when test="${booking.status == 'REJECTED'}"><span class="badge bg-danger">Từ chối</span></c:when>
                                    <c:when test="${booking.status == 'CANCELLED'}"><span class="badge bg-secondary">Khách hủy</span></c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/bookings/detail?id=${booking.id}" class="btn btn-sm btn-info text-white"><i class="bi bi-eye"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty bookings}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">Không có dữ liệu.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
