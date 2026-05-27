<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card-auth {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            background: rgba(255, 255, 255, 0.95);
            padding: 2.5rem;
            width: 100%;
            max-width: 450px;
        }
        .btn-primary {
            background-color: #667eea;
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
        }
        .btn-primary:hover {
            background-color: #5a6cd6;
        }
        .form-control {
            padding: 12px;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<div class="card-auth">
    <h3 class="text-center mb-4" style="font-weight: 700;">Đặt lại mật khẩu</h3>
    <p class="text-center text-muted mb-4">Vui lòng nhập mật khẩu mới cho tài khoản của bạn.</p>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <div class="mb-3">
            <label class="form-label">Mật khẩu mới</label>
            <input type="password" class="form-control" name="newPassword" required placeholder="Nhập mật khẩu mới">
        </div>
        <div class="mb-4">
            <label class="form-label">Xác nhận mật khẩu</label>
            <input type="password" class="form-control" name="confirmPassword" required placeholder="Nhập lại mật khẩu mới">
        </div>
        <button type="submit" class="btn btn-primary w-100">Đổi mật khẩu</button>
    </form>
</div>

</body>
</html>
