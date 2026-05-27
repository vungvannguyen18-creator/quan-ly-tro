<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../layout/header.jsp"/>

<div class="row justify-content-center">
    <div class="col-lg-8 bg-white p-5 rounded shadow-sm">
        <h3 class="fw-bold mb-4 text-center">
            ${empty room ? 'Đăng Phòng Trọ Mới' : 'Cập Nhật Phòng Trọ'}
        </h3>
        
        <form action="${pageContext.request.contextPath}/landlord/room/${empty room ? 'add' : 'edit'}" method="post" enctype="multipart/form-data">
            <c:if test="${not empty room}">
                <input type="hidden" name="id" value="${room.id}">
            </c:if>
            
            <div class="row g-3">
                <div class="col-md-12">
                    <label class="form-label fw-medium">Tên phòng / Tiêu đề tin <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="title" value="${room.title}" required placeholder="VD: Phòng trọ khép kín, có gác lửng gần ĐH Cần Thơ">
                </div>
                
                <div class="col-md-4">
                    <label class="form-label fw-medium">Giá thuê (VNĐ/tháng) <span class="text-danger">*</span></label>
                    <input type="number" class="form-control" name="price" value="${room.price}" required placeholder="VD: 2500000">
                </div>
                
                <div class="col-md-4">
                    <label class="form-label fw-medium">Diện tích (m²) <span class="text-danger">*</span></label>
                    <input type="number" step="0.1" class="form-control" name="area" value="${room.area}" required placeholder="VD: 20">
                </div>

                <div class="col-md-4">
                    <label class="form-label fw-medium">Số người tối đa <span class="text-danger">*</span></label>
                    <input type="number" class="form-control" name="maxPeople" value="${room.maxPeople}" required placeholder="VD: 3">
                </div>
                
                <div class="col-md-6">
                    <label class="form-label fw-medium">Khu vực / Quận Huyện <span class="text-danger">*</span></label>
                    <select class="form-select" name="address" required>
                        <option value="">-- Chọn khu vực --</option>
                        <option value="Ninh Kiều" ${room.address == 'Ninh Kiều' ? 'selected' : ''}>Ninh Kiều</option>
                        <option value="Bình Thủy" ${room.address == 'Bình Thủy' ? 'selected' : ''}>Bình Thủy</option>
                        <option value="Cái Răng" ${room.address == 'Cái Răng' ? 'selected' : ''}>Cái Răng</option>
                        <option value="Ô Môn" ${room.address == 'Ô Môn' ? 'selected' : ''}>Ô Môn</option>
                    </select>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label fw-medium">Loại phòng <span class="text-danger">*</span></label>
                    <select class="form-select" name="categoryId" required>
                        <option value="">-- Chọn loại phòng --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${room.category.id == cat.id ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="col-md-12">
                    <label class="form-label fw-medium">Ảnh đại diện phòng</label>
                    <input type="file" class="form-control" name="image" accept="image/*" ${empty room ? 'required' : ''}>
                    <c:if test="${not empty room.image}">
                        <div class="mt-2">
                            <img src="${pageContext.request.contextPath}/${room.image}" alt="Current Image" width="150" class="rounded">
                        </div>
                    </c:if>
                </div>
                
                <div class="col-md-12">
                    <label class="form-label fw-medium">Tiện ích (Đánh dấu nếu có)</label>
                    <div class="row g-2">
                        <div class="col-md-3"><div class="form-check"><input class="form-check-input" type="checkbox" name="hasWifi" value="true" ${room.hasWifi ? 'checked' : ''}> <label class="form-check-label">Wifi miễn phí</label></div></div>
                        <div class="col-md-3"><div class="form-check"><input class="form-check-input" type="checkbox" name="hasAirConditioner" value="true" ${room.hasAirConditioner ? 'checked' : ''}> <label class="form-check-label">Máy lạnh</label></div></div>
                        <div class="col-md-3"><div class="form-check"><input class="form-check-input" type="checkbox" name="hasWashingMachine" value="true" ${room.hasWashingMachine ? 'checked' : ''}> <label class="form-check-label">Máy giặt</label></div></div>
                        <div class="col-md-3"><div class="form-check"><input class="form-check-input" type="checkbox" name="hasParking" value="true" ${room.hasParking ? 'checked' : ''}> <label class="form-check-label">Chỗ để xe</label></div></div>
                        <div class="col-md-3"><div class="form-check"><input class="form-check-input" type="checkbox" name="hasCamera" value="true" ${room.hasCamera ? 'checked' : ''}> <label class="form-check-label">Camera an ninh</label></div></div>
                        <div class="col-md-3"><div class="form-check"><input class="form-check-input" type="checkbox" name="hasGuard" value="true" ${room.hasGuard ? 'checked' : ''}> <label class="form-check-label">Bảo vệ 24/7</label></div></div>
                        <div class="col-md-3"><div class="form-check"><input class="form-check-input" type="checkbox" name="hasMezzanine" value="true" ${room.hasMezzanine ? 'checked' : ''}> <label class="form-check-label">Gác lửng</label></div></div>
                    </div>
                </div>

                <div class="col-md-4">
                    <label class="form-label fw-medium">Đối tượng cho thuê</label>
                    <select class="form-select" name="genderAllowed">
                        <option value="ALL" ${room.genderAllowed == 'ALL' ? 'selected' : ''}>Nam & Nữ</option>
                        <option value="NAM" ${room.genderAllowed == 'NAM' ? 'selected' : ''}>Chỉ Nam</option>
                        <option value="NU" ${room.genderAllowed == 'NU' ? 'selected' : ''}>Chỉ Nữ</option>
                    </select>
                </div>
                
                <div class="col-md-4">
                    <label class="form-label fw-medium">Vĩ độ (Latitude) - Google Maps</label>
                    <input type="text" class="form-control" name="latitude" value="${room.latitude}" placeholder="VD: 10.029933">
                </div>
                
                <div class="col-md-4">
                    <label class="form-label fw-medium">Kinh độ (Longitude) - Google Maps</label>
                    <input type="text" class="form-control" name="longitude" value="${room.longitude}" placeholder="VD: 105.770615">
                </div>
                
                <div class="col-md-12">
                    <label class="form-label fw-medium">Mô tả chi tiết <span class="text-danger">*</span></label>
                    <textarea class="form-control" name="description" rows="5" required placeholder="Nội thất có gì? Giờ giấc ra sao? Phụ phí điện nước...">${room.description}</textarea>
                </div>
                
                <c:if test="${not empty room}">
                    <div class="col-md-12">
                        <label class="form-label fw-medium">Trạng thái hiển thị</label>
                        <select class="form-select" name="status">
                            <option value="true" ${room.status ? 'selected' : ''}>Hiển thị</option>
                            <option value="false" ${!room.status ? 'selected' : ''}>Ẩn (Không cho thuê nữa)</option>
                        </select>
                    </div>
                </c:if>
                
                <!-- Nút xem quy định -->
                <div class="col-md-12 mt-4">
                    <div class="alert alert-info d-flex align-items-center" role="alert">
                        <i class="bi bi-info-circle-fill me-2 fs-4"></i>
                        <div>
                            Vui lòng đọc kỹ <span style="cursor:pointer;" data-bs-toggle="modal" data-bs-target="#rulesModal" class="alert-link text-decoration-underline text-primary fw-bold">Quy định đăng tin</span> trước khi đăng bài. 
                            Vi phạm quy định có thể dẫn đến khóa tài khoản vĩnh viễn.
                        </div>
                    </div>
                </div>

                <!-- Cam kết -->
                <div class="col-md-12">
                    <label class="form-label fw-bold text-danger">Cam kết của chủ trọ <span class="text-danger">*</span></label>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="checkbox" id="commit1" required>
                        <label class="form-check-label" for="commit1">Tôi cam kết thông tin đăng tải là chính xác.</label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="checkbox" id="commit2" required>
                        <label class="form-check-label" for="commit2">Tôi chịu trách nhiệm trước pháp luật về nội dung bài đăng.</label>
                    </div>
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="checkbox" id="commit3" required>
                        <label class="form-check-label" for="commit3">Tôi đồng ý với <span style="cursor:pointer;" data-bs-toggle="modal" data-bs-target="#rulesModal" onclick="event.stopPropagation();" class="text-primary text-decoration-underline fw-bold">quy định đăng tin</span> của hệ thống Tìm Trọ Nhanh.</label>
                    </div>
                </div>
                
                <div class="col-12 mt-4 text-center">
                    <a href="${pageContext.request.contextPath}/landlord/rooms" class="btn btn-secondary px-4 me-2">Hủy</a>
                    <button type="submit" class="btn btn-primary px-5 fw-bold">${empty room ? 'Đăng tin' : 'Lưu thay đổi'}</button>
                </div>
            </div>
        </form>
    </div>
<jsp:include page="../layout/footer.jsp"/>
