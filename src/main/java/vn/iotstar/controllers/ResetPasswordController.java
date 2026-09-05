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

@WebServlet(urlPatterns = "/reset-password")
public class ResetPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/web/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String code = req.getParameter("code");
        String newPassword = req.getParameter("newPassword");

        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("forgotEmail");

        if (email == null) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }

        User user = service.findByEmail(email);
        if (user != null && user.getCode() != null && user.getCode().equals(code.trim())) {
            // Cập nhật mật khẩu mới và xóa mã code OTP đi
            user.setPassword(newPassword.trim()); 
            user.setCode(null); 
            service.update(user);

            session.removeAttribute("forgotEmail");
            resp.sendRedirect(req.getContextPath() + "/login?reset=success");
        } else {
            req.setAttribute("alert", "Mã OTP không chính xác, vui lòng kiểm tra lại!");
            req.getRequestDispatcher("/views/web/reset-password.jsp").forward(req, resp);
        }
    }
}