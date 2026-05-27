<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="layout/header.jsp"/>

<!-- Banner/Search Section -->
<div class="p-5 mb-4 bg-light rounded-3 shadow-sm" style="background: url('https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&q=80&w=2000') center/cover; position: relative;">
    <div style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); border-radius: inherit;"></div>
    <div class="container-fluid py-5 text-white" style="position: relative; z-index: 1;">
        <h1 class="display-5 fw-bold text-center">Tìm phòng trọ nhanh chóng</h1>
        <p class="col-md-8 mx-auto fs-5 text-center">Khám phá hàng ngàn phòng trọ, chung cư mini chất lượng cao với mức giá phù hợp nhất.</p>
        
        <form action="${pageContext.request.contextPath}/home" method="get" class="row g-2 justify-content-center mt-4">
            <div class="col-md-3">
                <input type="text" class="form-control form-control-lg" name="keyword" placeholder="Nhập tên phòng, khu vực..." value="${param.keyword}">
            </div>
            <div class="col-md-2">
                <input type="number" class="form-control form-control-lg" name="minPrice" placeholder="Giá từ (VNĐ)" value="${param.minPrice}">
            </div>
            <div class="col-md-2">
                <input type="number" class="form-control form-control-lg" name="maxPrice" placeholder="Đến giá (VNĐ)" value="${param.maxPrice}">
            </div>
            <div class="col-md-2">
                <select class="form-select form-select-lg" name="address">
                    <option value="">Tất cả khu vực</option>
                    <option value="Ninh Kiều" ${param.address == 'Ninh Kiều' ? 'selected' : ''}>Ninh Kiều</option>
                    <option value="Bình Thủy" ${param.address == 'Bình Thủy' ? 'selected' : ''}>Bình Thủy</option>
                    <option value="Cái Răng" ${param.address == 'Cái Răng' ? 'selected' : ''}>Cái Răng</option>
                    <option value="Ô Môn" ${param.address == 'Ô Môn' ? 'selected' : ''}>Ô Môn</option>
                </select>
            </div>
            <div class="col-md-2">
                <button class="btn btn-warning btn-lg w-100 fw-bold" type="submit"><i class="bi bi-search"></i> Tìm kiếm</button>
            </div>
            
            <!-- Bộ lọc nâng cao Phase 4 -->
            <div class="col-12 mt-3">
                <a class="text-white text-decoration-none border-bottom" data-bs-toggle="collapse" href="#advancedFilters" role="button" aria-expanded="false" aria-controls="advancedFilters">
                    <i class="bi bi-funnel"></i> Bộ lọc nâng cao
                </a>
                <div class="collapse mt-3" id="advancedFilters">
                    <div class="card card-body bg-dark bg-opacity-50 text-start border-0">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label class="fw-bold">Tiện ích:</label>
                                <div class="form-check"><input class="form-check-input" type="checkbox" name="hasWifi" value="true" ${param.hasWifi == 'true' ? 'checked' : ''}> <label class="form-check-label">Wifi miễn phí</label></div>
                                <div class="form-check"><input class="form-check-input" type="checkbox" name="hasAirConditioner" value="true" ${param.hasAirConditioner == 'true' ? 'checked' : ''}> <label class="form-check-label">Máy lạnh</label></div>
                                <div class="form-check"><input class="form-check-input" type="checkbox" name="hasParking" value="true" ${param.hasParking == 'true' ? 'checked' : ''}> <label class="form-check-label">Chỗ để xe</label></div>
                            </div>
                            <div class="col-md-3">
                                <label class="fw-bold">Đối tượng thuê:</label>
                                <select class="form-select" name="genderAllowed">
                                    <option value="ALL" ${param.genderAllowed == 'ALL' ? 'selected' : ''}>Không giới hạn (Tất cả)</option>
                                    <option value="NAM" ${param.genderAllowed == 'NAM' ? 'selected' : ''}>Chỉ Nam</option>
                                    <option value="NU" ${param.genderAllowed == 'NU' ? 'selected' : ''}>Chỉ Nữ</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Room List Section -->
<h3 class="mb-4 fw-bold" style="color: #333;">Danh sách phòng nổi bật</h3>
<div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
    <c:forEach var="room" items="${rooms}">
        <div class="col">
            <div class="card h-100 shadow-sm border-0" style="border-radius: 12px; overflow: hidden; transition: transform 0.3s;">
                <img src="${not empty room.image ? pageContext.request.contextPath.concat('/').concat(room.image) : 'https://via.placeholder.com/400x250?text=No+Image'}" class="card-img-top" alt="${room.title}" style="height: 200px; object-fit: cover;">
                <div class="card-body">
                    <h5 class="card-title text-truncate fw-bold" style="font-size: 1.1rem;">${room.title}</h5>
                    <p class="card-text text-danger fw-bold fs-5 mb-1">
                        <fmt:formatNumber value="${room.price}" type="currency" currencySymbol="VNĐ"/>
                    </p>
                    <p class="card-text text-muted mb-2"><i class="bi bi-rulers"></i> ${room.area} m²</p>
                    <p class="card-text text-muted small text-truncate"><i class="bi bi-geo-alt-fill"></i> ${room.address}</p>
                </div>
                <div class="card-footer bg-white border-top-0 pb-3">
                    <a href="${pageContext.request.contextPath}/room-detail?id=${room.id}" class="btn btn-outline-primary w-100" style="border-radius: 8px;">Xem chi tiết</a>
                </div>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty rooms}">
        <div class="col-12 text-center py-5">
            <h4 class="text-muted">Không tìm thấy phòng trọ nào phù hợp.</h4>
        </div>
    </c:if>
</div>

<style>
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
    }
</style>

<jsp:include page="layout/footer.jsp"/>
