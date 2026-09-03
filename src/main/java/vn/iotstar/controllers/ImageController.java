package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/image" })
public class ImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final String uploadPath = "C:\\upload";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName != null && !fileName.isEmpty()) {
            File file = new File(uploadPath, fileName);
            if (file.exists()) {
                resp.setContentType(getServletContext().getMimeType(file.getName()));
                Files.copy(file.toPath(), resp.getOutputStream());
            }
        }
    }
}