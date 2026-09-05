<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cập nhật Sản Phẩm</title>
</head>
<body>
    <h2>CẬP NHẬT SẢN PHẨM</h2>

    <!-- FORM SỬA: Vẫn phải có enctype="multipart/form-data" -->
    <form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data">
        
        <!-- QUAN TRỌNG: Giấu ID sản phẩm ở đây để gửi lên Controller -->
        <input type="hidden" name="productId" value="${product.productId}">

        <label>Tên sản phẩm:</label><br>
        <input type="text" name="productName" value="${product.productName}" required="required" style="width: 300px;"><br><br>

        <label>Giá (VNĐ):</label><br>
        <input type="number" name="price" value="${product.price}" required="required" style="width: 300px;"><br><br>

        <label>Chọn Danh mục:</label><br>
        <select name="categoryId" style="width: 300px; padding: 5px;">
            <c:forEach items="${listcate}" var="cate">
                <!-- Dùng c:if để tự động chọn đúng cái danh mục cũ của sản phẩm -->
                <option value="${cate.categoryId}" 
                    <c:if test="${cate.categoryId == product.category.categoryId}">selected</c:if> >
                    ${cate.categoryname}
                </option>
            </c:forEach>
        </select><br><br>

        <label>Hình ảnh hiện tại:</label><br>
        <img src="${pageContext.request.contextPath}/uploads/${product.image}" width="150" style="border: 1px solid #ccc; margin-bottom: 10px;"><br>
        
        <label>Chọn ảnh mới (Bỏ trống nếu muốn giữ ảnh cũ):</label><br>
        <!-- KHÔNG có required ở đây -->
        <input type="file" name="imageFile" accept="image/*"><br><br>

        <label>Mô tả sản phẩm:</label><br>
        <!-- Textarea không dùng value, mà kẹp giá trị ở giữa 2 thẻ -->
        <textarea name="description" rows="4" cols="40">${product.description}</textarea><br><br>

        <button type="submit" style="background-color: #ffc107; padding: 5px 15px; cursor: pointer; border: none; font-weight: bold;">Cập Nhật Sản Phẩm</button>
        <a href="${pageContext.request.contextPath}/admin/product/list" style="padding: 5px 15px; text-decoration: none; background-color: #6c757d; color: white;">Quay Lại</a>
    </form>
    
</body>
</html>