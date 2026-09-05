package vn.iotstar.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Product;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.ProductServiceImpl;

// Đường dẫn khớp chính xác với link ở nút Xem chi tiết
@WebServlet(urlPatterns = {"/product/detail"})
public class ProductDetailController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Hứng ID sản phẩm từ URL (vd: ?id=1)
            String idStr = req.getParameter("id");
            int id = Integer.parseInt(idStr);

            // 2. Xuống Database tìm món hàng đó
            Product product = productService.findById(id);

            // 3. Đóng gói gửi sang JSP
            req.setAttribute("p", product);

            // 4. Chuyển hướng sang trang giao diện chi tiết
            req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu lỗi hoặc không tìm thấy ID thì đá về trang chủ
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}