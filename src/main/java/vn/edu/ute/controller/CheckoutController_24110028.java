package vn.edu.ute.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.ute.model.CartItem_24110028;
import vn.edu.ute.model.Cart_24110028;
import vn.edu.ute.model.OrderDetail_24110028;
import vn.edu.ute.model.Order_24110028;
import vn.edu.ute.model.User_24110028;
import vn.edu.ute.service.IOrderService_24110028;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/checkout")
public class CheckoutController_24110028 {

    @Autowired
    private IOrderService_24110028 orderService;

    @GetMapping
    public String showCheckout(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        Cart_24110028 cart = (Cart_24110028) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Giỏ hàng của bạn đang trống! Vui lòng chọn sản phẩm trước khi thanh toán.");
            return "redirect:/cart";
        }

        User_24110028 user = (User_24110028) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("defaultName", user.getFullname());
            model.addAttribute("defaultEmail", user.getEmail());
            model.addAttribute("defaultPhone", user.getPhone());
        }

        model.addAttribute("cart", cart);
        return "web/checkout";
    }

    @PostMapping
    public String processCheckout(@RequestParam("customerName") String customerName,
                                  @RequestParam("phone") String phone,
                                  @RequestParam("address") String address,
                                  @RequestParam(value = "note", required = false) String note,
                                  @RequestParam(value = "paymentMethod", defaultValue = "COD") String paymentMethod,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        Cart_24110028 cart = (Cart_24110028) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Giỏ hàng trống!");
            return "redirect:/cart";
        }

        User_24110028 user = (User_24110028) session.getAttribute("user");
        String username = user != null ? user.getUsername() : null;

        Order_24110028 order = new Order_24110028();
        order.setUsername(username);
        order.setCustomerName(customerName.trim());
        order.setPhone(phone.trim());
        order.setAddress(address.trim());
        order.setNote(note != null ? note.trim() : "");
        order.setTotalAmount(cart.getTotalAmount());
        order.setPaymentMethod("COD");
        order.setStatus("Đơn hàng mới");

        List<OrderDetail_24110028> details = new ArrayList<>();
        for (CartItem_24110028 item : cart.getItems()) {
            OrderDetail_24110028 d = new OrderDetail_24110028();
            d.setVideoId(item.getVideo().getVideoId());
            d.setPrice(item.getVideo().getPrice());
            d.setQuantity(item.getQuantity());
            d.setAmount(item.getAmount());
            details.add(d);
        }
        order.setDetails(details);

        int orderId = orderService.createOrder(order);
        if (orderId > 0) {
            cart.clear();
            redirectAttributes.addFlashAttribute("successMessage", "Đặt hàng thành công! Mã đơn hàng #" + orderId);
            return "redirect:/checkout/success?orderId=" + orderId;
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Đã có lỗi xảy ra khi tạo đơn hàng. Vui lòng thử lại!");
            return "redirect:/checkout";
        }
    }

    @GetMapping("/success")
    public String showSuccess(@RequestParam("orderId") int orderId, Model model) {
        Order_24110028 order = orderService.findById(orderId);
        if (order == null) {
            return "redirect:/";
        }
        model.addAttribute("order", order);
        return "web/checkout-success";
    }
}
