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

    <title>Đặt lại mật khẩu - Khôi phục tài khoản</title>


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
                    #f0fdf4 0%,
                    #f8fafc 50%,
                    #ecfdf5 100%
                );

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 20px;

        }


        /* =========================
           FORM CONTAINER
           ========================= */

        .reset-wrapper {

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

            background: #f0fdf4;

            border-radius: 50%;

            display: flex;

            align-items: center;

            justify-content: center;

            margin: 0 auto 20px;

            color: #16a34a;

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

            border-color: #16a34a;

            box-shadow:
                0 0 0 4px
                rgba(22, 163, 74, 0.15);

        }


        .form-control-custom::placeholder {

            color: #94a3b8;

        }


        /* =========================
           OTP INPUT
           ========================= */

        .otp-input {

            text-align: center;

            font-size: 20px;

            font-weight: 700;

            letter-spacing: 6px;

        }


        /* =========================
           BUTTON
           ========================= */

        .btn-submit {

            background:
                linear-gradient(
                    135deg,
                    #16a34a 0%,
                    #15803d 100%
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
                rgba(22, 163, 74, 0.2);

        }


        .btn-submit:hover {

            transform: translateY(-2px);

            box-shadow:
                0 6px 16px
                rgba(22, 163, 74, 0.35);

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

            .reset-wrapper {

                padding: 30px 20px;

            }

        }

    </style>

</head>


<body>


    <div class="reset-wrapper">


        <!-- ICON -->

        <div class="icon-circle">

            <i class="bi bi-key-fill"></i>

        </div>


        <!-- TITLE -->

        <h3 class="text-center fw-bold mb-2"
            style="color: #0f172a;">

            Đặt Lại Mật Khẩu

        </h3>


        <p class="text-center text-muted mb-4 small">

            Vui lòng nhập mã OTP đã nhận và tạo
            mật khẩu mới cho tài khoản của bạn.

        </p>


        <!-- =========================
             ERROR MESSAGE
             ========================= -->

        <c:if test="${not empty alert}">

            <div class="alert alert-danger
                        py-2 px-3 small rounded-3">

                <i class="bi bi-exclamation-triangle-fill me-2"></i>

                ${alert}

            </div>

        </c:if>


        <!-- =========================
             FORM
             ========================= -->

        <form action="${pageContext.request.contextPath}/reset-password"
              method="post"
              class="needs-validation"
              novalidate>


            <!-- =========================
                 OTP
                 ========================= -->

            <div class="mb-3">

                <label for="otp"
                       class="form-label fw-bold small"
                       style="color: #334155;">

                    Mã OTP (6 chữ số)

                    <span class="text-danger">*</span>

                </label>


                <input type="text"
                       id="otp"
                       name="code"
                       class="form-control form-control-custom otp-input"
                       required
                       minlength="6"
                       maxlength="6"
                       pattern="^[0-9]{6}$"
                       inputmode="numeric"
                       autocomplete="one-time-code"
                       placeholder="000000"
                       autofocus>


                <div class="invalid-feedback">

                    Mã OTP phải gồm đúng 6 chữ số.

                </div>

            </div>


            <!-- =========================
                 NEW PASSWORD
                 ========================= -->

            <div class="mb-4">

                <label for="newPassword"
                       class="form-label fw-bold small"
                       style="color: #334155;">

                    Mật khẩu mới

                    <span class="text-danger">*</span>

                </label>


                <input type="password"
                       id="newPassword"
                       name="newPassword"
                       class="form-control form-control-custom"
                       required
                       minlength="6"
                       maxlength="100"
                       autocomplete="new-password"
                       placeholder="Tạo mật khẩu mới (tối thiểu 6 ký tự)">


                <div class="invalid-feedback">

                    Mật khẩu phải có từ 6 đến 100 ký tự.

                </div>

            </div>


            <!-- =========================
                 SUBMIT
                 ========================= -->

            <button type="submit"
                    class="btn-submit">

                <i class="bi bi-check2-circle me-1"></i>

                Xác nhận đổi mật khẩu

            </button>


            <!-- =========================
                 BACK TO LOGIN
                 ========================= -->

            <div class="text-center mt-4">

                <a href="${pageContext.request.contextPath}/login"
                   class="text-decoration-none
                          fw-semibold
                          text-secondary
                          small">

                    <i class="bi bi-arrow-left me-1"></i>

                    Hủy và quay lại Đăng nhập

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


        const otp =
            document.getElementById('otp');


        const newPassword =
            document.getElementById('newPassword');


        /*
         * =========================
         * OTP
         * =========================
         */

        if (otp) {

            otp.addEventListener(
                'input',
                function () {

                    /*
                     * Chỉ cho phép nhập số
                     */

                    this.value =
                        this.value
                            .replace(/[^0-9]/g, '')
                            .slice(0, 6);

                }
            );

        }


        /*
         * =========================
         * PASSWORD
         * =========================
         */

        if (newPassword) {

            newPassword.addEventListener(
                'input',
                function () {

                    /*
                     * Giới hạn tối đa 100 ký tự
                     */

                    if (this.value.length > 100) {

                        this.value =
                            this.value.slice(0, 100);

                    }

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
                     * Kiểm tra toàn bộ form
                     */

                    if (!form.checkValidity()) {

                        event.preventDefault();

                        event.stopPropagation();


                        /*
                         * Tìm ô lỗi đầu tiên
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