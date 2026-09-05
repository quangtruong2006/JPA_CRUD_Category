<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Sản Phẩm</title>
</head>
<body>
    <div style="display: flex; justify-content: space-between; align-items: center;">
        <h2>Quản lý Sản Phẩm</h2>
        <a href="${pageContext.request.contextPath}/admin/product/add" 
           style="background-color: #198754; color: white; padding: 10px; text-decoration: none; border-radius: 5px;">
           + Add Product
        </a>
    </div>

    <table border="1" style="width: 100%; text-align: center; border-collapse: collapse; margin-top: 20px;">
        <thead style="background-color: #343a40; color: white;">
            <tr>
                <th>STT</th>
                <th>Hình ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Danh mục</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <!-- Lặp danh sách listproduct từ Controller gửi sang -->
            <c:forEach items="${listproduct}" var="prod" varStatus="STT">
                <tr>
                    <td>${STT.index + 1}</td>
                    <td>
                        <!-- Hiển thị ảnh từ thư mục uploads -->
                        <img src="${pageContext.request.contextPath}/uploads/${prod.image}" width="100" alt="Lỗi ảnh">
                    </td>
                    <td>${prod.productName}</td>
                    <td>${prod.price} VNĐ</td>
                    <!-- Gọi prod.category.categoryname vì 2 bảng đã liên kết với nhau -->
                    <td>${prod.category.categoryname}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/product/edit?id=${prod.productId}" style="background-color: #ffc107; padding: 5px; text-decoration: none; color: black;">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/product/delete?id=${prod.productId}" 
   style="background-color: #dc3545; padding: 5px; text-decoration: none; color: white;" 
   onclick="return confirm('Ông có chắc chắn muốn xóa sản phẩm này không?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>