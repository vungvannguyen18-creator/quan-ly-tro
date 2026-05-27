<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../layout/header.jsp"/>

<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
        <h4 class="mb-0 fw-bold"><i class="bi bi-person-badge-fill text-primary"></i> Quản lý Sinh viên</h4>
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
            <table class="table table-hover table-bordered align-middle">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>SĐT</th>
                        <th>Ngày đăng ký</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${students}">
                        <tr>
                            <td>#${student.id}</td>
                            <td class="fw-bold">${student.fullName}</td>
                            <td>${student.email}</td>
                            <td>${student.phone}</td>
                            <td>
                                <fmt:formatDate value="${student.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                            </td>
                            <td>
                                <c:if test="${student.status}">
                                    <span class="badge bg-success">Hoạt động</span>
                                </c:if>
                                <c:if test="${!student.status}">
                                    <span class="badge bg-danger">Bị Khóa</span>
                                </c:if>
                            </td>
                            <td class="text-center">
                                <c:if test="${student.status}">
                                    <a href="${pageContext.request.contextPath}/admin/students/toggleStatus?id=${student.id}" class="btn btn-sm btn-outline-danger" title="Khóa tài khoản" onclick="return confirm('Bạn chắc chắn muốn khóa tài khoản sinh viên này?');"><i class="bi bi-lock-fill"></i> Khóa</a>
                                </c:if>
                                <c:if test="${!student.status}">
                                    <a href="${pageContext.request.contextPath}/admin/students/toggleStatus?id=${student.id}" class="btn btn-sm btn-outline-success" title="Mở khóa tài khoản" onclick="return confirm('Mở khóa tài khoản sinh viên này?');"><i class="bi bi-unlock-fill"></i> Mở khóa</a>
                                </c:if>
                                <!-- Optional View Details Button -->
                                <a href="${pageContext.request.contextPath}/admin/bookings?studentId=${student.id}" class="btn btn-sm btn-outline-info" title="Xem yêu cầu thuê"><i class="bi bi-journal-text"></i> Xem YCT</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty students}">
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">Chưa có sinh viên nào đăng ký tài khoản</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
