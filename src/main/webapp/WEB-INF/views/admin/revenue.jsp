<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="../layout/header.jsp"/>

<div class="row bg-white p-4 rounded shadow-sm">
    <div class="col-12 mb-4">
        <h3 class="fw-bold m-0"><i class="bi bi-graph-up-arrow me-2 text-success"></i>Báo cáo Doanh thu & Giao dịch</h3>
    </div>

<div class="row mb-4">
    <div class="col-md-3">
        <div class="card bg-white shadow-sm border-0 border-bottom border-5 border-primary">
            <div class="card-body">
                <p class="text-muted fw-bold mb-1"><i class="bi bi-calendar-day"></i> Doanh thu Hôm nay</p>
                <h3 class="fw-bold mb-0 text-primary"><fmt:formatNumber value="${todayRevenue}" type="currency" currencySymbol=""/></h3>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-white shadow-sm border-0 border-bottom border-5 border-success">
            <div class="card-body">
                <p class="text-muted fw-bold mb-1"><i class="bi bi-calendar-month"></i> Doanh thu Tháng này</p>
                <h3 class="fw-bold mb-0 text-success"><fmt:formatNumber value="${monthRevenue}" type="currency" currencySymbol=""/></h3>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-white shadow-sm border-0 border-bottom border-5 border-warning">
            <div class="card-body">
                <p class="text-muted fw-bold mb-1"><i class="bi bi-calendar-check"></i> Doanh thu Năm nay</p>
                <h3 class="fw-bold mb-0 text-warning"><fmt:formatNumber value="${yearRevenue}" type="currency" currencySymbol=""/></h3>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-white shadow-sm border-0 border-bottom border-5 border-danger">
            <div class="card-body">
                <p class="text-muted fw-bold mb-1"><i class="bi bi-cash-stack"></i> Tổng Doanh thu</p>
                <h3 class="fw-bold mb-0 text-danger"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol=""/></h3>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0 fw-bold"><i class="bi bi-bar-chart-line-fill text-primary"></i> Biểu đồ doanh thu 7 ngày qua</h5>
            </div>
            <div class="card-body">
                <!-- Mock Chart Area -->
                <div class="d-flex align-items-end justify-content-between h-100 px-3 pb-3 pt-5" style="min-height: 300px; background: repeating-linear-gradient(0deg, transparent, transparent 49px, #f8f9fa 49px, #f8f9fa 50px);">
                    <div class="text-center" style="width: 10%;">
                        <div class="bg-primary rounded-top" style="height: 40%; transition: 1s;"></div>
                        <small class="text-muted mt-2 d-block">T2</small>
                    </div>
                    <div class="text-center" style="width: 10%;">
                        <div class="bg-primary rounded-top" style="height: 60%; transition: 1s;"></div>
                        <small class="text-muted mt-2 d-block">T3</small>
                    </div>
                    <div class="text-center" style="width: 10%;">
                        <div class="bg-primary rounded-top" style="height: 30%; transition: 1s;"></div>
                        <small class="text-muted mt-2 d-block">T4</small>
                    </div>
                    <div class="text-center" style="width: 10%;">
                        <div class="bg-primary rounded-top" style="height: 80%; transition: 1s;"></div>
                        <small class="text-muted mt-2 d-block">T5</small>
                    </div>
                    <div class="text-center" style="width: 10%;">
                        <div class="bg-primary rounded-top" style="height: 50%; transition: 1s;"></div>
                        <small class="text-muted mt-2 d-block">T6</small>
                    </div>
                    <div class="text-center" style="width: 10%;">
                        <div class="bg-primary rounded-top" style="height: 90%; transition: 1s;"></div>
                        <small class="text-muted mt-2 d-block">T7</small>
                    </div>
                    <div class="text-center" style="width: 10%;">
                        <div class="bg-primary rounded-top" style="height: 100%; background-color: #ff6a00 !important; transition: 1s;"></div>
                        <small class="text-danger fw-bold mt-2 d-block">CN</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0 fw-bold"><i class="bi bi-pie-chart-fill text-success"></i> Tỷ lệ giao dịch</h5>
            </div>
            <div class="card-body text-center py-5">
                <div class="position-relative d-inline-block mb-4" style="width: 200px; height: 200px; border-radius: 50%; background: conic-gradient(#198754 0% 85%, #dc3545 85% 100%);">
                    <div class="position-absolute top-50 start-50 translate-middle bg-white rounded-circle d-flex align-items-center justify-content-center" style="width: 140px; height: 140px;">
                        <div>
                            <h4 class="fw-bold mb-0 text-success">85%</h4>
                            <small class="text-muted">Thành công</small>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-center gap-4">
                    <div><span class="d-inline-block bg-success rounded-circle me-1" style="width: 10px; height: 10px;"></span> Thành công</div>
                    <div><span class="d-inline-block bg-danger rounded-circle me-1" style="width: 10px; height: 10px;"></span> Thất bại</div>
                </div>
                <div class="mt-4 pt-3 border-top">
                    <h6 class="fw-bold text-muted">Tổng số giao dịch thành công:</h6>
                    <h3 class="fw-bold text-dark">${totalPaidTransactions} <small class="fs-6 text-muted">GD</small></h3>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
