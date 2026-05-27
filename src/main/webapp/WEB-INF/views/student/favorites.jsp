<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../layout/header.jsp"/>

<div class="row bg-white p-4 rounded shadow-sm">
    <div class="col-12 mb-4 d-flex justify-content-between align-items-center">
        <h3 class="fw-bold m-0"><i class="bi bi-heart-fill me-2 text-danger"></i>Phòng trọ yêu thích</h3>
    </div>

    <div class="col-12">
        <div class="row g-4">
            <c:forEach var="fav" items="${favorites}">
                <div class="col-md-3">
                    <div class="card h-100 shadow-sm border-0 room-card">
                        <img src="${pageContext.request.contextPath}/${fav.room.image}" class="card-img-top" alt="${fav.room.title}" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title fw-bold text-truncate" title="${fav.room.title}">${fav.room.title}</h5>
                            <p class="text-danger fw-bold mb-1 fs-5">
                                <fmt:formatNumber value="${fav.room.price}" type="currency" currencySymbol="VNĐ"/> / tháng
                            </p>
                            <p class="text-muted small mb-2"><i class="bi bi-geo-alt"></i> ${fav.room.address}</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <a href="${pageContext.request.contextPath}/room-detail?id=${fav.room.id}" class="btn btn-outline-primary btn-sm">Xem chi tiết</a>
                                <form action="${pageContext.request.contextPath}/favorite/toggle" method="post" class="d-inline">
                                    <input type="hidden" name="roomId" value="${fav.room.id}">
                                    <button type="submit" class="btn btn-sm btn-danger"><i class="bi bi-heart-fill"></i> Bỏ thích</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty favorites}">
                <div class="col-12 text-center py-5">
                    <h5 class="text-muted">Bạn chưa lưu phòng trọ nào.</h5>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-3">Khám phá ngay</a>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
