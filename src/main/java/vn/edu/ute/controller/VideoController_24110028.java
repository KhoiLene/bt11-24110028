package vn.edu.ute.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.ute.model.Category_24110028;
import vn.edu.ute.model.CategoryDTO_24110028;
import vn.edu.ute.model.VideoDetailDTO_24110028;
import vn.edu.ute.service.ICategoryService_24110028;
import vn.edu.ute.service.IVideoService_24110028;

import java.util.List;

/**
 * Controller Video - MSSV: 24110028
 * Xử lý Câu 4 (Chi tiết Video) và Câu 5 & 6 (Video theo Category, phân trang 3 video/trang, Category Name (Count))
 */
@Controller
public class VideoController_24110028 {

    private final IVideoService_24110028 videoService;
    private final ICategoryService_24110028 categoryService;

    private static final int PAGE_SIZE = 3; // Câu 5: Phân trang 3 video / trang

    @Autowired
    public VideoController_24110028(IVideoService_24110028 videoService,
                                   ICategoryService_24110028 categoryService) {
        this.videoService = videoService;
        this.categoryService = categoryService;
    }

    /**
     * Câu 4: Trang chi tiết 01 video
     */
    @GetMapping({"/video/detail", "/videos/detail"})
    public String videoDetail(@RequestParam(value = "id", required = false) String id, Model model) {
        if (id == null || id.trim().isEmpty()) {
            return "redirect:/videos";
        }

        VideoDetailDTO_24110028 detail = videoService.getVideoDetail(id.trim());
        if (detail == null) {
            return "redirect:/videos";
        }

        model.addAttribute("videoDetail", detail);
        return "web/video-detail";
    }

    /**
     * Câu 5 & Câu 6: Danh sách video theo Category + Phân trang 3 video/trang + Hiển thị số lượng
     */
    @GetMapping("/videos")
    public String videosByCategory(@RequestParam(value = "categoryId", required = false) Integer categoryId,
                                   @RequestParam(value = "page", defaultValue = "1") int page,
                                   Model model) {
        List<CategoryDTO_24110028> categoriesWithCount = categoryService.findAllWithVideoCount();
        model.addAttribute("categoriesWithCount", categoriesWithCount);

        if ((categoryId == null || categoryId == 0) && !categoriesWithCount.isEmpty()) {
            categoryId = categoriesWithCount.get(0).getCategory().getCategoryId();
        }

        int currentPage = page < 1 ? 1 : page;

        Category_24110028 selectedCategory = (categoryId != null) ? categoryService.findById(categoryId) : null;
        int totalVideos = (categoryId != null) ? videoService.countVideosByCategoryId(categoryId) : 0;
        int totalPages = (int) Math.ceil((double) totalVideos / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        List<VideoDetailDTO_24110028> videoList = (categoryId != null)
                ? videoService.getVideosByCategoryIdWithPagination(categoryId, currentPage, PAGE_SIZE)
                : List.of();

        model.addAttribute("selectedCategory", selectedCategory);
        model.addAttribute("selectedCategoryId", categoryId);
        model.addAttribute("videoList", videoList);
        model.addAttribute("totalVideos", totalVideos);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);

        return "web/videos";
    }
}
