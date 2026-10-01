package vn.edu.ute.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.ute.model.User_24110028;
import vn.edu.ute.service.IUserService_24110028;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Controller Quản trị Users (Câu 3: CRUD + Phân trang 6 users / trang) - MSSV: 24110028
 */
@Controller
public class AdminUserController_24110028 {

    private final IUserService_24110028 userService;
    private static final int PAGE_SIZE = 6; // Câu 3: Phân trang 6 user trên 01 trang

    @Autowired
    public AdminUserController_24110028(IUserService_24110028 userService) {
        this.userService = userService;
    }

    /**
     * Danh sách Users + Phân trang 6 users / trang
     */
    @GetMapping("/admin/users")
    public String listUsers(@RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "message", required = false) String message,
                            Model model) {
        int currentPage = page < 1 ? 1 : page;
        int totalUsers = userService.countTotalUsers();
        int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        List<User_24110028> userList = userService.findWithPagination(currentPage, PAGE_SIZE);

        if ("create_success".equals(message)) {
            model.addAttribute("successMessage", "Thêm người dùng mới thành công!");
        } else if ("update_success".equals(message)) {
            model.addAttribute("successMessage", "Cập nhật thông tin người dùng thành công!");
        } else if ("delete_success".equals(message)) {
            model.addAttribute("successMessage", "Xóa người dùng thành công!");
        } else if ("delete_self_error".equals(message)) {
            model.addAttribute("errorMessage", "Không thể tự xóa tài khoản của chính bạn khi đang đăng nhập!");
        }

        model.addAttribute("userList", userList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("pageSize", PAGE_SIZE);

        return "admin/user-list";
    }

    /**
     * Hiển thị Form Thêm User mới
     */
    @GetMapping("/admin/users/create")
    public String showCreateForm(Model model) {
        model.addAttribute("mode", "create");
        return "admin/user-form";
    }

    /**
     * Xử lý Thêm User mới
     */
    @PostMapping("/admin/users/create")
    public String handleCreateUser(@RequestParam(value = "username", required = false) String username,
                                   @RequestParam(value = "password", required = false) String password,
                                   @RequestParam(value = "fullname", required = false) String fullname,
                                   @RequestParam(value = "email", required = false) String email,
                                   @RequestParam(value = "phone", required = false) String phone,
                                   @RequestParam(value = "admin", defaultValue = "false") boolean admin,
                                   @RequestParam(value = "active", defaultValue = "false") boolean active,
                                   @RequestParam(value = "images", required = false) String images,
                                   Model model) {
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            fullname == null || fullname.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            model.addAttribute("errorMessage", "Vui lòng nhập đầy đủ các trường bắt buộc!");
            model.addAttribute("mode", "create");
            return "admin/user-form";
        }

        username = username.trim();
        if (userService.existsByUsername(username)) {
            model.addAttribute("errorMessage", "Tên đăng nhập '" + username + "' đã tồn tại!");
            model.addAttribute("mode", "create");
            return "admin/user-form";
        }

        User_24110028 user = new User_24110028(username, password.trim(), phone != null ? phone.trim() : "",
                fullname.trim(), email.trim(), admin, active, images);
        boolean success = userService.create(user);
        if (success) {
            return "redirect:/admin/users?message=create_success";
        } else {
            model.addAttribute("errorMessage", "Không thể thêm người dùng vào cơ sở dữ liệu!");
            model.addAttribute("mode", "create");
            return "admin/user-form";
        }
    }

    /**
     * Hiển thị Form Sửa User
     */
    @GetMapping("/admin/users/edit")
    public String showEditForm(@RequestParam(value = "username", required = false) String username,
                               Model model) {
        if (username == null || username.trim().isEmpty()) {
            return "redirect:/admin/users";
        }

        User_24110028 user = userService.findByUsername(username.trim());
        if (user == null) {
            return "redirect:/admin/users";
        }

        model.addAttribute("mode", "edit");
        model.addAttribute("user", user);
        return "admin/user-form";
    }

    /**
     * Xử lý Cập nhật User
     */
    @PostMapping("/admin/users/edit")
    public String handleEditUser(@RequestParam(value = "username", required = false) String username,
                                 @RequestParam(value = "password", required = false) String password,
                                 @RequestParam(value = "fullname", required = false) String fullname,
                                 @RequestParam(value = "email", required = false) String email,
                                 @RequestParam(value = "phone", required = false) String phone,
                                 @RequestParam(value = "admin", defaultValue = "false") boolean admin,
                                 @RequestParam(value = "active", defaultValue = "false") boolean active,
                                 @RequestParam(value = "images", required = false) String images,
                                 Model model) {
        if (username == null || username.trim().isEmpty()) {
            return "redirect:/admin/users";
        }

        User_24110028 existingUser = userService.findByUsername(username.trim());
        if (existingUser == null) {
            return "redirect:/admin/users";
        }

        if (password != null && !password.trim().isEmpty()) {
            existingUser.setPassword(password.trim());
        }
        if (fullname != null && !fullname.trim().isEmpty()) {
            existingUser.setFullname(fullname.trim());
        }
        if (email != null && !email.trim().isEmpty()) {
            existingUser.setEmail(email.trim());
        }
        existingUser.setPhone(phone != null ? phone.trim() : "");
        existingUser.setAdmin(admin);
        existingUser.setActive(active);
        if (images != null && !images.trim().isEmpty()) {
            existingUser.setImages(images.trim());
        }

        boolean success = userService.update(existingUser);
        if (success) {
            return "redirect:/admin/users?message=update_success";
        } else {
            model.addAttribute("errorMessage", "Cập nhật người dùng thất bại!");
            model.addAttribute("mode", "edit");
            model.addAttribute("user", existingUser);
            return "admin/user-form";
        }
    }

    /**
     * Xử lý Xóa User
     */
    @GetMapping("/admin/users/delete")
    public String handleDeleteUser(@RequestParam(value = "username", required = false) String username,
                                   HttpSession session) {
        if (username != null && !username.trim().isEmpty()) {
            username = username.trim();
            User_24110028 currentUser = (session != null) ? (User_24110028) session.getAttribute("currentUser") : null;

            if (currentUser != null && username.equalsIgnoreCase(currentUser.getUsername())) {
                return "redirect:/admin/users?message=delete_self_error";
            }

            userService.delete(username);
            return "redirect:/admin/users?message=delete_success";
        }
        return "redirect:/admin/users";
    }
}
