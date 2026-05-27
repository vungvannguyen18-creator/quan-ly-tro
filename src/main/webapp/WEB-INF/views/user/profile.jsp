<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../layout/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
                <h4 class="mb-0 fw-bold text-primary"><i class="bi bi-person-lines-fill me-2"></i> Hồ sơ cá nhân</h4>
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${sessionScope.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="message" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <form action="${pageContext.request.contextPath}/profile" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email (Không thể thay đổi)</label>
                        <input type="email" class="form-control text-muted" value="${sessionScope.user.email}" disabled>
                    </div>

                    <div class="mb-3">
                        <label for="fullName" class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="fullName" name="fullName" value="${sessionScope.user.fullName}" required>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label fw-semibold">Số điện thoại <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="phone" name="phone" value="${sessionScope.user.phone}" required pattern="[0-9]{10}" title="Số điện thoại phải gồm 10 chữ số">
                    </div>

                    <div class="mb-3">
                        <label for="cccd" class="form-label fw-semibold">Số CCCD</label>
                        <input type="text" class="form-control" id="cccd" name="cccd" value="${sessionScope.user.cccd}">
                        <div class="form-text">Cần thiết cho Chủ trọ hoặc khi làm hợp đồng thuê phòng.</div>
                    </div>

                    <div class="mb-4">
                        <label for="address" class="form-label fw-semibold">Địa chỉ liên hệ</label>
                        <textarea class="form-control" id="address" name="address" rows="3">${sessionScope.user.address}</textarea>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-light border px-4">Hủy</a>
                        <button type="submit" class="btn btn-primary px-4"><i class="bi bi-save2-fill me-1"></i> Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
