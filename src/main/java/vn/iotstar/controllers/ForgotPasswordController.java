package vn.iotstar.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;
import vn.iotstar.utils.EmailUtils;

@WebServlet(urlPatterns = "/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/web/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập địa chỉ email của bạn!");
            req.getRequestDispatcher("/views/web/forgot-password.jsp").forward(req, resp);
            return;
        }

        User user = service.findByEmail(email.trim());
        if (user == null) {
            req.setAttribute("alert", "Email này không tồn tại trong hệ thống!");
            req.getRequestDispatcher("/views/web/forgot-password.jsp").forward(req, resp);
            return;
        }

        // Sinh mã OTP 6 chữ số mới cho việc đổi mật khẩu
        String code = String.format("%06d", new java.util.Random().nextInt(999999));
        user.setCode(code);
        service.update(user);

        // Gửi email chứa mã OTP khôi phục
        String subject = "Yêu cầu khôi phục mật khẩu tài khoản";
        String messageText = "Xin chào " + user.getFullname() + ",\n\nMã OTP để khôi phục mật khẩu của bạn là: " + code + "\nVui lòng nhập mã này trên trang đổi mật khẩu.";
        EmailUtils.sendEmail(email.trim(), subject, messageText);

        // Lưu email vào session để chuyển sang bước nhập mã xác thực và mật khẩu mới
        req.getSession().setAttribute("forgotEmail", email.trim());
        resp.sendRedirect(req.getContextPath() + "/reset-password");
    }
}