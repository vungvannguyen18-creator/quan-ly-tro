<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Tìm Trọ Nhanh - Nền tảng tìm kiếm và cho thuê phòng trọ uy tín, nhanh chóng và tiện lợi nhất tại Cần Thơ dành cho sinh viên và người đi làm.">
    <meta name="keywords" content="phòng trọ, tìm phòng trọ, thuê phòng, nhà trọ sinh viên, Cần Thơ, phòng trọ Cần Thơ, nhà trọ giá rẻ">
    <meta name="author" content="Trần Vĩnh Kiết">
    <meta name="robots" content="index, follow">
    
    <!-- Open Graph for Social Media -->
    <meta property="og:title" content="Tìm Trọ Nhanh - Hệ thống Quản lý Phòng Trọ">
    <meta property="og:description" content="Nền tảng tìm kiếm và cho thuê phòng trọ uy tín, nhanh chóng tại Cần Thơ.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://timtronhanh.com">
    <meta property="og:site_name" content="Tìm Trọ Nhanh">
    
    <title>${not empty pageTitle ? pageTitle.concat(' - Tìm Trọ Nhanh') : 'Hệ thống Quản lý Phòng Trọ - Tìm Trọ Nhanh'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }
        .navbar-custom {
            background-color: #ffffff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .navbar-brand {
            font-weight: 700;
            color: #ff6a00 !important;
        }
        .nav-link {
            font-weight: 500;
            color: #333;
        }
        .nav-link:hover {
            color: #ff6a00;
        }
        .btn-primary-custom {
            background-color: #ff6a00;
            border-color: #ff6a00;
            color: white;
            font-weight: 600;
            border-radius: 8px;
        }
        .btn-primary-custom:hover {
            background-color: #e65c00;
            border-color: #e65c00;
            color: white;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home"><i class="bi bi-house-heart-fill me-2"></i>TìmTrọ Nhanh</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                </li>
                <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'LANDLORD'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/landlord/rooms">Quản lý phòng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/landlord/bookings">Yêu cầu thuê phòng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-primary fw-bold" href="${pageContext.request.contextPath}/chat"><i class="bi bi-chat-dots-fill"></i> Tin nhắn</a>
                    </li>
                </c:if>
                <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'STUDENT'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/booking/history">Lịch sử đặt phòng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-danger fw-bold" href="${pageContext.request.contextPath}/favorites"><i class="bi bi-heart-fill"></i> Đã lưu</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-primary fw-bold" href="${pageContext.request.contextPath}/chat"><i class="bi bi-chat-dots-fill"></i> Tin nhắn</a>
                    </li>
                </c:if>
                <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'ADMIN'}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle fw-bold text-danger" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-shield-lock-fill"></i> Quản lý hệ thống
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/students">Quản lý sinh viên</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/landlords">Quản lý chủ trọ</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/rooms">Quản lý phòng</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/bookings">Quản lý yêu cầu thuê</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/payments">Quản lý giao dịch</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/revenue">Thống kê doanh thu</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/reviews">Quản lý đánh giá</a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i> ${sessionScope.user.fullName}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Hồ sơ cá nhân</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                        </li>
                        <li class="nav-item ms-2">
                            <a class="btn btn-primary-custom" href="${pageContext.request.contextPath}/register">Đăng ký</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
<div class="container mt-4 mb-5">
