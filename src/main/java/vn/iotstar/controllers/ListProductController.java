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

@WebServlet(urlPatterns = {"/admin/product/list"})
public class ListProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Gọi Service lấy toàn bộ sản phẩm từ Database
        List<Product> list = productService.findAll();
        
        // Đẩy danh sách này sang JSP
        req.setAttribute("listproduct", list);
        
        // Chuyển hướng sang trang giao diện
        req.getRequestDispatcher("/views/admin/list-product.jsp").forward(req, resp);
    }
}