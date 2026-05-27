<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="layout/header.jsp"/>

<div class="row bg-white p-4 rounded shadow-sm">
    <div class="col-md-8">
        <div id="roomCarousel" class="carousel slide mb-4" data-bs-ride="carousel">
            <div class="carousel-inner rounded" style="max-height: 500px;">
                <div class="carousel-item active">
                    <img src="${not empty room.image ? pageContext.request.contextPath.concat('/').concat(room.image) : 'https://via.placeholder.com/800x500?text=No+Image'}" class="d-block w-100" style="object-fit: cover; height: 500px;" alt="${room.title}">
                </div>
            </div>
        </div>
        
        <h2 class="fw-bold mb-3">${room.title}</h2>
        <div class="d-flex align-items-center mb-3">
            <span class="badge bg-success me-2 fs-6">Đang cho thuê</span>
            <span class="text-muted"><i class="bi bi-clock"></i> Đăng ngày: <fmt:formatDate value="${room.owner.createdAt}" pattern="dd/MM/yyyy"/></span>
        </div>
        
        <div class="row text-center my-4 py-3 bg-light rounded">
            <div class="col-4 border-end">
                <span class="d-block text-muted small">Giá thuê</span>
                <span class="text-danger fw-bold fs-4"><fmt:formatNumber value="${room.price}" type="currency" currencySymbol="VNĐ"/>/tháng</span>
            </div>
            <div class="col-4 border-end">
                <span class="d-block text-muted small">Diện tích</span>
                <span class="fw-bold fs-5">${room.area} m²</span>
            </div>
            <div class="col-4">
                <span class="d-block text-muted small">Loại phòng</span>
                <span class="fw-bold fs-5">${room.category.name}</span>
            </div>
        </div>
        
        <h5 class="fw-bold"><i class="bi bi-geo-alt-fill text-danger"></i> Địa chỉ</h5>
        <p class="fs-5">${room.address}</p>
        
        <h5 class="fw-bold mt-4"><i class="bi bi-info-circle-fill text-primary"></i> Thông tin mô tả</h5>
        <div class="p-3 bg-light rounded" style="white-space: pre-line;">
            ${room.description}
        </div>
        
        <!-- Phase 4: Tiện ích -->
        <h5 class="fw-bold mt-4"><i class="bi bi-stars text-warning"></i> Tiện ích nổi bật</h5>
        <div class="row g-3 mb-4">
            <c:if test="${room.hasWifi}"><div class="col-md-4"><i class="bi bi-wifi text-success"></i> Wifi miễn phí</div></c:if>
            <c:if test="${room.hasAirConditioner}"><div class="col-md-4"><i class="bi bi-snow text-info"></i> Máy lạnh</div></c:if>
            <c:if test="${room.hasWashingMachine}"><div class="col-md-4"><i class="bi bi-droplet text-primary"></i> Máy giặt</div></c:if>
            <c:if test="${room.hasParking}"><div class="col-md-4"><i class="bi bi-p-square text-secondary"></i> Chỗ để xe</div></c:if>
            <c:if test="${room.hasCamera}"><div class="col-md-4"><i class="bi bi-camera-video text-danger"></i> Camera an ninh</div></c:if>
            <c:if test="${room.hasGuard}"><div class="col-md-4"><i class="bi bi-person-badge text-dark"></i> Bảo vệ 24/7</div></c:if>
            <c:if test="${room.hasMezzanine}"><div class="col-md-4"><i class="bi bi-layers text-warning"></i> Gác lửng</div></c:if>
        </div>

        <c:if test="${not empty room.latitude and not empty room.longitude}">
            <h5 class="fw-bold mt-4"><i class="bi bi-map-fill text-success"></i> Bản đồ Vị trí</h5>
            <div class="rounded overflow-hidden shadow-sm" style="height: 350px;">
                <iframe 
                    width="100%" 
                    height="100%" 
                    frameborder="0" 
                    scrolling="no" 
                    marginheight="0" 
                    marginwidth="0" 
                    src="https://maps.google.com/maps?q=${room.latitude},${room.longitude}&hl=vi&z=15&amp;output=embed">
                </iframe>
            </div>
        </c:if>
        
        <!-- Phase 4: Reviews -->
        <h5 class="fw-bold mt-5 border-bottom pb-2"><i class="bi bi-star-fill text-warning"></i> Đánh giá từ người thuê (${reviews.size()}) <span class="badge bg-warning text-dark fs-6 ms-2">${averageRating} / 5</span></h5>
        <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'STUDENT'}">
            <div class="card mb-4 border-0 bg-light">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/review/create" method="post">
                        <input type="hidden" name="roomId" value="${room.id}">
                        <div class="mb-2">
                            <label class="fw-bold">Chọn sao:</label>
                            <select name="rating" class="form-select d-inline-block w-auto ms-2">
                                <option value="5">⭐⭐⭐⭐⭐ 5 Sao (Tuyệt vời)</option>
                                <option value="4">⭐⭐⭐⭐ 4 Sao (Tốt)</option>
                                <option value="3">⭐⭐⭐ 3 Sao (Tạm được)</option>
                                <option value="2">⭐⭐ 2 Sao (Kém)</option>
                                <option value="1">⭐ 1 Sao (Tệ)</option>
                            </select>
                        </div>
                        <div class="mb-2">
                            <textarea name="comment" class="form-control" rows="2" placeholder="Nhận xét của bạn về phòng trọ và chủ trọ..." required></textarea>
                        </div>
                        <button type="submit" class="btn btn-warning btn-sm text-white fw-bold">Gửi đánh giá</button>
                    </form>
                </div>
            </div>
        </c:if>
        
        <div class="list-group list-group-flush mb-4">
            <c:forEach var="review" items="${reviews}">
                <div class="list-group-item px-0 py-3">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <strong class="text-primary">${review.user.fullName}</strong>
                        <small class="text-muted"><fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy"/></small>
                    </div>
                    <div>
                        <c:forEach begin="1" end="${review.rating}">
                            <i class="bi bi-star-fill text-warning"></i>
                        </c:forEach>
                        <c:forEach begin="1" end="${5 - review.rating}">
                            <i class="bi bi-star text-warning"></i>
                        </c:forEach>
                    </div>
                    <p class="mb-0 mt-2">${review.comment}</p>
                </div>
            </c:forEach>
            <c:if test="${empty reviews}">
                <p class="text-muted italic">Chưa có đánh giá nào.</p>
            </c:if>
        </div>

        <!-- Phase 6: AI Recommendations -->
        <h5 class="fw-bold mt-5 border-bottom pb-2"><i class="bi bi-magic text-primary"></i> Gợi ý phòng tương tự</h5>
        <div class="row g-3 mb-4">
            <c:forEach var="rec" items="${recommendations}">
                <div class="col-md-6">
                    <div class="card h-100 shadow-sm border-0 room-card">
                        <img src="${not empty rec.image ? pageContext.request.contextPath.concat('/').concat(rec.image) : 'https://via.placeholder.com/400x250?text=No+Image'}" class="card-img-top" alt="${rec.title}" style="height: 150px; object-fit: cover;">
                        <div class="card-body p-2">
                            <h6 class="card-title text-truncate fw-bold mb-1">${rec.title}</h6>
                            <p class="text-danger fw-bold mb-1 small"><fmt:formatNumber value="${rec.price}" type="currency" currencySymbol="VNĐ"/></p>
                            <a href="${pageContext.request.contextPath}/room-detail?id=${rec.id}" class="btn btn-outline-primary btn-sm w-100 mt-2">Xem ngay</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

    </div>
    
    <div class="col-md-4">
        <div class="card shadow-sm border-0 sticky-top" style="top: 80px; border-radius: 12px;">
            <div class="card-body text-center p-4">
                <div class="mb-3">
                    <img src="https://ui-avatars.com/api/?name=${room.owner.fullName}&background=random" class="rounded-circle" width="80" height="80" alt="Avatar">
                </div>
                <h5 class="fw-bold">${room.owner.fullName}</h5>
                <p class="text-muted mb-3">Chủ phòng trọ</p>
                
                <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'STUDENT'}">
                    <form action="${pageContext.request.contextPath}/favorite/toggle" method="post" class="mb-3">
                        <input type="hidden" name="roomId" value="${room.id}">
                        <button type="submit" class="btn ${isFavorite ? 'btn-danger' : 'btn-outline-danger'} w-100 fw-bold">
                            <i class="bi ${isFavorite ? 'bi-heart-fill' : 'bi-heart'}"></i> ${isFavorite ? 'Đã Lưu (Yêu thích)' : 'Lưu Phòng Trọ'}
                        </button>
                    </form>
                </c:if>

                <div class="d-grid gap-2">
                    <a href="tel:${room.owner.phone}" class="btn btn-success btn-lg" style="border-radius: 8px;">
                        <i class="bi bi-telephone-fill"></i> ${room.owner.phone}
                    </a>
                    
                    <c:choose>
                        <c:when test="${not empty sessionScope.user && sessionScope.user.role == 'STUDENT'}">
                            <a href="${pageContext.request.contextPath}/chat?roomId=${room.id}" class="btn btn-outline-primary btn-lg" style="border-radius: 8px;">
                                <i class="bi bi-chat-dots-fill"></i> Gửi tin nhắn
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary btn-lg" style="border-radius: 8px;">
                                <i class="bi bi-chat-dots-fill"></i> Đăng nhập để Chat
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <!-- Nút Đặt phòng mở Modal -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <button type="button" class="btn btn-warning btn-lg mt-2 fw-bold text-white" style="border-radius: 8px;" data-bs-toggle="modal" data-bs-target="#bookingModal">
                                <i class="bi bi-calendar-check"></i> Đặt phòng ngay
                            </button>
                            <button type="button" class="btn btn-link text-danger mt-2 text-decoration-none" data-bs-toggle="modal" data-bs-target="#reportModal">
                                <i class="bi bi-flag-fill"></i> Báo cáo vi phạm
                            </button>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-warning btn-lg mt-2 fw-bold text-white" style="border-radius: 8px;">
                                <i class="bi bi-box-arrow-in-right"></i> Đăng nhập để Đặt phòng
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Report -->
<div class="modal fade" id="reportModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="${pageContext.request.contextPath}/report/create" method="post">
          <div class="modal-header bg-danger text-white">
            <h5 class="modal-title fw-bold">Báo cáo vi phạm</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <input type="hidden" name="roomId" value="${room.id}">
            <div class="mb-3">
                <label class="form-label fw-medium">Lý do báo cáo</label>
                <select name="reason" class="form-select" required>
                    <option value="Báo giá sai">Giá thuê/Chi phí đăng sai sự thật</option>
                    <option value="Báo lừa đảo">Nghi ngờ lừa đảo/Chiếm đoạt tiền cọc</option>
                    <option value="Báo thông tin giả">Hình ảnh/Địa chỉ phòng không đúng</option>
                    <option value="Khác">Lý do khác</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label fw-medium">Mô tả thêm</label>
                <textarea name="description" class="form-control" rows="3" placeholder="Vui lòng cung cấp chi tiết để Admin xử lý..."></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            <button type="submit" class="btn btn-danger">Gửi Báo Cáo</button>
          </div>
      </form>
    </div>
  </div>
</div>

<!-- Modal Đặt Phòng -->
<div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="${pageContext.request.contextPath}/booking/create" method="post">
          <div class="modal-header bg-warning text-white">
            <h5 class="modal-title fw-bold" id="bookingModalLabel">Yêu cầu thuê phòng</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <input type="hidden" name="roomId" value="${room.id}">
            
            <div class="mb-3">
                <label class="form-label fw-medium">Phòng:</label>
                <input type="text" class="form-control" value="${room.title}" readonly>
            </div>
            <div class="mb-3">
                <label class="form-label fw-medium">Ngày nhận phòng dự kiến <span class="text-danger">*</span></label>
                <input type="date" class="form-control" name="moveInDate" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-medium">Số người ở <span class="text-danger">*</span></label>
                <input type="number" class="form-control" name="peopleCount" min="1" value="1" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-medium">Ghi chú cho chủ trọ</label>
                <textarea class="form-control" name="note" rows="3" placeholder="Ví dụ: Em là sinh viên năm nhất..."></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            <button type="submit" class="btn btn-warning fw-bold text-white">Gửi yêu cầu</button>
          </div>
      </form>
    </div>
  </div>
</div>

<jsp:include page="layout/footer.jsp"/>
