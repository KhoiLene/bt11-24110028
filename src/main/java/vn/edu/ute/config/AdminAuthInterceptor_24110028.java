package vn.edu.ute.config;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import vn.edu.ute.model.User_24110028;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Interceptor kiểm tra quyền Quản trị viên (Admin) cho các route /admin/**
 * Sinh viên: Lê Nguyễn Minh Khôi - MSSV: 24110028 - Mã đề: 4
 */
@Component
public class AdminAuthInterceptor_24110028 implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        User_24110028 currentUser = (session != null) ? (User_24110028) session.getAttribute("currentUser") : null;

        if (currentUser == null || !currentUser.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login?message=access_denied");
            return false;
        }
        return true;
    }
}
