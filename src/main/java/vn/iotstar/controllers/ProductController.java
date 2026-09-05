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

// Áp dụng "bùa chú" Upload File của thầy Trung
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
// Đường dẫn ảo để chạy chức năng này trên web
@WebServlet(urlPatterns = {"/admin/product/add"})
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Gọi 2 Service lên để xài
    IProductService productService = new ProductServiceImpl();
    ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Lấy danh sách Category từ DB để đưa lên thẻ <select> trên giao diện
        List<Category> listcate = categoryService.findAll();
        req.setAttribute("listcate", listcate);

        // 2. Chuyển hướng sang trang giao diện (Lát nữa mình sẽ tạo file jsp này)
        req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Set tiếng Việt để gõ tên sản phẩm có dấu không bị lỗi font
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            // 1. Lấy các dữ liệu chữ từ form người dùng nhập
            String productName = req.getParameter("productName");
            String priceStr = req.getParameter("price");
            String description = req.getParameter("description");
            String categoryIdStr = req.getParameter("categoryId");

            // Ép kiểu dữ liệu cho Giá (Double) và Danh mục (Int)
            double price = Double.parseDouble(priceStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            // 2. XỬ LÝ UPLOAD FILE (Code chuẩn của thầy Trung có chỉnh lại đường dẫn)
            String fileName = "";
            Part part = req.getPart("imageFile"); // "imageFile" là tên của input chọn ảnh bên giao diện
            
            if (part != null && part.getSize() > 0) {
                fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                
                // Đường dẫn lưu ảnh thẳng vào thư mục 'uploads' của project đang chạy
                String uploadPath = req.getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                
                // Nếu thư mục uploads chưa tồn tại thì tự tạo mới
                if (!uploadDir.exists()) {
                    uploadDir.mkdir(); 
                }
                
                // Ghi file ảnh vào thư mục
                part.write(uploadPath + File.separator + fileName);
            }

            // 3. Đưa tất cả dữ liệu vừa hứng được vào Object Product
            Product product = new Product();
            product.setProductName(productName);
            product.setPrice(price);
            product.setDescription(description);
            product.setImage(fileName); // Lưu tên tấm ảnh vào DB (vd: laptop.jpg)

            // Đi tìm Category tương ứng và gắn vào Product
            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            // 4. Gọi Service để Insert thẳng xuống Database
            productService.insert(product);

            // Thành công thì báo câu thông báo
            req.setAttribute("message", "Thêm sản phẩm thành công rực rỡ!");
            
            // Bắt buộc phải load lại danh sách Category để form không bị trắng xóa
            req.setAttribute("listcate", categoryService.findAll());
            req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi rồi đại vương ơi: " + e.getMessage());
            // Lỗi cũng phải load lại list danh mục
            req.setAttribute("listcate", categoryService.findAll()); 
            req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);
        }
    }
}