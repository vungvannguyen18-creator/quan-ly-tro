<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../layout/header.jsp"/>

<div class="row mb-4">
    <div class="col-md-4">
        <div class="card text-white bg-primary shadow-sm border-0">
            <div class="card-body">
                <h5 class="card-title"><i class="bi bi-houses-fill"></i> Tổng số phòng</h5>
                <h2 class="display-5 fw-bold mb-0">${total}</h2>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card text-white bg-success shadow-sm border-0">
            <div class="card-body">
                <h5 class="card-title"><i class="bi bi-check-circle-fill"></i> Phòng đang hiển thị</h5>
                <h2 class="display-5 fw-bold mb-0">${active}</h2>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card text-white bg-secondary shadow-sm border-0">
            <div class="card-body">
                <h5 class="card-title"><i class="bi bi-eye-slash-fill"></i> Phòng đang ẩn</h5>
                <h2 class="display-5 fw-bold mb-0">${hidden}</h2>
            </div>
        </div>
    </div>
</div>

<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-white py-3">
        <h4 class="mb-0 fw-bold"><i class="bi bi-building text-primary"></i> Quản lý Phòng trọ</h4>
    </div>
    <div class="card-body">
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success">${sessionScope.message}</div>
            <c:remove var="message" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">${sessionScope.error}</div>
            <c:remove var="error" scope="session"/>
        </c:if>
        
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Hình ảnh</th>
                        <th>Tên phòng</th>
                        <th>Giá (VNĐ)</th>
                        <th>Chủ trọ</th>
                        <th>Khu vực</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="room" items="${rooms}">
                        <tr>
                            <td>#${room.id}</td>
                            <td>
                                <img src="${not empty room.image ? pageContext.request.contextPath.concat('/').concat(room.image) : 'https://via.placeholder.com/80x50'}" alt="${room.title}" class="img-thumbnail" style="width: 80px; height: 50px; object-fit: cover;">
                            </td>
                            <td class="fw-bold" style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" title="${room.title}">${room.title}</td>
                            <td class="text-danger fw-bold"><fmt:formatNumber value="${room.price}" type="currency" currencySymbol=""/></td>
                            <td>${room.owner.fullName}</td>
                            <td>${room.address}</td>
                            <td>
                                <c:if test="${room.status}">
                                    <span class="badge bg-success">Đang hiển thị</span>
                                </c:if>
                                <c:if test="${!room.status}">
                                    <span class="badge bg-secondary">Đã ẩn</span>
                                </c:if>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/room-detail?id=${room.id}" class="btn btn-sm btn-outline-info" title="Xem chi tiết trên Web" target="_blank"><i class="bi bi-eye"></i></a>
                                
                                <c:if test="${room.status}">
                                    <a href="${pageContext.request.contextPath}/admin/rooms/toggleStatus?id=${room.id}" class="btn btn-sm btn-outline-warning" title="Ẩn phòng" onclick="return confirm('Bạn có chắc chắn muốn ẩn phòng này?');"><i class="bi bi-eye-slash"></i></a>
                                </c:if>
                                <c:if test="${!room.status}">
                                    <a href="${pageContext.request.contextPath}/admin/rooms/toggleStatus?id=${room.id}" class="btn btn-sm btn-outline-success" title="Hiện phòng" onclick="return confirm('Cho phép hiển thị lại phòng này?');"><i class="bi bi-check2-circle"></i></a>
                                </c:if>
                                
                                <a href="${pageContext.request.contextPath}/admin/rooms/delete?id=${room.id}" class="btn btn-sm btn-outline-danger" title="Xóa phòng" onclick="return confirm('Bạn có chắc chắn muốn xóa/khóa phòng này khỏi hệ thống?');"><i class="bi bi-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty rooms}">
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">Chưa có phòng trọ nào trên hệ thống</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
