<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>UTE Admin Panel</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body class="bg-light">
    <div class="row min-vh-100 m-0">
        <!-- Sidebar bên trái -->
        <div class="col-md-3 col-lg-2 bg-dark text-white p-3">
            <h4 class="text-white fw-bold mb-4"><i class="fa-solid fa-gauge-high me-2"></i>Admin</h4>
            <ul class="nav flex-column nav-pills">
                <li class="nav-item mb-2">
                    <a class="nav-link text-white bg-primary" href="<c:url value='/admin/categories'/>">
                        <i class="fa-solid fa-folder-open me-2"></i> Quản lý Category
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a class="nav-link text-white" href="<c:url value='/admin/profile'/>">
                        <i class="fa-solid fa-user-gear me-2"></i> Cập nhật Profile
                    </a>
                </li>
            </ul>
        </div>
        
        <!-- Nội dung bên phải -->
        <div class="col-md-9 col-lg-10 p-4">
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm rounded px-3 mb-4">
                <span class="navbar-brand mb-0 h5 fw-bold">Hệ Thống Quản Trị Trung Tâm</span>
                <div class="ms-auto">
                    <span class="text-secondary"><i class="fa-solid fa-user-shield me-1"></i> Xin chào, <b>admin</b></span>
                </div>
            </nav>
            
            <!-- Đổ nội dung trang profile/category vào đây -->
            <div class="container-fluid p-0">
                ${content}
            </div>
        </div>
    </div>
</body>
</html>