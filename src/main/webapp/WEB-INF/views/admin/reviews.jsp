<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../layout/header.jsp"/>

<div class="row mb-4">
    <div class="col-md-6">
        <div class="card text-white bg-info shadow-sm border-0">
            <div class="card-body">
                <h5 class="card-title"><i class="bi bi-star-fill text-warning"></i> Tổng số đánh giá</h5>
                <h2 class="display-5 fw-bold mb-0">${totalReviews}</h2>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card text-white bg-danger shadow-sm border-0">
            <div class="card-body">
                <h5 class="card-title"><i class="bi bi-exclamation-triangle-fill"></i> Báo cáo vi phạm chờ xử lý</h5>
                <h2 class="display-5 fw-bold mb-0">${pendingReports}</h2>
            </div>
        </div>
    </div>
</div>

<div class="card shadow-sm border-0 mb-5">
    <div class="card-header bg-white py-3">
        <ul class="nav nav-pills card-header-pills" id="reviewTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active fw-bold" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button" role="tab"><i class="bi bi-chat-right-quote"></i> Danh sách Đánh giá</button>
            </li>
            <li class="nav-item ms-2" role="presentation">
                <button class="nav-link fw-bold text-danger" id="reports-tab" data-bs-toggle="tab" data-bs-target="#reports" type="button" role="tab">
                    <i class="bi bi-flag-fill"></i> Báo cáo Vi phạm
                    <c:if test="${pendingReports > 0}"><span class="badge bg-danger rounded-pill ms-1">${pendingReports}</span></c:if>
                </button>
            </li>
        </ul>
    </div>
    
    <div class="card-body p-0">
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success m-3">${sessionScope.message}</div>
            <c:remove var="message" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger m-3">${sessionScope.error}</div>
            <c:remove var="error" scope="session"/>
        </c:if>
        
        <div class="tab-content" id="myTabContent">
            <!-- TAB 1: Đánh giá -->
            <div class="tab-pane fade show active" id="reviews" role="tabpanel">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Người dùng</th>
                                <th>Phòng</th>
                                <th>Đánh giá (Sao)</th>
                                <th style="width: 30%">Nội dung</th>
                                <th>Thời gian</th>
                                <th class="text-center pe-4">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="review" items="${reviews}">
                                <tr>
                                    <td class="ps-4">#${review.id}</td>
                                    <td class="fw-bold">${review.user.fullName}</td>
                                    <td><a href="${pageContext.request.contextPath}/room-detail?id=${review.room.id}" target="_blank" class="text-decoration-none">${review.room.title}</a></td>
                                    <td class="text-warning">
                                        <c:forEach begin="1" end="${review.rating}"><i class="bi bi-star-fill"></i></c:forEach>
                                        <c:forEach begin="${review.rating + 1}" end="5"><i class="bi bi-star"></i></c:forEach>
                                    </td>
                                    <td>${review.comment}</td>
                                    <td class="text-muted"><small><fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy HH:mm"/></small></td>
                                    <td class="text-center pe-4">
                                        <a href="${pageContext.request.contextPath}/admin/reviews/delete?id=${review.id}" class="btn btn-sm btn-outline-danger" title="Xóa đánh giá này" onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này khỏi hệ thống?');"><i class="bi bi-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty reviews}">
                                <tr><td colspan="7" class="text-center py-5 text-muted">Chưa có đánh giá nào.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- TAB 2: Báo cáo vi phạm -->
            <div class="tab-pane fade" id="reports" role="tabpanel">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-danger">
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Người tố cáo</th>
                                <th>Phòng bị tố cáo</th>
                                <th>Lý do vi phạm</th>
                                <th style="width: 25%">Chi tiết (Bằng chứng)</th>
                                <th>Trạng thái</th>
                                <th class="text-center pe-4">Quyết định xử lý</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="report" items="${reports}">
                                <tr class="${report.status == 'PENDING' ? 'table-warning' : ''}">
                                    <td class="ps-4">#${report.id}</td>
                                    <td class="fw-bold">${report.user.fullName}</td>
                                    <td><a href="${pageContext.request.contextPath}/room-detail?id=${report.room.id}" target="_blank" class="text-decoration-none fw-bold text-danger">${report.room.title}</a></td>
                                    <td class="fw-bold text-dark"><i class="bi bi-exclamation-triangle text-danger"></i> ${report.reason}</td>
                                    <td><small>${report.description}</small></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${report.status == 'PENDING'}"><span class="badge bg-warning text-dark">Đang chờ xử lý</span></c:when>
                                            <c:when test="${report.status == 'RESOLVED'}"><span class="badge bg-success">Đã giải quyết (Có vi phạm)</span></c:when>
                                            <c:when test="${report.status == 'DISMISSED'}"><span class="badge bg-secondary">Bỏ qua (Không vi phạm)</span></c:when>
                                        </c:choose>
                                    </td>
                                    <td class="text-center pe-4">
                                        <c:if test="${report.status == 'PENDING'}">
                                            <a href="${pageContext.request.contextPath}/admin/reports/resolve?id=${report.id}" class="btn btn-sm btn-danger mb-1" title="Xác nhận vi phạm & Cảnh cáo chủ trọ" onclick="return confirm('Xác nhận CÓ VI PHẠM và đánh dấu là đã giải quyết?');"><i class="bi bi-shield-x"></i> Phạt</a>
                                            <a href="${pageContext.request.contextPath}/admin/reports/dismiss?id=${report.id}" class="btn btn-sm btn-secondary mb-1" title="Bỏ qua do không đủ bằng chứng" onclick="return confirm('Đánh dấu là KHÔNG VI PHẠM và bỏ qua?');"><i class="bi bi-x-circle"></i> Bỏ qua</a>
                                        </c:if>
                                        <c:if test="${report.status != 'PENDING'}">
                                            <i class="bi bi-check-all text-success fs-4" title="Đã xử lý"></i>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty reports}">
                                <tr><td colspan="7" class="text-center py-5 text-muted">Hệ thống an toàn, chưa có báo cáo vi phạm nào.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Script to handle tab selection based on URL hash -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        if(window.location.hash) {
            var tabId = window.location.hash.replace('#', '') + '-tab';
            var tabBtn = document.getElementById(tabId);
            if(tabBtn) {
                var tab = new bootstrap.Tab(tabBtn);
                tab.show();
            }
        }
    });
</script>

<jsp:include page="../layout/footer.jsp"/>
