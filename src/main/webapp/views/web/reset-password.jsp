<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
</head>
<body>
    <div style="width: 350px; margin: 50px auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px;">
        <h2>Đặt Lại Mật Khẩu</h2>
        
        <% if (request.getAttribute("alert") != null) { %>
            <p style="color: red;"><%= request.getAttribute("alert") %></p>
        <% } %>

        <form action="reset-password" method="post">
            <div style="margin-bottom: 15px;">
                <label>Mã OTP (6 chữ số):</label><br>
                <input type="text" name="code" required style="width: 100%; padding: 8px; margin-top: 5px;">
            </div>
            <div style="margin-bottom: 15px;">
                <label>Mật khẩu mới:</label><br>
                <input type="password" name="newPassword" required style="width: 100%; padding: 8px; margin-top: 5px;">
            </div>
            <button type="submit" style="width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 3px;">Xác nhận đổi mật khẩu</button>
        </form>
    </div>
</body>
</html>