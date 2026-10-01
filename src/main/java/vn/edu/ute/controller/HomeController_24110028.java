package vn.edu.ute.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.edu.ute.model.CategoryDTO_24110028;
import vn.edu.ute.model.VideoDetailDTO_24110028;
import vn.edu.ute.service.ICategoryService_24110028;
import vn.edu.ute.service.IVideoService_24110028;

import java.util.List;

/**
 * Controller Trang Chủ - MSSV: 24110028
 */
@Controller
public class HomeController_24110028 {

    private final ICategoryService_24110028 categoryService;
    private final IVideoService_24110028 videoService;

    @Autowired
    public HomeController_24110028(ICategoryService_24110028 categoryService,
                                  IVideoService_24110028 videoService) {
        this.categoryService = categoryService;
        this.videoService = videoService;
    }

    @GetMapping({"/", "/home"})
    public String home(Model model) {
        List<CategoryDTO_24110028> categoriesWithCount = categoryService.findAllWithVideoCount();
        List<VideoDetailDTO_24110028> featuredVideos = videoService.getAllVideosWithPagination(1, 6);

        model.addAttribute("categoriesWithCount", categoriesWithCount);
        model.addAttribute("featuredVideos", featuredVideos);
        return "web/home";
    }
}
