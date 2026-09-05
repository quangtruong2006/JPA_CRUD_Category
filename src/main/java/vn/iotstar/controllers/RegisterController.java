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
import vn.iotstar.utils.Constant;
import vn.iotstar.utils.CookieUtils;
import vn.iotstar.utils.EmailUtils; // Thêm thư viện gửi email

@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Bỏ đoạn check session/cookie đi, cứ bấm là hiện trang đăng ký luôn không đá đi đâu hết
        req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ các thông tin bắt buộc!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (service.checkExistEmail(email.trim())) {
            req.setAttribute("alert", "Email này đã tồn tại trên hệ thống!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (service.checkExistUsername(username.trim())) {
            req.setAttribute("alert", "Tài khoản (Username) đã tồn tại!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        if (phone != null && !phone.trim().isEmpty() && service.checkExistPhone(phone.trim())) {
            req.setAttribute("alert", "Số điện thoại đã tồn tại!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        boolean isSuccess = service.register(username.trim(), password, email.trim(), fullname != null ? fullname.trim() : "", phone != null ? phone.trim() : "");
        if (isSuccess) {
            // --- BỔ SUNG XỬ LÝ OTP SAU KHI ĐĂNG KÝ THÀNH CÔNG ---
            
            // 1. Sinh ngẫu nhiên mã OTP 6 chữ số
            String code = String.format("%06d", new java.util.Random().nextInt(999999));
            
            // 2. Lấy thông tin user vừa đăng ký lên để cập nhật mã code và status = 0
            User registeredUser = service.findByEmail(email.trim());
            if (registeredUser != null) {
                registeredUser.setCode(code);
                registeredUser.setStatus(0); // Chưa kích hoạt
                service.update(registeredUser); // Lưu thay đổi xuống DB
            }

            // 3. Gửi email chứa mã OTP sang hộp thư của người dùng
            String subject = "Xác thực tài khoản Shopping Store của bạn";
            String messageText = "Xin chào " + (fullname != null ? fullname : username) + ",\n\nMã OTP kích hoạt tài khoản của bạn là: " + code + "\nVui lòng nhập mã này trên hệ thống để hoàn tất đăng ký.";
            EmailUtils.sendEmail(email.trim(), subject, messageText);

            // 4. Lưu email vào session và chuyển hướng sang trang nhập OTP
            req.getSession().setAttribute("email", email.trim());
            resp.sendRedirect(req.getContextPath() + "/verify");
            
        } else {
            req.setAttribute("alert", "Lỗi hệ thống! Không thể đăng ký lúc này.");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
        }
    }
}