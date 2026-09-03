<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Thêm Category</title>
</head>
<body>
    <div class="card shadow-sm mt-4">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Thêm Category Mới</h4>
        </div>
        <div class="card-body">
            <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
                
                <div class="mb-3">
                    <label for="categoryname" class="form-label fw-bold">Category name:</label>
                    <input type="text" class="form-control" id="categoryname" name="categoryname" placeholder="Nhập tên danh mục...">
                </div>
                
                <div class="mb-3">
                    <label for="images" class="form-label fw-bold">Link images (URL):</label>
                    <input type="text" class="form-control" id="images" name="images" placeholder="Nhập link ảnh (nếu có)">
                </div>
                
                <div class="mb-3">
                    <label for="images1" class="form-label fw-bold">Upload images (File):</label>
                    <input type="file" class="form-control" id="images1" name="images1">
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold d-block">Status:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="ston" name="status" value="1" checked>
                        <label class="form-check-label" for="ston">Hoạt động</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="stoff" name="status" value="0">
                        <label class="form-check-label" for="stoff">Khóa</label>
                    </div>
                </div>
                
                <div class="mt-4">
                    <button type="submit" class="btn btn-success px-4">Insert</button>
                    <!-- Nút quay lại danh sách -->
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary px-4 ms-2">Hủy / Quay lại</a>
                </div>
                
            </form>
        </div>
    </div>
</body>