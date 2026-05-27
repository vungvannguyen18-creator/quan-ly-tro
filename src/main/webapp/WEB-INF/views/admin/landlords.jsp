<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../layout/header.jsp"/>

<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
        <h4 class="mb-0 fw-bold"><i class="bi bi-people-fill text-primary"></i> Quản lý Chủ trọ</h4>
        <a href="${pageContext.request.contextPath}/admin/landlords/create" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Tạo Chủ trọ mới</a>
    </div>
    <div class="card-body">
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success">${sessionScope.message}</div>
            <c:remove var="message" scope="session"/>
        </c:if>
        
        <div class="table-responsive">
            <table class="table table-hover table-bordered align-middle">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>SĐT</th>
                        <th>CCCD</th>
                        <th>Địa chỉ</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="landlord" items="${landlords}">
                        <tr>
                            <td>#${landlord.id}</td>
                            <td class="fw-bold">${landlord.fullName}</td>
                            <td>${landlord.email}</td>
                            <td>${landlord.phone}</td>
                            <td>${not empty landlord.cccd ? landlord.cccd : '-'}</td>
                            <td>${not empty landlord.address ? landlord.address : '-'}</td>
                            <td>
                                <c:if test="${landlord.status}">
                                    <span class="badge bg-success">Hoạt động</span>
                                </c:if>
                                <c:if test="${!landlord.status}">
                                    <span class="badge bg-danger">Khóa</span>
                                </c:if>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/landlords/edit?id=${landlord.id}" class="btn btn-sm btn-outline-primary" title="Sửa"><i class="bi bi-pencil"></i></a>
                                <c:if test="${landlord.status}">
                                    <a href="${pageContext.request.contextPath}/admin/landlords/toggleStatus?id=${landlord.id}" class="btn btn-sm btn-outline-danger" title="Khóa" onclick="return confirm('Khóa tài khoản Chủ trọ này sẽ ẩn toàn bộ phòng của họ. Bạn chắc chắn chứ?');"><i class="bi bi-lock-fill"></i></a>
                                </c:if>
                                <c:if test="${!landlord.status}">
                                    <a href="${pageContext.request.contextPath}/admin/landlords/toggleStatus?id=${landlord.id}" class="btn btn-sm btn-outline-success" title="Mở khóa" onclick="return confirm('Mở khóa tài khoản Chủ trọ này?');"><i class="bi bi-unlock-fill"></i></a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/admin/rooms?ownerId=${landlord.id}" class="btn btn-sm btn-outline-info" title="Xem phòng"><i class="bi bi-house-door"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty landlords}">
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">Chưa có dữ liệu Chủ trọ</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
