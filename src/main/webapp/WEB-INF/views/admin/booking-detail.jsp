<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../layout/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-md-8 bg-white p-5 rounded shadow-sm">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold m-0"><i class="bi bi-file-earmark-text text-primary me-2"></i>Chi tiết Yêu cầu thuê phòng # ${booking.id}</h3>
            <a href="${pageContext.request.contextPath}/admin/bookings" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left"></i> Quay lại</a>
        </div>
        
        <div class="card mb-4 border-0 bg-light">
            <div class="card-body">
                <h5 class="fw-bold border-bottom pb-2">Thông tin Sinh viên (Người thuê)</h5>
                <p class="mb-1"><strong>Họ tên:</strong> ${booking.student.fullName}</p>
                <p class="mb-1"><strong>Email:</strong> ${booking.student.email}</p>
                <p class="mb-1"><strong>Số điện thoại:</strong> ${booking.student.phone}</p>
            </div>
        </div>

        <div class="card mb-4 border-0 bg-light">
            <div class="card-body">
                <h5 class="fw-bold border-bottom pb-2">Thông tin Phòng & Chủ trọ</h5>
                <p class="mb-1"><strong>Tên phòng:</strong> <a href="${pageContext.request.contextPath}/room-detail?id=${booking.room.id}" target="_blank">${booking.room.title}</a></p>
                <p class="mb-1"><strong>Địa chỉ:</strong> ${booking.room.address}</p>
                <p class="mb-1"><strong>Giá thuê:</strong> <span class="text-danger fw-bold"><fmt:formatNumber value="${booking.room.price}" type="currency" currencySymbol="VNĐ"/></span></p>
                <p class="mb-1 mt-3"><strong>Chủ trọ:</strong> ${booking.room.owner.fullName} (${booking.room.owner.phone})</p>
            </div>
        </div>

        <div class="card border-0 shadow-sm border border-primary">
            <div class="card-body">
                <h5 class="fw-bold border-bottom pb-2 text-primary">Nội dung Yêu cầu</h5>
                <p class="mb-1"><strong>Ngày nhận phòng dự kiến:</strong> <fmt:formatDate value="${booking.moveInDate}" pattern="dd/MM/yyyy"/></p>
                <p class="mb-1"><strong>Số người ở:</strong> ${booking.peopleCount} người</p>
                <p class="mb-1"><strong>Ngày tạo yêu cầu:</strong> <fmt:formatDate value="${booking.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></p>
                <div class="mb-3 mt-2 p-3 bg-white rounded border">
                    <strong>Ghi chú từ sinh viên:</strong><br>
                    ${not empty booking.note ? booking.note : '<i class="text-muted">Không có ghi chú</i>'}
                </div>
                
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <span class="fs-5"><strong>Trạng thái hiện tại:</strong></span>
                    <c:choose>
                        <c:when test="${booking.status == 'PENDING'}"><span class="badge bg-warning text-dark fs-5">Chờ duyệt</span></c:when>
                        <c:when test="${booking.status == 'APPROVED'}"><span class="badge bg-success fs-5">Đã duyệt (<fmt:formatDate value="${booking.approvedAt}" pattern="dd/MM/yyyy"/>)</span></c:when>
                        <c:when test="${booking.status == 'REJECTED'}"><span class="badge bg-danger fs-5">Từ chối (<fmt:formatDate value="${booking.rejectedAt}" pattern="dd/MM/yyyy"/>)</span></c:when>
                        <c:when test="${booking.status == 'CANCELLED'}"><span class="badge bg-secondary fs-5">Sinh viên đã hủy</span></c:when>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
