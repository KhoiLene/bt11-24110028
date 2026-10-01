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
import vn.edu.ute.model.Cart_24110028;
import vn.edu.ute.model.Video_24110028;
import vn.edu.ute.service.IVideoService_24110028;

@Controller
@RequestMapping("/cart")
public class CartController_24110028 {

    @Autowired
    private IVideoService_24110028 videoService;

    private Cart_24110028 getCartFromSession(HttpSession session) {
        Cart_24110028 cart = (Cart_24110028) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart_24110028();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @GetMapping
    public String showCart(HttpSession session, Model model) {
        Cart_24110028 cart = getCartFromSession(session);
        model.addAttribute("cart", cart);
        return "web/cart";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam("videoId") String videoId,
                            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
                            @RequestParam(value = "redirect", required = false) String redirect,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        Video_24110028 video = videoService.findById(videoId);
        if (video != null) {
            Cart_24110028 cart = getCartFromSession(session);
            cart.addItem(video, quantity);
            redirectAttributes.addFlashAttribute("successMessage", "Đã thêm sản phẩm \"" + video.getTitle() + "\" vào giỏ hàng!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sản phẩm!");
        }

        if (redirect != null && !redirect.trim().isEmpty()) {
            return "redirect:" + redirect;
        }
        return "redirect:/cart";
    }

    @PostMapping("/update")
    public String updateQuantity(@RequestParam("videoId") String videoId,
                                 @RequestParam("quantity") int quantity,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        Cart_24110028 cart = getCartFromSession(session);
        if (quantity < 1) {
            quantity = 1;
        } else if (quantity > 99) {
            quantity = 99;
            redirectAttributes.addFlashAttribute("warningMessage", "Số lượng sản phẩm tối đa là 99!");
        }
        cart.updateQuantity(videoId, quantity);
        return "redirect:/cart";
    }

    @GetMapping("/remove")
    public String removeItem(@RequestParam("videoId") String videoId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        Cart_24110028 cart = getCartFromSession(session);
        cart.removeItem(videoId);
        redirectAttributes.addFlashAttribute("successMessage", "Đã xóa sản phẩm khỏi giỏ hàng!");
        return "redirect:/cart";
    }

    @GetMapping("/clear")
    public String clearCart(HttpSession session,
                            RedirectAttributes redirectAttributes) {
        Cart_24110028 cart = getCartFromSession(session);
        cart.clear();
        redirectAttributes.addFlashAttribute("successMessage", "Đã xóa toàn bộ giỏ hàng!");
        return "redirect:/cart";
    }
}
