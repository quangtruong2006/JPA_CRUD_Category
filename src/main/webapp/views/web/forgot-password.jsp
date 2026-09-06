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

    <title>Quên mật khẩu - Khôi phục tài khoản</title>


    <!-- Google Fonts -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">


    <!-- Bootstrap 5 -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">


    <!-- Bootstrap Icons -->

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <style>

        * {
            font-family:
                'Plus Jakarta Sans',
                -apple-system,
                BlinkMacSystemFont,
                'Segoe UI',
                Roboto,
                sans-serif;

            box-sizing: border-box;
        }


        body {

            margin: 0;

            min-height: 100vh;

            background:
                linear-gradient(
                    135deg,
                    #eff6ff 0%,
                    #f8fafc 50%,
                    #eef2ff 100%
                );

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 20px;

        }


        /* =========================
           FORM CONTAINER
           ========================= */

        .forgot-wrapper {

            width: 100%;

            max-width: 450px;

            background: #ffffff;

            border-radius: 16px;

            box-shadow:
                0 15px 35px rgba(0, 0, 0, 0.07);

            border: 1px solid #e2e8f0;

            padding: 40px 30px;

        }


        /* =========================
           ICON
           ========================= */

        .icon-circle {

            width: 70px;

            height: 70px;

            background: #eff6ff;

            border-radius: 50%;

            display: flex;

            align-items: center;

            justify-content: center;

            margin: 0 auto 20px;

            color: #2563eb;

            font-size: 32px;

        }


        /* =========================
           INPUT
           ========================= */

        .form-control-custom {

            border-radius: 10px;

            padding: 12px 16px;

            border: 1.5px solid #cbd5e1;

            font-size: 15px;

            transition: all 0.3s;

        }


        .form-control-custom:focus {

            border-color: #2563eb;

            box-shadow:
                0 0 0 4px
                rgba(37, 99, 235, 0.15);

        }


        .form-control-custom::placeholder {

            color: #94a3b8;

        }


        /* =========================
           BUTTON
           ========================= */

        .btn-submit {

            background:
                linear-gradient(
                    135deg,
                    #2563eb 0%,
                    #1d4ed8 100%
                );

            color: #ffffff;

            font-weight: 700;

            padding: 12px;

            border-radius: 10px;

            border: none;

            width: 100%;

            transition: all 0.3s;

            box-shadow:
                0 4px 12px
                rgba(37, 99, 235, 0.2);

        }


        .btn-submit:hover {

            transform: translateY(-2px);

            box-shadow:
                0 6px 16px
                rgba(37, 99, 235, 0.35);

            color: #ffffff;

        }


        .btn-submit:active {

            transform: translateY(0);

        }


        /* =========================
           ALERT
           ========================= */

        .alert {

            border: none;

        }


        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 500px) {

            .forgot-wrapper {

                padding: 30px 20px;

            }

        }

    </style>

</head>


<body>


    <div class="forgot-wrapper">


        <!-- ICON -->

        <div class="icon-circle">

            <i class="bi bi-shield-lock-fill"></i>

        </div>


        <!-- TITLE -->

        <h3 class="text-center fw-bold mb-2"
            style="color: #0f172a;">

            Quên Mật Khẩu?

        </h3>


        <p class="text-center text-muted mb-4 small">

            Đừng lo lắng! Hãy nhập email bạn đã dùng
            để đăng ký, hệ thống sẽ gửi mã OTP khôi phục.

        </p>


        <!-- =========================
             ALERT ERROR
             ========================= -->

        <c:if test="${not empty alert}">

            <div class="alert alert-danger
                        py-2 px-3 small rounded-3">

                <i class="bi bi-exclamation-triangle-fill me-2"></i>

                ${alert}

            </div>

        </c:if>


        <!-- =========================
             ALERT SUCCESS
             ========================= -->

        <c:if test="${not empty message}">

            <div class="alert alert-success
                        py-2 px-3 small rounded-3">

                <i class="bi bi-check-circle-fill me-2"></i>

                ${message}

            </div>

        </c:if>


        <!-- =========================
             FORM
             ========================= -->

        <form action="${pageContext.request.contextPath}/forgot-password"
              method="post"
              class="needs-validation"
              novalidate>


            <!-- EMAIL -->

            <div class="mb-4">

                <label class="form-label fw-bold small"
                       style="color: #334155;">

                    Địa chỉ Email

                    <span class="text-danger">*</span>

                </label>


                <input type="email"
                       name="email"
                       id="email"
                       class="form-control form-control-custom"
                       required
                       minlength="5"
                       maxlength="100"
                       pattern="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
                       placeholder="Nhập email của bạn..."
                       autocomplete="email"
                       autofocus>


                <div class="invalid-feedback">

                    Vui lòng nhập địa chỉ email hợp lệ.

                </div>

            </div>


            <!-- SUBMIT -->

            <button type="submit"
                    class="btn-submit">

                <i class="bi bi-envelope-paper-fill me-1"></i>

                Gửi mã OTP xác nhận

            </button>


            <!-- BACK TO LOGIN -->

            <div class="text-center mt-4">

                <a href="${pageContext.request.contextPath}/login"
                   class="text-decoration-none
                          fw-semibold
                          text-secondary
                          small">

                    <i class="bi bi-arrow-left me-1"></i>

                    Quay lại trang Đăng nhập

                </a>

            </div>


        </form>


    </div>


    <!-- =========================
         JAVASCRIPT VALIDATION
         ========================= -->

    <script>

        'use strict';


        const form =
            document.querySelector('.needs-validation');


        const email =
            document.getElementById('email');


        /*
         * =========================
         * XỬ LÝ EMAIL
         * =========================
         */

        if (email) {

            email.addEventListener(
                'input',
                function () {

                    /*
                     * Không cho nhập khoảng trắng
                     */

                    this.value =
                        this.value.replace(/\s/g, '');

                }
            );


            email.addEventListener(
                'blur',
                function () {

                    /*
                     * Xóa khoảng trắng đầu/cuối
                     */

                    this.value =
                        this.value.trim();

                }
            );

        }


        /*
         * =========================
         * SUBMIT FORM
         * =========================
         */

        if (form) {

            form.addEventListener(
                'submit',
                function (event) {


                    /*
                     * Kiểm tra email
                     */

                    if (email) {

                        email.value =
                            email.value.trim();

                    }


                    /*
                     * Kiểm tra toàn bộ form
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

                    form.classList.add(
                        'was-validated'
                    );

                },
                false
            );

        }

    </script>


</body>

</html>