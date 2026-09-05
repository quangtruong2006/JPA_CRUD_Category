package vn.iotstar.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.ProductServiceImpl;

// Đường dẫn xử lý khi bấm nút Xóa
@WebServlet(urlPatterns = {"/admin/product/delete"})
public class DeleteProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Hứng cái ID sản phẩm từ URL gửi lên
            String idStr = req.getParameter("id");
            int id = Integer.parseInt(idStr);

            // 2. Gọi Service xuống Database để "trảm" nó
            productService.delete(id);

            // 3. Xóa thành công thì đá người dùng quay lại trang Danh sách sản phẩm
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi xóa sản phẩm: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/list-product.jsp").forward(req, resp);
        }
    }
}