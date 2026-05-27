<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
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
    </style>
</head>
<body>

<div class="card-auth">
    <h3 class="text-center mb-4" style="font-weight: 700;">Quên mật khẩu</h3>
    <p class="text-center text-muted mb-4">Nhập email đã đăng ký của bạn để nhận mã OTP khôi phục mật khẩu.</p>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="mb-4">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" required placeholder="Nhập email của bạn" style="padding: 12px; border-radius: 10px;">
        </div>
        <button type="submit" class="btn btn-primary w-100">Nhận mã OTP</button>
    </form>
    
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none" style="color: #667eea; font-weight: 600;">Quay lại Đăng nhập</a>
    </div>
</div>

</body>
</html>
