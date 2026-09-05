<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xác thực tài khoản OTP</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5" style="max-width: 450px;">
        <div class="card shadow p-4">
            <h3 class="text-center mb-3 text-primary">Xác Thực OTP</h3>
            <p class="text-muted text-center small">Mã xác thực đã được gửi vào email của bạn. Vui lòng kiểm tra hộp thư (cả mục Spam nếu cần).</p>
            
            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty alert}">
                <div class="alert alert-danger">${alert}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/verify" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold">Nhập mã OTP (6 chữ số):</label>
                    <input type="text" name="code" class="form-control text-center fs-4 tracking-widest" required maxlength="6" placeholder="------">
                </div>
                <button type="submit" class="btn btn-primary w-100 fw-bold">Xác Nhận Kích Hoạt</button>
            </form>
        </div>
    </div>
</body>
</html>