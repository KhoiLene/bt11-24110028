package vn.edu.ute.service;

import vn.edu.ute.model.Video_24110028;
import vn.edu.ute.model.VideoDetailDTO_24110028;
import java.util.List;

public interface IVideoService_24110028 {
    // Câu 4: Chi tiết video
    VideoDetailDTO_24110028 getVideoDetail(String videoId);

    // Câu 5: Phân trang 3 video / trang theo từng category
    List<VideoDetailDTO_24110028> getVideosByCategoryIdWithPagination(int categoryId, int page, int pageSize);
    int countVideosByCategoryId(int categoryId);
    int getTotalPagesByCategory(int categoryId, int pageSize);

    // Phân trang tất cả video
    List<VideoDetailDTO_24110028> getAllVideosWithPagination(int page, int pageSize);
    int countTotalVideos();
    int getTotalPagesAll(int pageSize);

    List<Video_24110028> findAll();
    Video_24110028 findById(String id);
    boolean insert(Video_24110028 video);
    boolean update(Video_24110028 video);
    boolean delete(String id);
}
