package vn.edu.ute.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.ute.model.Order_24110028;
import vn.edu.ute.model.User_24110028;
import vn.edu.ute.service.IOrderService_24110028;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrderHistoryController_24110028 {

    @Autowired
    private IOrderService_24110028 orderService;

    public static final List<String> ORDER_STATUSES = Arrays.asList(
            "Đơn hàng mới",
            "Đã xác nhận",
            "Chuẩn bị hàng",
            "Vận chuyển",
            "Giao hàng",
            "Đã giao",
            "Đơn hàng hủy",
            "Đơn hàng hoàn"
    );

    @GetMapping
    public String showOrderHistory(@RequestParam(value = "status", required = false) String status,
                                   HttpSession session,
                                   Model model,
                                   RedirectAttributes redirectAttributes) {
        User_24110028 user = (User_24110028) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng đăng nhập để xem lịch sử đơn hàng!");
            return "redirect:/login";
        }

        List<Order_24110028> orders = orderService.findByUsername(user.getUsername(), status);

        model.addAttribute("orders", orders);
        model.addAttribute("statuses", ORDER_STATUSES);
        model.addAttribute("selectedStatus", status != null ? status : "ALL");
        return "web/order-history";
    }
}
