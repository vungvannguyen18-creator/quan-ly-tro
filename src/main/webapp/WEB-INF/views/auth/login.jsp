<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Quản lý phòng trọ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card-auth {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            padding: 2rem;
            width: 100%;
            max-width: 450px;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
        }
        .btn-primary {
            border-radius: 10px;
            padding: 12px;
            background-color: #ff6a00;
            border: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-primary:hover {
            background-color: #e65c00;
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
    <h3 class="text-center auth-title">Đăng nhập</h3>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-success">${sessionScope.message}</div>
        <c:remove var="message" scope="session"/>
    </c:if>

    <form action="login" method="post">
        <div class="mb-3">
            <label class="form-label">Email hoặc Tên đăng nhập</label>
            <input type="text" class="form-control" name="email" value="${cookie.userEmail.value}" required placeholder="Nhập email hoặc tên đăng nhập">
        </div>
        <div class="mb-3">
            <label class="form-label">Mật khẩu</label>
            <div class="input-group">
                <input type="password" class="form-control" name="password" id="passwordField" value="${cookie.userPassword.value}" required placeholder="Nhập mật khẩu" style="border-right: none;">
                <button class="btn btn-outline-secondary bg-white" type="button" id="togglePassword" style="border-left: none; border-color: #dee2e6;">
                    <i class="bi bi-eye" id="toggleIcon"></i>
                </button>
            </div>
        </div>
        <div class="d-flex justify-content-between mb-4">
            <div class="form-check">
                <input type="checkbox" class="form-check-input" name="remember" id="remember" ${not empty cookie.userEmail ? 'checked' : ''}>
                <label class="form-check-label" for="remember">Nhớ mật khẩu</label>
            </div>
            <a href="forgot-password" class="text-decoration-none" style="color: #ff6a00;">Quên mật khẩu?</a>
        </div>
        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
    </form>
    
    <script>
        document.getElementById('togglePassword').addEventListener('click', function (e) {
            const passwordInput = document.getElementById('passwordField');
            const toggleIcon = document.getElementById('toggleIcon');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('bi-eye');
                toggleIcon.classList.add('bi-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('bi-eye-slash');
                toggleIcon.classList.add('bi-eye');
            }
        });
    </script>
    
    <div class="text-center mt-4">
        <span>Chưa có tài khoản? <a href="register" class="text-decoration-none" style="color: #ff6a00; font-weight: 600;">Đăng ký ngay</a></span>
    </div>
</div>

</body>
</html>
