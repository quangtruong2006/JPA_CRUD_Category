package vn.iotstar.controllers; 

import java.io.IOException;
import java.util.List; // Thêm thư viện List

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.User;
import vn.iotstar.entity.Product; // Thêm Entity Product
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;
import vn.iotstar.services.IProductService; // Thêm Service
import vn.iotstar.services.impl.ProductServiceImpl; // Thêm Impl
import vn.iotstar.utils.Constant;
import vn.iotstar.utils.CookieUtils;

@WebServlet(urlPatterns = "/home")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Giữ nguyên UserService của ông
    private final IUserService userService = new UserServiceImpl();
    
    // THÊM MỚI: Gọi ProductService để xử lý sản phẩm
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. GIỮ NGUYÊN BẢN GỐC: Kiểm tra đăng nhập và Cookie
        User user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        // 2. THÊM MỚI: Nếu đã đăng nhập thành công thì đi lấy 10 sản phẩm
        List<Product> listTop10 = productService.findTop10();
        req.setAttribute("list10", listTop10);

        // 3. GIỮ NGUYÊN BẢN GỐC: Điều hướng sang file jsp bằng Constant của ông
        req.getRequestDispatcher(Constant.Path.HOME).forward(req, resp);
    }
}