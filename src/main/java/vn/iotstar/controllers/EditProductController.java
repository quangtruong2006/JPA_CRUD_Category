package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.services.impl.ProductServiceImpl;

// Áp dụng bùa chú upload file
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(urlPatterns = {"/admin/product/edit"})
public class EditProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    IProductService productService = new ProductServiceImpl();
    ICategoryService categoryService = new CategoryServiceImpl();

    // HÀM 1: Chạy khi bấm nút Sửa trên bảng -> Lấy dữ liệu cũ hiện lên form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Lấy ID sản phẩm cần sửa
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            
            // Đổ danh sách Category và thông tin Sản phẩm cũ sang form
            List<Category> listcate = categoryService.findAll();
            req.setAttribute("listcate", listcate);
            req.setAttribute("product", product); 
            
            // Điều hướng sang trang jsp (lát mình tạo)
            req.getRequestDispatcher("/views/admin/edit-product.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        }
    }

    // HÀM 2: Chạy khi bấm nút "Cập nhật" trên form -> Đẩy xuống DB
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            // Hứng dữ liệu từ form
            int productId = Integer.parseInt(req.getParameter("productId"));
            String productName = req.getParameter("productName");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            // Gọi sản phẩm cũ từ DB lên để chỉnh sửa
            Product product = productService.findById(productId);
            product.setProductName(productName);
            product.setPrice(price);
            product.setDescription(description);

            // Gắn lại Danh mục
            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            // XỬ LÝ ẢNH: Nếu có up ảnh mới thì đè ảnh cũ, không thì bỏ qua
            Part part = req.getPart("imageFile");
            if (part != null && part.getSize() > 0) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String uploadPath = req.getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                // Lưu file mới
                part.write(uploadPath + File.separator + fileName);
                
                // Cập nhật tên ảnh mới vào object
                product.setImage(fileName); 
            }

            // Gọi hàm Update xuống DB
            productService.update(product);
            
            // Xong xuôi thì đá văng ra lại trang danh sách
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}