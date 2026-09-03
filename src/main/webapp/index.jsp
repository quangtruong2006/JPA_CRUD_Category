<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Trang chủ Quản trị</title>
</head>
<body>
    <div class="container mt-5">
        <div class="p-5 text-center bg-light rounded-3 shadow border">
            <!-- Thêm cái logo trường cho ngầu và đúng tinh thần báo cáo bài tập -->
            <img src="https://upload.wikimedia.org/wikipedia/commons/b/bf/Logo_HCMUTE.png" alt="Logo" width="120" class="mb-4">
            
            <h1 class="text-primary fw-bold">Hệ Thống Quản Trị Trung Tâm</h1>
            <p class="lead text-muted mt-3">
                Chào mừng bạn đến với trang quản trị hệ thống. 
                Vui lòng chọn chức năng bên dưới hoặc trên thanh menu để bắt đầu làm việc.
            </p>
            
            <hr class="my-4">
            
            <div class="d-flex justify-content-center gap-3 mt-4">
                <a href="<c:url value='/admin/categories'/>" class="btn btn-primary btn-lg px-4 fw-bold shadow-sm">
                    📁 Quản lý Category
                </a>
                <a href="<c:url value='/admin/profile'/>" class="btn btn-outline-info btn-lg px-4 fw-bold shadow-sm">
                    👤 Cập nhật Profile
                </a>
            </div>
        </div>
    </div>
</body>