package vn.edu.ute.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.edu.ute.service.ICategoryService_24110028;
import vn.edu.ute.service.IUserService_24110028;
import vn.edu.ute.service.IVideoService_24110028;

/**
 * Controller Trang Chủ Quản Trị Admin - MSSV: 24110028
 */
@Controller
public class AdminHomeController_24110028 {

    private final IUserService_24110028 userService;
    private final IVideoService_24110028 videoService;
    private final ICategoryService_24110028 categoryService;
    private final vn.edu.ute.service.IOrderService_24110028 orderService;

    @Autowired
    public AdminHomeController_24110028(IUserService_24110028 userService,
                                       IVideoService_24110028 videoService,
                                       ICategoryService_24110028 categoryService,
                                       vn.edu.ute.service.IOrderService_24110028 orderService) {
        this.userService = userService;
        this.videoService = videoService;
        this.categoryService = categoryService;
        this.orderService = orderService;
    }

    @GetMapping({"/admin", "/admin/home"})
    public String adminHome(Model model) {
        int totalUsers = userService.countTotalUsers();
        int totalVideos = videoService.countTotalVideos();
        int totalCategories = categoryService.findAll().size();
        int totalOrders = orderService.countTotalOrders();

        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalVideos", totalVideos);
        model.addAttribute("totalCategories", totalCategories);
        model.addAttribute("totalOrders", totalOrders);

        return "admin/home";
    }
}
