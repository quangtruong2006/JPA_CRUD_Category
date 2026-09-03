<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Sửa Category</title>
</head>
<body>
    <div class="card shadow-sm mt-4">
        <div class="card-header bg-warning text-dark">
            <h4 class="mb-0 fw-bold">Sửa Category</h4>
        </div>
        <div class="card-body">
            <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
                <!-- ID ẩn để update -->
                <input type="text" name="categoryid" value="${cate.categoryid}" hidden="hidden">
                
                <div class="mb-3">
                    <label for="categoryname" class="form-label fw-bold">Category name:</label>
                    <input type="text" class="form-control" id="categoryname" name="categoryname" value="${cate.categoryname}">
                </div>
                
                <div class="mb-3">
                    <label for="images" class="form-label fw-bold">Link images (URL):</label>
                    <input type="text" class="form-control" id="images" name="images" value="${cate.images}">
                </div>
                
                <div class="mb-3">
                    <c:if test="${not empty cate.images and cate.images.length() >= 5 and cate.images.substring(0,5)=='https'}">
                        <c:url value="${cate.images}" var="imgUrl"></c:url>
                    </c:if>
                    <c:if test="${empty cate.images or cate.images.length() < 5 or cate.images.substring(0,5)!='https'}">
                        <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                    </c:if>
                    <label class="form-label fw-bold d-block">Ảnh hiện tại:</label>
                    <img height="150" class="img-thumbnail mb-2" src="${imgUrl}" alt="Current Image" />
                </div>
                
                <div class="mb-3">
                    <label for="images1" class="form-label fw-bold">Upload images (File mới):</label>
                    <input type="file" class="form-control" id="images1" name="images1">
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold d-block">Status:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="ston" name="status" value="1" ${cate.status==1?'checked':''}>
                        <label class="form-check-label" for="ston">Hoạt động</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="stoff" name="status" value="0" ${cate.status!=1?'checked':''}>
                        <label class="form-check-label" for="stoff">Khóa</label>
                    </div>
                </div>
                
                <div class="mt-4">
                    <button type="submit" class="btn btn-warning fw-bold px-4">Update</button>
                    <!-- Nút quay lại danh sách -->
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary px-4 ms-2">Hủy / Quay lại</a>
                </div>
                
            </form>
        </div>
    </div>
</body>