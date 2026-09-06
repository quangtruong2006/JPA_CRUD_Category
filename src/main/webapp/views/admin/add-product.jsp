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

    <title>Thêm Sản Phẩm Mới</title>


    <!-- Bootstrap 5 CSS -->
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
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.15);
        }

        .invalid-feedback {
            font-size: 13px;
        }

        .image-hint {
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
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


        <!-- =============================== -->
        <!-- HEADER -->
        <!-- =============================== -->

        <div class="card-header bg-primary text-white py-3">

            <h5 class="mb-0 fw-bold text-center">

                <i class="bi bi-box-seam me-2"></i>

                THÊM SẢN PHẨM MỚI

            </h5>

        </div>


        <!-- =============================== -->
        <!-- BODY -->
        <!-- =============================== -->

        <div class="card-body p-4">


            <!-- =============================== -->
            <!-- SERVER MESSAGE -->
            <!-- =============================== -->

            <c:if test="${not empty message}">

                <div class="alert alert-success py-2">

                    <i class="bi bi-check-circle-fill me-2"></i>

                    ${message}

                </div>

            </c:if>


            <c:if test="${not empty error}">

                <div class="alert alert-danger py-2">

                    <i class="bi bi-exclamation-triangle-fill me-2"></i>

                    ${error}

                </div>

            </c:if>


            <!-- =============================== -->
            <!-- FORM -->
            <!-- =============================== -->

            <form action="${pageContext.request.contextPath}/admin/product/add"
                  method="post"
                  enctype="multipart/form-data"
                  class="needs-validation"
                  novalidate>


                <!-- ================================= -->
                <!-- TÊN SẢN PHẨM -->
                <!-- ================================= -->

                <div class="mb-3">

                    <label class="form-label fw-bold">

                        Tên sản phẩm

                        <span class="text-danger">*</span>

                    </label>


                    <input type="text"
                           name="productName"
                           id="productName"
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


                <!-- ================================= -->
                <!-- GIÁ -->
                <!-- ================================= -->

                <div class="mb-3">

                    <label class="form-label fw-bold">

                        Giá (VNĐ)

                        <span class="text-danger">*</span>

                    </label>


                    <input type="number"
                           name="price"
                           id="price"
                           class="form-control"
                           required
                           min="0"
                           step="1"
                           placeholder="Ví dụ: 150000"
                           inputmode="numeric">


                    <div class="invalid-feedback">

                        Vui lòng nhập giá hợp lệ.
                        Giá phải là số nguyên từ 0 trở lên.

                    </div>

                </div>


                <!-- ================================= -->
                <!-- DANH MỤC -->
                <!-- ================================= -->

                <div class="mb-3">

                    <label class="form-label fw-bold">

                        Chọn Danh mục

                        <span class="text-danger">*</span>

                    </label>


                    <select name="categoryId"
                            id="categoryId"
                            class="form-select"
                            required>


                        <option value="" selected disabled>

                            -- Chọn danh mục sản phẩm --

                        </option>


                        <!--
                            Duyệt danh sách category
                            Controller gửi sang
                        -->

                        <c:forEach items="${listcate}" var="cate">

                            <option value="${cate.categoryId}">

                                ${cate.categoryname}

                            </option>

                        </c:forEach>


                    </select>


                    <div class="invalid-feedback">

                        Vui lòng chọn một danh mục sản phẩm.

                    </div>

                </div>


                <!-- ================================= -->
                <!-- HÌNH ẢNH -->
                <!-- ================================= -->

                <div class="mb-3">

                    <label class="form-label fw-bold">

                        Hình ảnh (Upload)

                        <span class="text-danger">*</span>

                    </label>


                    <input type="file"
                           name="imageFile"
                           id="imageFile"
                           class="form-control"
                           accept=".jpg,.jpeg,.png,.webp,image/jpeg,image/png,image/webp"
                           required>


                    <div class="invalid-feedback"
                         id="imageError">

                        Vui lòng chọn hình ảnh hợp lệ.

                    </div>


                    <div class="image-hint">

                        <i class="bi bi-info-circle me-1"></i>

                        Chỉ hỗ trợ JPG, JPEG, PNG, WEBP.
                        Dung lượng tối đa 5MB.

                    </div>

                </div>


                <!-- ================================= -->
                <!-- MÔ TẢ -->
                <!-- ================================= -->

                <div class="mb-4">

                    <label class="form-label fw-bold">

                        Mô tả sản phẩm

                    </label>


                    <textarea name="description"
                              id="description"
                              class="form-control"
                              rows="4"
                              maxlength="1000"
                              placeholder="Nhập mô tả chi tiết sản phẩm..."></textarea>


                    <div class="char-counter">

                        <span id="charCount">0</span>/1000 ký tự

                    </div>


                    <div class="invalid-feedback">

                        Mô tả không được vượt quá 1000 ký tự.

                    </div>

                </div>


                <!-- ================================= -->
                <!-- BUTTON -->
                <!-- ================================= -->

                <div class="d-flex gap-3">


                    <button type="submit"
                            class="btn btn-primary fw-bold px-4 py-2 w-50">

                        <i class="bi bi-save me-1"></i>

                        Lưu Sản Phẩm

                    </button>


                    <button type="reset"
                            id="resetButton"
                            class="btn btn-secondary fw-bold px-4 py-2 w-50">

                        <i class="bi bi-arrow-counterclockwise me-1"></i>

                        Làm Mới

                    </button>


                </div>


            </form>


        </div>

    </div>

</div>


<!-- ========================================= -->
<!-- JAVASCRIPT VALIDATION -->
<!-- ========================================= -->

<script>

(function () {

    'use strict';


    const form =
        document.querySelector('.needs-validation');


    if (!form) {
        return;
    }


    // =========================================
    // SUBMIT VALIDATION
    // =========================================

    form.addEventListener('submit', function (event) {


        /*
         * Kiểm tra hình ảnh riêng
         */

        if (!validateImage()) {

            event.preventDefault();
            event.stopPropagation();

        }


        /*
         * Kiểm tra HTML5 validation
         */

        if (!form.checkValidity()) {

            event.preventDefault();
            event.stopPropagation();


            /*
             * Focus vào ô lỗi đầu tiên
             */

            const firstInvalid =
                form.querySelector(':invalid');


            if (firstInvalid) {

                firstInvalid.focus();

            }

        }


        /*
         * Hiển thị validation
         */

        form.classList.add('was-validated');


    }, false);


    // =========================================
    // TÊN SẢN PHẨM
    // =========================================

    const productName =
        document.getElementById('productName');


    if (productName) {

        productName.addEventListener('input', function () {

            /*
             * Xóa khoảng trắng ở đầu
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

        });

    }


    // =========================================
    // GIÁ
    // =========================================

    const price =
        document.getElementById('price');


    if (price) {

        price.addEventListener('input', function () {

            /*
             * Không cho số âm
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


    // =========================================
    // HÌNH ẢNH
    // =========================================

    const imageFile =
        document.getElementById('imageFile');


    function validateImage() {

        if (!imageFile) {
            return true;
        }


        const file =
            imageFile.files[0];


        /*
         * Chưa chọn ảnh
         */

        if (!file) {

            imageFile.setCustomValidity(
                'Vui lòng chọn hình ảnh.'
            );

            return false;

        }


        /*
         * Các định dạng được phép
         */

        const allowedTypes = [

            'image/jpeg',
            'image/png',
            'image/webp'

        ];


        if (!allowedTypes.includes(file.type)) {

            imageFile.setCustomValidity(
                'Chỉ hỗ trợ JPG, JPEG, PNG hoặc WEBP.'
            );

            return false;

        }


        /*
         * Giới hạn 5MB
         */

        const maxSize =
            5 * 1024 * 1024;


        if (file.size > maxSize) {

            imageFile.setCustomValidity(
                'Dung lượng ảnh không được vượt quá 5MB.'
            );

            return false;

        }


        /*
         * Hợp lệ
         */

        imageFile.setCustomValidity('');

        return true;

    }


    if (imageFile) {

        imageFile.addEventListener('change', function () {

            validateImage();

        });

    }


    // =========================================
    // MÔ TẢ
    // =========================================

    const description =
        document.getElementById('description');

    const charCount =
        document.getElementById('charCount');


    if (description && charCount) {

        description.addEventListener('input', function () {

            charCount.textContent =
                this.value.length;

        });

    }


    // =========================================
    // RESET FORM
    // =========================================

    const resetButton =
        document.getElementById('resetButton');


    if (resetButton) {

        resetButton.addEventListener('click', function () {

            /*
             * Chờ form reset xong
             */

            setTimeout(function () {

                form.classList.remove('was-validated');


                /*
                 * Reset số ký tự
                 */

                if (charCount) {

                    charCount.textContent = '0';

                }


                /*
                 * Reset validation ảnh
                 */

                if (imageFile) {

                    imageFile.setCustomValidity('');

                }

            }, 10);

        });

    }


})();

</script>


</body>

</html>