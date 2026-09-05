package vn.iotstar.controllers;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Product;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.ProductServiceImpl;

// Đã cập nhật chuẩn URL theo yêu cầu đề bài là /product (vẫn giữ /shop để dự phòng)
@WebServlet(urlPatterns = {"/product", "/shop"})
public class ShopController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. Lấy trang hiện tại người dùng đang bấm (nếu mới vào thì mặc định là trang 1)
        String indexPage = req.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int page = Integer.parseInt(indexPage);

        // 2. Lấy tổng số sản phẩm trong Database
        int count = productService.count();
        int pageSize = 6; // Yêu cầu đề bài: 6 sản phẩm 1 trang
        
        // 3. Tính toán tổng số trang
        int endPage = count / pageSize;
        if (count % pageSize != 0) {
            endPage++;
        }

        // 4. Lấy danh sách sản phẩm phân trang
        List<Product> list = productService.findAll(page, pageSize);

        // 5. Gửi dữ liệu sang JSP
        req.setAttribute("listP", list);     
        req.setAttribute("endP", endPage);   
        req.setAttribute("tag", page);       

        req.getRequestDispatcher("/views/web/shop.jsp").forward(req, resp);
    }
}