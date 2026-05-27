<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../layout/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
                <h4 class="mb-0 fw-bold"><i class="bi bi-person-plus-fill text-primary"></i> Tạo tài khoản Chủ trọ</h4>
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/landlords/${not empty landlord ? 'edit' : 'create'}" method="post">
                    <c:if test="${not empty landlord}">
                        <input type="hidden" name="id" value="${landlord.id}">
                    </c:if>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="fullName" value="${landlord.fullName}" required placeholder="Nhập họ và tên">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email đăng nhập <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" value="${landlord.email}" ${not empty landlord ? 'readonly bg-light' : 'required'} placeholder="Nhập địa chỉ email">
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="phone" value="${landlord.phone}" required placeholder="Nhập số điện thoại">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Mật khẩu <c:if test="${empty landlord}"><span class="text-danger">*</span></c:if></label>
                            <input type="password" class="form-control" name="password" ${empty landlord ? 'required' : ''} placeholder="${not empty landlord ? 'Bỏ trống nếu không muốn đổi mật khẩu' : 'Nhập mật khẩu cho chủ trọ'}">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Căn cước công dân (CCCD) <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="cccd" value="${landlord.cccd}" required placeholder="Nhập số CCCD">
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label">Địa chỉ liên hệ <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="address" value="${landlord.address}" required placeholder="Nhập địa chỉ của chủ trọ">
                    </div>
                    
                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/admin/landlords" class="btn btn-secondary">Quay lại</a>
                        <button type="submit" class="btn btn-primary"><i class="bi bi-check-circle"></i> ${not empty landlord ? 'Cập nhật' : 'Tạo tài khoản'}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
