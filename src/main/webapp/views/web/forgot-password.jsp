<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
</head>
<body>
    <div style="width: 350px; margin: 50px auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px;">
        <h2>Quên Mật Khẩu</h2>
        
        <% if (request.getAttribute("alert") != null) { %>
            <p style="color: red;"><%= request.getAttribute("alert") %></p>
        <% } %>

        <form action="forgot-password" method="post">
            <div style="margin-bottom: 15px;">
                <label>Nhập email đăng ký:</label><br>
                <input type="email" name="email" required style="width: 100%; padding: 8px; margin-top: 5px;">
            </div>
            <button type="submit" style="width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 3px;">Gửi mã OTP</button>
        </form>
    </div>
</body>
</html>