<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Cập nhật Sản Phẩm</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        body {
            background: #f8fafc;
        }

        .card {
            border-radius: 15px;
        }

        .card-header {
            border-radius: 15px 15px 0 0 !important;
        }

        .form-control,
        .form-select {
            border-radius: 8px;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #ffc107;
            box-shadow: 0 0 0 0.2rem rgba(255, 193, 7, 0.15);
        }

        .invalid-feedback {
            font-size: 13px;
        }

        .image-hint {
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
        }

        .current-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }

        .char-counter {
            font-size: 12px;
            color: #6c757d;
            text-align: right;
            margin-top: 4px;
        }

    </style>

</head>

<body>

<div class="container mt-4 mb-5">

    <div class="card shadow-sm border-0"
         style="max-width: 650px; margin: 0 auto;">

        <!-- HEADER -->
        <div class="card-header bg-warning text-dark py-3">

            <h5 class="mb-0 fw-bold text-center">

                <i class="bi bi-pencil-square me-2"></i>

                CẬP NHẬT SẢN PHẨM

            </h5>

        </div>


        <div class="card-body p-4">


            <!-- THÔNG BÁO THÀNH CÔNG -->
            <c:if test="${not empty message}">

                <div class="alert alert-success py-2">

                    <i class="bi bi-check-circle-fill me-2"></i>

                    ${message}

                </div>

            </c:if>


            <!-- THÔNG BÁO LỖI -->
            <c:if test="${not empty error}">

                <div class="alert alert-danger py-2">

                    <i class="bi bi-exclamation-triangle-fill me-2"></i>

                    ${error}

                </div>

            </c:if>


            <!-- FORM -->

            <form action="${pageContext.request.contextPath}/admin/product/edit"
                  method="post"
                  enctype="multipart/form-data"
                  class="needs-validation"
                  novalidate>


                <!-- PRODUCT ID -->

                <input type="hidden"
                       name="productId"
                       value="${product.productId}">


                <!-- ========================= -->
                <!-- TÊN SẢN PHẨM -->
                <!-- ========================= -->

                <div class="mb-3">

                    <label class="form-label fw-bold">

                        Tên sản phẩm

                        <span class="text-danger">*</span>

                    </label>


                    <input type="text"
                           name="productName"
                           id="productName"
                           value="${product.productName}"
                           class="form-control"
                           required
                           minlength="2"
                           maxlength="100"
                           placeholder="Nhập tên sản phẩm..."
                           autocomplete="off">


                    <div class="invalid-feedback">

                        Tên sản phẩm phải từ 2 đến 100 ký tự
                        và không được để trống.

                    </div>

                </div>


                <!-- ========================= -->
                <!-- GIÁ -->
                <!-- ========================= -->

                <div class="mb-3">

                    <label class="form-label fw-bold">

                        Giá (VNĐ)

                        <span class="text-danger">*</span>

                    </label>


                    <input type="number"
                           name="price"
                           id="price"
                           value="${product.price}"
                           class="form-control"
                           required
                           min="0"
                           step="1"
                           inputmode="numeric"
                           placeholder="Ví dụ: 150000">


                    <div class="invalid-feedback">

                        Giá sản phẩm phải là số nguyên
                        từ 0 trở lên.

                    </div>

                </div>


                <!-- ========================= -->
                <!-- DANH MỤC -->
                <!-- ========================= -->

                <div class="mb-3">

                    <label class="form-label fw-bold">

                        Chọn Danh mục

                        <span class="text-danger">*</span>

                    </label>


                    <select name="categoryId"
                            id="categoryId"
                            class="form-select"
                            required>

                        <option value=""
                                disabled>

                            -- Chọn danh mục sản phẩm --

                        </option>


                        <c:forEach items="${listcate}"
                                   var="cate">

                            <option value="${cate.categoryId}"
                                <c:if test="${cate.categoryId == product.category.categoryId}">
                                    selected
                                </c:if>
                            >

                                ${cate.categoryname}

                            </option>

                        </c:forEach>

                    </select>


                    <div class="invalid-feedback">

                        Vui lòng chọn một danh mục sản phẩm.

                    </div>

                </div>


                <!-- ========================= -->
                <!-- HÌNH ẢNH -->
                <!-- ========================= -->

                <div class="mb-3">

                    <label class="form-label fw-bold">

                        Hình ảnh sản phẩm

                    </label>


                    <div class="d-flex align-items-center gap-3 mb-2">


                        <!-- ẢNH HIỆN TẠI -->

                        <c:if test="${not empty product.image}">

                            <div class="text-center">

                                <img src="${pageContext.request.contextPath}/uploads/${product.image}"
                                     class="img-thumbnail current-image"
                                     alt="Ảnh sản phẩm hiện tại">

                                <small class="text-muted d-block mt-1">

                                    Ảnh hiện tại

                                </small>

                            </div>

                        </c:if>


                        <!-- CHỌN ẢNH MỚI -->

                        <div class="flex-grow-1">

                            <span class="text-muted small d-block mb-1">

                                Chọn ảnh mới
                                (bỏ trống nếu muốn giữ ảnh cũ)

                            </span>


                            <input type="file"
                                   name="imageFile"
                                   id="imageFile"
                                   class="form-control"
                                   accept=".jpg,.jpeg,.png,.webp,image/jpeg,image/png,image/webp">


                            <div class="invalid-feedback"
                                 id="imageError">

                                Ảnh phải là JPG, JPEG, PNG hoặc WEBP
                                và không quá 5MB.

                            </div>


                            <div class="image-hint">

                                <i class="bi bi-info-circle me-1"></i>

                                Chỉ hỗ trợ JPG, JPEG, PNG, WEBP.
                                Dung lượng tối đa 5MB.

                            </div>

                        </div>

                    </div>

                </div>


                <!-- ========================= -->
                <!-- MÔ TẢ -->
                <!-- ========================= -->

                <div class="mb-4">

                    <label class="form-label fw-bold">

                        Mô tả sản phẩm

                    </label>


                    <textarea name="description"
                              id="description"
                              class="form-control"
                              rows="4"
                              maxlength="1000"
                              placeholder="Nhập mô tả chi tiết sản phẩm...">${product.description}</textarea>


                    <div class="char-counter">

                        <span id="charCount">0</span>/1000 ký tự

                    </div>


                    <div class="invalid-feedback">

                        Mô tả không được vượt quá 1000 ký tự.

                    </div>

                </div>


                <!-- ========================= -->
                <!-- BUTTON -->
                <!-- ========================= -->

                <div class="d-flex gap-3">

                    <button type="submit"
                            class="btn btn-warning fw-bold px-4 py-2 w-50 shadow-sm text-dark">

                        <i class="bi bi-cloud-check-fill me-1"></i>

                        Cập Nhật Sản Phẩm

                    </button>


                    <a href="${pageContext.request.contextPath}/admin/product/list"
                       class="btn btn-secondary fw-bold px-4 py-2 w-50 shadow-sm text-decoration-none">

                        <i class="bi bi-arrow-left me-1"></i>

                        Quay Lại

                    </a>

                </div>


            </form>

        </div>

    </div>

</div>


<!-- ========================= -->
<!-- JAVASCRIPT VALIDATION -->
<!-- ========================= -->

<script>

(function () {

    'use strict';


    const form =
        document.querySelector('.needs-validation');


    if (!form) {
        return;
    }


    /* =========================
       SUBMIT FORM
       ========================= */

    form.addEventListener('submit', function (event) {

        const imageValid =
            validateImage();


        if (!imageValid) {

            event.preventDefault();
            event.stopPropagation();

        }


        if (!form.checkValidity()) {

            event.preventDefault();
            event.stopPropagation();


            const firstInvalid =
                form.querySelector(':invalid');


            if (firstInvalid) {

                firstInvalid.focus();

            }

        }


        form.classList.add('was-validated');

    });


    /* =========================
       TÊN SẢN PHẨM
       ========================= */

    const productName =
        document.getElementById('productName');


    if (productName) {

        productName.addEventListener('input', function () {

            /*
             * Không cho bắt đầu bằng khoảng trắng
             */

            this.value =
                this.value.replace(/^\s+/, '');

        });


        productName.addEventListener('blur', function () {

            /*
             * Xóa khoảng trắng đầu/cuối
             */

            this.value =
                this.value.trim();


            /*
             * Không cho nhiều khoảng trắng liên tiếp
             */

            this.value =
                this.value.replace(/\s+/g, ' ');

        });

    }


    /* =========================
       GIÁ
       ========================= */

    const price =
        document.getElementById('price');


    if (price) {

        price.addEventListener('input', function () {

            /*
             * Không cho giá âm
             */

            if (this.value < 0) {

                this.value = 0;

            }


            /*
             * Không cho nhập số thập phân
             */

            if (this.value.includes('.')) {

                this.value =
                    this.value.split('.')[0];

            }

        });

    }


    /* =========================
       HÌNH ẢNH
       ========================= */

    const imageFile =
        document.getElementById('imageFile');


    function validateImage() {

        /*
         * Không chọn ảnh mới
         * => Hợp lệ vì có thể giữ ảnh cũ
         */

        if (!imageFile ||
            imageFile.files.length === 0) {

            if (imageFile) {

                imageFile.setCustomValidity('');

            }

            return true;

        }


        const file =
            imageFile.files[0];


        const allowedTypes = [

            'image/jpeg',
            'image/png',
            'image/webp'

        ];


        /*
         * Kiểm tra định dạng
         */

        if (!allowedTypes.includes(file.type)) {

            imageFile.setCustomValidity(
                'Chỉ hỗ trợ JPG, JPEG hoặc WEBP.'
            );

            return false;

        }


        /*
         * Kiểm tra dung lượng
         */

        const maxSize =
            5 * 1024 * 1024;


        if (file.size > maxSize) {

            imageFile.setCustomValidity(
                'Dung lượng ảnh không được vượt quá 5MB.'
            );

            return false;

        }


        imageFile.setCustomValidity('');

        return true;

    }


    if (imageFile) {

        imageFile.addEventListener('change', function () {

            validateImage();

        });

    }


    /* =========================
       MÔ TẢ + ĐẾM KÝ TỰ
       ========================= */

    const description =
        document.getElementById('description');


    const charCount =
        document.getElementById('charCount');


    if (description && charCount) {


        /*
         * Hiển thị số ký tự ban đầu
         */

        charCount.textContent =
            description.value.length;


        description.addEventListener('input', function () {

            charCount.textContent =
                this.value.length;

        });

    }

})();

</script>


</body>

</html>