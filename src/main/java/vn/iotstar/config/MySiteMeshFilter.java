package vn.iotstar.config;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;

@WebFilter(urlPatterns = {"/*"})
public class MySiteMeshFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String path = req.getRequestURI();

        // Bỏ qua các file tĩnh, trang login/register, hoặc khi đã forward trực tiếp tới layout admin.jsp
        if (path.contains("/login") || path.contains("/register") || path.contains("/logout") || 
            path.contains("/image") || path.endsWith(".css") || path.endsWith(".js") ||
            path.contains("/decorators/")) {
            chain.doFilter(request, response);
            return;
        }

        // Nếu là trang admin thì bọc layout admin.jsp vào
        if (path.contains("/admin")) {
            HttpServletResponse resp = (HttpServletResponse) response;
            CharResponseWrapper wrapper = new CharResponseWrapper(resp);
            chain.doFilter(request, wrapper);
            
            String originalContent = wrapper.toString();
            
            // Đưa nội dung trang con vào biến request để admin.jsp nhúng vào
            req.setAttribute("content", originalContent);
            
            // Forward tới file layout admin.jsp
            req.getRequestDispatcher("/decorators/admin.jsp").forward(request, response);
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}

    // Lớp Wrapper để bắt nội dung HTML trả về của trang con
    private static class CharResponseWrapper extends HttpServletResponseWrapper {
        private CharArrayWriter charWriter;

        public CharResponseWrapper(HttpServletResponse response) {
            super(response);
            charWriter = new CharArrayWriter();
        }

        @Override
        public PrintWriter getWriter() throws IOException {
            return new PrintWriter(charWriter);
        }

        @Override
        public String toString() {
            return charWriter.toString();
        }
    }
}