<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Khai báo JSTL để dùng vòng lặp -->
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm Sản Phẩm Mới</title>
</head>
<body>
    <h2>THÊM SẢN PHẨM MỚI</h2>

    <!-- Hiển thị thông báo thành công hoặc lỗi từ Controller gửi sang -->
    <h3 style="color: green;">${message}</h3>
    <h3 style="color: red;">${error}</h3>

    <!-- FORM UPLOAD: Bắt buộc phải có enctype="multipart/form-data" -->
    <form action="${pageContext.request.contextPath}/admin/product/add" method="post" enctype="multipart/form-data">
        
        <label>Tên sản phẩm:</label><br>
        <input type="text" name="productName" required="required" style="width: 300px;"><br><br>

        <label>Giá (VNĐ):</label><br>
        <input type="number" name="price" required="required" style="width: 300px;"><br><br>

        <label>Chọn Danh mục:</label><br>
        <select name="categoryId" style="width: 300px; padding: 5px;">
            <!-- Dùng JSTL duyệt danh sách category do Controller gửi qua -->
            <c:forEach items="${listcate}" var="cate">
                <option value="${cate.categoryId}">${cate.categoryname}</option>
            </c:forEach>
        </select><br><br>

        <label>Hình ảnh (Upload):</label><br>
        <!-- Tên input là imageFile khớp chính xác với code getPart("imageFile") trong Controller -->
        <input type="file" name="imageFile" accept="image/*" required="required"><br><br>

        <label>Mô tả sản phẩm:</label><br>
        <textarea name="description" rows="4" cols="40"></textarea><br><br>

        <button type="submit" style="padding: 5px 15px; cursor: pointer;">Lưu Sản Phẩm</button>
        <button type="reset" style="padding: 5px 15px; cursor: pointer;">Làm Mới</button>
    </form>
    
</body>
</html>