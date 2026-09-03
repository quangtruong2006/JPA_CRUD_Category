package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.UserServiceImpl;

@MultipartConfig
@WebServlet(urlPatterns = { "/admin/profile", "/admin/profile/update" })
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/profile")) {
            // Giả lập lấy ID user đang đăng nhập (hoặc lưu session)
            int userid = 1; // Thay bằng user đang login thực tế
            User user = userService.findById(userid);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/admin/profile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/profile/update")) {
            int userid = Integer.parseInt(req.getParameter("userid"));
            String fullname = req.getParameter("fullname");
            String phone = req.getParameter("phone");

            User user = userService.findById(userid);
            user.setFullname(fullname);
            user.setPhone(phone);

            String uploadPath = "C:\\upload";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String ext = filename.substring(filename.lastIndexOf(".") + 1);
                    String fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    user.setImages(fname);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            userService.update(user);
            resp.sendRedirect(req.getContextPath() + "/admin/profile");
        }
    }
}