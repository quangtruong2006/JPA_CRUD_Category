<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card shadow-sm border-0">
    <div class="card-header bg-info text-white py-3">
        <h4 class="mb-0 fw-bold">Cập nhật thông tin cá nhân</h4>
    </div>
    <div class="card-body p-4">
        <form action="<c:url value='/admin/profile/update'/>" method="post" enctype="multipart/form-data">
            
            <!-- ID ẩn để update -->
            <input type="hidden" name="userid" value="${user.userid}">
            
            <div class="mb-3">
                <label class="form-label fw-bold">Username:</label>
                <input type="text" class="form-control bg-light" value="${user.username}" readonly="readonly">
                <div class="form-text">Tài khoản đăng nhập không thể thay đổi.</div>
            </div>
            
            <div class="mb-3">
                <label for="fullname" class="form-label fw-bold">Fullname:</label>
                <input type="text" class="form-control" id="fullname" name="fullname" value="${user.fullname}">
            </div>
            
            <div class="mb-3">
                <label for="phone" class="form-label fw-bold">Phone:</label>
                <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}">
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold d-block">Ảnh đại diện (Avatar):</label>
                <c:if test="${not empty user.images}">
                    <img src="<c:url value='/image?fname=${user.images}'/>" class="img-thumbnail mb-2" style="width: 150px; height: 150px; object-fit: cover;" alt="Avatar"/><br>
                </c:if>
                <input type="file" class="form-control" name="images1">
            </div>
            
            <div class="mt-4">
                <button type="submit" class="btn btn-info text-white fw-bold px-4">Update Profile</button>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary px-4 ms-2">Quay lại</a>
            </div>
            
        </form>
    </div>
</div>