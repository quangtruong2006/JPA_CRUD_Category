<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<head>
    <title>Danh sách Category</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-3 mt-4">
        <h3 class="text-primary fw-bold">Quản lý Category</h3>
        <a href="<c:url value='/admin/category/add'/>" class="btn btn-success fw-bold">
            + Add Category
        </a>
    </div>
    
    <div class="card shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle text-center mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 5%">STT</th>
                            <th style="width: 25%">Images</th>
                            <th>Category name</th>
                            <th style="width: 15%">Status</th>
                            <th style="width: 20%">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listcate}" var="cate" varStatus="STT">
                            <tr>
                                <td>${STT.index+1}</td>
                                
                                <c:if test="${not empty cate.images and cate.images.length() >= 5 and cate.images.substring(0,5)=='https'}">
                                    <c:url value="${cate.images}" var="imgUrl"></c:url>
                                </c:if>
                                <c:if test="${empty cate.images or cate.images.length() < 5 or cate.images.substring(0,5)!='https'}">
                                    <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                                </c:if>
                                
                                <td>
                                    <img height="100" class="img-thumbnail" src="${imgUrl}" alt="${cate.categoryname}" />
                                </td>
                                
                                <td class="fw-bold">${cate.categoryname}</td>
                                
                                <td>
                                    <c:if test="${cate.status==1}"><span class="badge bg-success px-3 py-2">Hoạt động</span></c:if>
                                    <c:if test="${cate.status!=1}"><span class="badge bg-secondary px-3 py-2">Khóa</span></c:if>
                                </td>
                                
                                <td>
                                    <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn btn-sm btn-warning text-dark fw-bold px-3">Sửa</a>
                                    <!-- Thêm popup confirm để tránh bấm nhầm -->
                                    <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" class="btn btn-sm btn-danger fw-bold px-3 ms-1" onclick="return confirm('Ông có chắc chắn muốn xóa category này không?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>