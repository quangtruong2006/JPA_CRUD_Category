<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết sản phẩm</title>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container py-5">
        <div class="card shadow-sm" style="border-radius: 15px; border: none;">
            <div class="row g-0">
                <!-- CỘT TRÁI: HÌNH ẢNH -->
                <div class="col-md-5 d-flex align-items-center justify-content-center p-4 bg-white" style="border-radius: 15px 0 0 15px;">
                    <img src="${pageContext.request.contextPath}/uploads/${p.image}" 
                         class="img-fluid rounded" 
                         alt="${p.productName}"
                         style="max-height: 400px; object-fit: contain;">
                </div>
                
                <!-- CỘT PHẢI: THÔNG TIN -->
                <div class="col-md-7">
                    <div class="card-body p-5">
                        <span class="badge bg-primary mb-2">${p.category.categoryname}</span>
                        <h2 class="card-title fw-bold text-dark mb-3">${p.productName}</h2>
                        
                        <h3 class="text-danger fw-bold mb-4">${p.price} VNĐ</h3>
                        
                        <h5 class="fw-semibold">Mô tả sản phẩm:</h5>
                        <p class="card-text text-muted" style="line-height: 1.8;">
                            <!-- Nếu không có mô tả thì hiện chữ "Đang cập nhật" -->
                            ${empty p.description ? 'Thông tin mô tả đang được cập nhật...' : p.description}
                        </p>

                        <hr class="my-4">
                        
                        <div class="d-flex gap-3 mt-4">
                            <button class="btn btn-primary btn-lg fw-bold px-5">
                                <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                            </button>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-lg fw-bold px-4">
                                Quay lại
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>