package vn.edu.ute.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.ute.controller.OrderHistoryController_24110028;
import vn.edu.ute.model.Order_24110028;
import vn.edu.ute.service.IOrderService_24110028;

import java.util.List;

@Controller
@RequestMapping("/admin/orders")
public class AdminOrderController_24110028 {

    @Autowired
    private IOrderService_24110028 orderService;

    @GetMapping
    public String listOrders(@RequestParam(value = "status", required = false) String status,
                             Model model) {
        List<Order_24110028> orders = orderService.findAll(status);
        model.addAttribute("orders", orders);
        model.addAttribute("statuses", OrderHistoryController_24110028.ORDER_STATUSES);
        model.addAttribute("selectedStatus", status != null ? status : "ALL");
        return "admin/order-list";
    }

    @PostMapping("/update-status")
    public String updateOrderStatus(@RequestParam("orderId") int orderId,
                                    @RequestParam("newStatus") String newStatus,
                                    @RequestParam(value = "returnStatus", required = false) String returnStatus,
                                    RedirectAttributes redirectAttributes) {
        boolean updated = orderService.updateStatus(orderId, newStatus);
        if (updated) {
            redirectAttributes.addFlashAttribute("successMessage", "Đã cập nhật trạng thái đơn hàng #" + orderId + " thành: " + newStatus);
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Cập nhật trạng thái thất bại!");
        }

        if (returnStatus != null && !returnStatus.isEmpty()) {
            return "redirect:/admin/orders?status=" + returnStatus;
        }
        return "redirect:/admin/orders";
    }
}
