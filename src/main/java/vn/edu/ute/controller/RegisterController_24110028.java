package vn.edu.ute.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.ute.model.User_24110028;
import vn.edu.ute.service.IEmailService_24110028;
import vn.edu.ute.service.IUserService_24110028;

import javax.servlet.http.HttpSession;
import java.util.Random;

/**
 * Controller Đăng ký & Xác thực OTP qua Email (Câu 2) - MSSV: 24110028
 */
@Controller
public class RegisterController_24110028 {

    private final IUserService_24110028 userService;
    private final IEmailService_24110028 emailService;

    @Autowired
    public RegisterController_24110028(IUserService_24110028 userService,
                                      IEmailService_24110028 emailService) {
        this.userService = userService;
        this.emailService = emailService;
    }

    @GetMapping("/register")
    public String showRegisterForm() {
        return "web/register";
    }

    @PostMapping("/register")
    public String handleRegister(@RequestParam(value = "username", required = false) String username,
                                 @RequestParam(value = "password", required = false) String password,
                                 @RequestParam(value = "fullname", required = false) String fullname,
                                 @RequestParam(value = "email", required = false) String email,
                                 @RequestParam(value = "phone", required = false) String phone,
                                 HttpSession session,
                                 Model model) {
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            fullname == null || fullname.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            model.addAttribute("errorMessage", "Vui lòng nhập đầy đủ các trường bắt buộc!");
            return "web/register";
        }

        username = username.trim();
        email = email.trim();

        if (userService.existsByUsername(username)) {
            model.addAttribute("errorMessage", "Tên đăng nhập '" + username + "' đã được sử dụng!");
            return "web/register";
        }

        if (userService.existsByEmail(email)) {
            model.addAttribute("errorMessage", "Địa chỉ Email '" + email + "' đã tồn tại!");
            return "web/register";
        }

        // Kiểm tra độ mạnh mật khẩu: tối thiểu 8 ký tự, gồm chữ hoa, chữ thường và chữ số
        String passwordPattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$";
        if (!password.trim().matches(passwordPattern)) {
            model.addAttribute("errorMessage", "Mật khẩu chưa đạt yêu cầu: Tối thiểu 8 ký tự, bao gồm ít nhất 1 chữ in hoa (A-Z), 1 chữ in thường (a-z) và 1 chữ số (0-9)!");
            return "web/register";
        }

        // Sinh mã OTP 6 chữ số (Câu 2)
        Random rnd = new Random();
        int number = rnd.nextInt(900000) + 100000;
        String otp = String.valueOf(number);

        User_24110028 pendingUser = new User_24110028();
        pendingUser.setUsername(username);
        pendingUser.setPassword(password.trim());
        pendingUser.setFullname(fullname.trim());
        pendingUser.setEmail(email);
        pendingUser.setPhone(phone != null ? phone.trim() : "");
        pendingUser.setAdmin(false);
        pendingUser.setActive(false);
        pendingUser.setImages("https://i.pravatar.cc/150?u=" + username);

        session.setAttribute("pendingUser", pendingUser);
        session.setAttribute("regOtp", otp);
        session.setAttribute("otpEmail", email);

        // Gửi OTP qua Gmail SMTP (smtp.gmail.com)
        emailService.sendOtpEmail(email, otp);

        return "redirect:/verify-otp";
    }

    @GetMapping("/verify-otp")
    public String showVerifyOtpForm(HttpSession session) {
        if (session == null || session.getAttribute("pendingUser") == null) {
            return "redirect:/register";
        }
        return "web/verify-otp";
    }

    @PostMapping("/verify-otp")
    public String handleVerifyOtp(@RequestParam(value = "otp", required = false) String inputOtp,
                                  HttpSession session,
                                  Model model) {
        if (session == null || session.getAttribute("pendingUser") == null) {
            return "redirect:/register";
        }

        String actualOtp = (String) session.getAttribute("regOtp");
        User_24110028 pendingUser = (User_24110028) session.getAttribute("pendingUser");

        if (inputOtp != null && inputOtp.trim().equals(actualOtp)) {
            pendingUser.setActive(true);
            boolean created = userService.create(pendingUser);

            if (created) {
                session.removeAttribute("pendingUser");
                session.removeAttribute("regOtp");
                session.removeAttribute("otpEmail");

                return "redirect:/login?message=register_success";
            } else {
                model.addAttribute("errorMessage", "Đã có lỗi xảy ra khi lưu tài khoản vào cơ sở dữ liệu!");
            }
        } else {
            model.addAttribute("errorMessage", "Mã OTP không chính xác! Vui lòng thử lại.");
        }

        return "web/verify-otp";
    }
}
