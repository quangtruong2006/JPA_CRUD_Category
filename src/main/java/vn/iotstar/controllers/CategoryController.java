package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.services.impl.UserServiceImpl;
import vn.iotstar.utils.Constant;
import vn.iotstar.utils.CookieUtils;

@WebServlet(urlPatterns = {
    "/admin/categories",
    "/admin/category",
    "/admin/category/list",
    "/admin/category/add",
    "/admin/category/edit",
    "/admin/category/delete"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ICategoryService cateService = new CategoryServiceImpl();
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (user.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        String url = req.getRequestURI();

        if (url.contains("categories") || url.contains("list") || url.endsWith("/admin/category")) {
            String keyword = req.getParameter("keyword");
            List<Category> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = cateService.searchByName(keyword.trim());
                req.setAttribute("keyword", keyword.trim());
            } else {
                list = cateService.findAll();
            }
            req.setAttribute("cateList", list);
            req.setAttribute("listcate", list);
            req.setAttribute("categories", list);
            req.getRequestDispatcher("/views/admin/list-category.jsp").forward(req, resp);

        } else if (url.contains("add")) {
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);

        } else if (url.contains("edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Category category = cateService.findById(id);
                req.setAttribute("category", category);
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            }

        } else if (url.contains("delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                cateService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User user = CookieUtils.checkAndRestoreSession(req, userService);
        if (user == null || user.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String url = req.getRequestURI();

        if (url.contains("add")) {
            try {
                String name = req.getParameter("name");
                if (name == null || name.trim().isEmpty()) {
                    name = req.getParameter("categoryname");
                }
                if (name == null || name.trim().isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/admin/category/add");
                    return;
                }

                Category category = new Category();
                // Lưu ý: Kiểm tra xem Entity Category của ông dùng setCategoryname hay setName
                category.setCategoryname(name.trim());
                category.setStatus(1);

                try {
                    Part filePart = req.getPart("icon");
                    if (filePart == null || filePart.getSize() == 0) {
                        filePart = req.getPart("images");
                    }

                    if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
                        String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        String ext = "";
                        int dotIdx = submittedName.lastIndexOf(".");
                        if (dotIdx > 0) {
                            ext = submittedName.substring(dotIdx + 1);
                        }
                        String fileName = System.currentTimeMillis() + (ext.isEmpty() ? "" : "." + ext);

                        // Sử dụng Constant.DIR để lưu file chuẩn theo cấu hình
                        File uploadDir1 = new File(Constant.DIR + File.separator + "category");
                        if (!uploadDir1.exists()) {
                            uploadDir1.mkdirs();
                        }
                        String savedPath = uploadDir1.getAbsolutePath() + File.separator + fileName;
                        filePart.write(savedPath);
                        category.setImages("category/" + fileName);
                    }
                } catch (Exception fileEx) {
                    fileEx.printStackTrace();
                }

                cateService.insert(category);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");

        } else if (url.contains("edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                if (name == null || name.trim().isEmpty()) {
                    name = req.getParameter("categoryname");
                }

                Category category = cateService.findById(id);
                if (category != null) {
                    category.setCategoryname(name != null ? name.trim() : "");
                    category.setStatus(1);

                    try {
                        Part filePart = req.getPart("icon");
                        if (filePart == null || filePart.getSize() == 0) {
                            filePart = req.getPart("images");
                        }

                        if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
                            String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                            String ext = "";
                            int dotIdx = submittedName.lastIndexOf(".");
                            if (dotIdx > 0) {
                                ext = submittedName.substring(dotIdx + 1);
                            }
                            String fileName = System.currentTimeMillis() + (ext.isEmpty() ? "" : "." + ext);

                            File uploadDir1 = new File(Constant.DIR + File.separator + "category");
                            if (!uploadDir1.exists()) {
                                uploadDir1.mkdirs();
                            }
                            String savedPath = uploadDir1.getAbsolutePath() + File.separator + fileName;
                            filePart.write(savedPath);
                            category.setImages("category/" + fileName);
                        }
                    } catch (Exception fileEx) {
                        fileEx.printStackTrace();
                    }

                    cateService.update(category);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        }
    }
}