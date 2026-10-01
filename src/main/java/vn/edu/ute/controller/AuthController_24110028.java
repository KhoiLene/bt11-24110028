package vn.edu.ute.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.ute.model.User_24110028;
import vn.edu.ute.service.IUserService_24110028;

import javax.servlet.http.HttpSession;

/**
 * Controller Xác thực Đăng nhập & Đăng xuất (Câu 2) - MSSV: 24110028
 */
@Controller
public class AuthController_24110028 {

    private final IUserService_24110028 userService;

    @Autowired
    public AuthController_24110028(IUserService_24110028 userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String showLoginForm(@RequestParam(value = "message", required = false) String message, Model model) {
        if ("logged_out".equals(message)) {
            model.addAttribute("successMessage", "Bạn đã đăng xuất thành công!");
        } else if ("access_denied".equals(message)) {
            model.addAttribute("errorMessage", "Bạn cần đăng nhập với vai trò Quản trị viên (Admin) để vào trang này!");
        } else if ("register_success".equals(message)) {
            model.addAttribute("successMessage", "Kích hoạt tài khoản thành công! Vui lòng đăng nhập.");
        }
        return "web/login";
    }

    @PostMapping("/login")
    public String handleLogin(@RequestParam(value = "username", required = false) String username,
                              @RequestParam(value = "password", required = false) String password,
                              HttpSession session,
                              Model model) {
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            model.addAttribute("errorMessage", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            return "web/login";
        }

        User_24110028 user = userService.login(username.trim(), password.trim());
        if (user != null) {
            session.setAttribute("currentUser", user);
            session.setAttribute("user", user);
            if (user.isAdmin()) {
                return "redirect:/admin/home";
            } else {
                return "redirect:/home";
            }
        } else {
            // Ngược lại (sai tài khoản/mật khẩu hoặc chưa kích hoạt) thì quay lại trang đăng nhập
            model.addAttribute("errorMessage", "Đăng nhập thất bại! Sai tên đăng nhập, mật khẩu hoặc tài khoản chưa kích hoạt OTP.");
            model.addAttribute("username", username);
            return "web/login";
        }
    }

    @GetMapping("/logout")
    public String handleLogout(HttpSession session) {
        if (session != null) {
            session.removeAttribute("currentUser");
            session.invalidate();
        }
        return "redirect:/login?message=logged_out";
    }
}
