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

@WebServlet(urlPatterns = "/verify")
public class VerifyController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/web/verify.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String enteredCode = req.getParameter("code");

        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        User user = service.findByEmail(email);
        if (user != null && user.getCode() != null && user.getCode().equals(enteredCode.trim())) {
            // Xác thực thành công: Đổi status thành 1 và xóa mã code
            user.setStatus(1); 
            user.setCode(null); 
            service.update(user);

            session.removeAttribute("email");
            resp.sendRedirect(req.getContextPath() + "/login?verified=success");
        } else {
            req.setAttribute("alert", "Mã OTP không chính xác, vui lòng kiểm tra lại!");
            req.getRequestDispatcher("/views/web/verify.jsp").forward(req, resp);
        }
    }
}