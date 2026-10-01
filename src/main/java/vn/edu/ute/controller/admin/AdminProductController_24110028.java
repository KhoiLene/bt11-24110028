package vn.edu.ute.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.ute.model.Category_24110028;
import vn.edu.ute.model.Video_24110028;
import vn.edu.ute.service.ICategoryService_24110028;
import vn.edu.ute.service.IVideoService_24110028;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/admin/products")
public class AdminProductController_24110028 {

    @Autowired
    private IVideoService_24110028 videoService;

    @Autowired
    private ICategoryService_24110028 categoryService;

    @GetMapping
    public String listProducts(Model model) {
        List<Video_24110028> products = videoService.findAll();
        model.addAttribute("products", products);
        return "admin/product-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        Video_24110028 video = new Video_24110028();
        video.setActive(true);
        video.setPrice(BigDecimal.ZERO);
        model.addAttribute("product", video);
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("isEdit", false);
        return "admin/product-form";
    }

    @PostMapping("/add")
    public String addProduct(@RequestParam("videoId") String videoId,
                             @RequestParam("title") String title,
                             @RequestParam("poster") String poster,
                             @RequestParam(value = "description", required = false) String description,
                             @RequestParam(value = "categoryId", required = false) Integer categoryId,
                             @RequestParam(value = "price", defaultValue = "0") BigDecimal price,
                             @RequestParam(value = "active", defaultValue = "false") boolean active,
                             RedirectAttributes redirectAttributes) {
        if (videoId == null || videoId.trim().isEmpty() || title == null || title.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Mã sản phẩm và Tên sản phẩm không được để trống!");
            return "redirect:/admin/products/add";
        }

        Video_24110028 existing = videoService.findById(videoId.trim());
        if (existing != null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Mã sản phẩm đã tồn tại!");
            return "redirect:/admin/products/add";
        }

        Video_24110028 video = new Video_24110028(
                videoId.trim(),
                title.trim(),
                poster != null ? poster.trim() : "",
                0,
                description != null ? description.trim() : "",
                active,
                categoryId,
                price
        );

        boolean success = videoService.insert(video);
        if (success) {
            redirectAttributes.addFlashAttribute("successMessage", "Đã thêm sản phẩm mới thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Thêm sản phẩm thất bại!");
        }
        return "redirect:/admin/products";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") String id, Model model, RedirectAttributes redirectAttributes) {
        Video_24110028 video = videoService.findById(id);
        if (video == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sản phẩm!");
            return "redirect:/admin/products";
        }
        model.addAttribute("product", video);
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("isEdit", true);
        return "admin/product-form";
    }

    @PostMapping("/edit")
    public String editProduct(@RequestParam("videoId") String videoId,
                              @RequestParam("title") String title,
                              @RequestParam("poster") String poster,
                              @RequestParam(value = "description", required = false) String description,
                              @RequestParam(value = "categoryId", required = false) Integer categoryId,
                              @RequestParam(value = "price", defaultValue = "0") BigDecimal price,
                              @RequestParam(value = "active", defaultValue = "false") boolean active,
                              RedirectAttributes redirectAttributes) {
        Video_24110028 video = videoService.findById(videoId);
        if (video == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sản phẩm!");
            return "redirect:/admin/products";
        }

        video.setTitle(title.trim());
        video.setPoster(poster != null ? poster.trim() : "");
        video.setDescription(description != null ? description.trim() : "");
        video.setCategoryId(categoryId);
        video.setPrice(price);
        video.setActive(active);

        boolean success = videoService.update(video);
        if (success) {
            redirectAttributes.addFlashAttribute("successMessage", "Đã cập nhật thông tin sản phẩm thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Cập nhật sản phẩm thất bại!");
        }
        return "redirect:/admin/products";
    }

    @GetMapping("/delete")
    public String deleteProduct(@RequestParam("id") String id, RedirectAttributes redirectAttributes) {
        boolean success = videoService.delete(id);
        if (success) {
            redirectAttributes.addFlashAttribute("successMessage", "Đã xóa sản phẩm thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa sản phẩm do đã có đơn hàng hoặc dữ liệu liên quan!");
        }
        return "redirect:/admin/products";
    }
}
