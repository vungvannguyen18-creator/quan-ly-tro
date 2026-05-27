<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../layout/header.jsp"/>

<div class="row bg-white p-4 rounded shadow-sm">
    <div class="col-12 d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold m-0"><i class="bi bi-houses me-2 text-primary"></i>Quản lý Phòng Trọ của bạn</h3>
        <a href="${pageContext.request.contextPath}/landlord/room/add" class="btn btn-primary fw-bold" style="border-radius: 8px;">
            <i class="bi bi-plus-circle me-1"></i> Đăng phòng mới
        </a>
    </div>

    <div class="col-12">
        <div class="table-responsive">
            <table class="table table-hover align-middle border">
                <thead class="table-light">
                    <tr>
                        <th>Hình ảnh</th>
                        <th>Tên phòng</th>
                        <th>Giá thuê</th>
                        <th>Khu vực</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="room" items="${rooms}">
                        <tr>
                            <td>
                                <img src="${not empty room.image ? pageContext.request.contextPath.concat('/').concat(room.image) : 'https://via.placeholder.com/80x50?text=No+Image'}" alt="Room image" width="80" height="50" style="object-fit: cover; border-radius: 5px;">
                            </td>
                            <td class="fw-medium" style="max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${room.title}</td>
                            <td class="text-danger fw-bold"><fmt:formatNumber value="${room.price}" type="currency" currencySymbol="VNĐ"/></td>
                            <td>${room.address}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${room.status}">
                                        <span class="badge bg-success">Đang hiển thị</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Đã ẩn</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/room-detail?id=${room.id}" class="btn btn-sm btn-info text-white" title="Xem trước"><i class="bi bi-eye"></i></a>
                                <a href="${pageContext.request.contextPath}/landlord/room/edit?id=${room.id}" class="btn btn-sm btn-warning" title="Sửa"><i class="bi bi-pencil-square"></i></a>
                                <a href="${pageContext.request.contextPath}/landlord/room/delete?id=${room.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn ẩn phòng này không?');" title="Ẩn/Xóa"><i class="bi bi-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty rooms}">
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">
                                Bạn chưa đăng phòng trọ nào. Hãy <a href="${pageContext.request.contextPath}/landlord/room/add">đăng phòng ngay</a>!
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
