<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Quản lý phòng trọ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
        }
        .card-auth {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 2.5rem;
            width: 100%;
            max-width: 500px;
        }
        .form-control {
            border-radius: 10px;
            padding: 10px 15px;
        }
        .btn-primary {
            border-radius: 10px;
            padding: 12px;
            background-color: #8e44ad;
            border: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-primary:hover {
            background-color: #732d91;
            transform: translateY(-2px);
        }
        .auth-title {
            font-weight: 700;
            color: #333;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

<div class="card-auth">
    <h3 class="text-center auth-title">Tạo Tài Khoản</h3>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="mb-3">
            <label class="form-label">Họ và tên</label>
            <input type="text" class="form-control" name="fullName" required placeholder="Nhập họ và tên">
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" required placeholder="Nhập địa chỉ email">
        </div>
        <div class="mb-3">
            <label class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" name="phone" required placeholder="Nhập số điện thoại">
        </div>
        <div class="mb-3">
            <label class="form-label">Mật khẩu</label>
            <input type="password" class="form-control" name="password" required placeholder="Nhập mật khẩu">
        </div>
        <div class="mb-4">
            <label class="form-label">Xác nhận mật khẩu</label>
            <input type="password" class="form-control" name="confirmPassword" required placeholder="Nhập lại mật khẩu">
        </div>
        
        <button type="submit" class="btn btn-primary w-100">Đăng ký ngay</button>
    </form>
    
    <div class="text-center mt-4">
        <span>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-decoration-none" style="color: #8e44ad; font-weight: 600;">Đăng nhập</a></span>
    </div>
</div>

</body>
</html>
