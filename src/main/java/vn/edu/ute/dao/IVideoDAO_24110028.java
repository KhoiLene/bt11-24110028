package vn.edu.ute.dao;

import vn.edu.ute.model.Video_24110028;
import java.util.List;

public interface IVideoDAO_24110028 {
    Video_24110028 findById(String id);
    List<Video_24110028> findAll();
    List<Video_24110028> findByCategoryId(int categoryId);
    
    // Câu 5: Phân trang 3 video / trang theo từng category
    List<Video_24110028> findByCategoryIdWithPagination(int categoryId, int page, int pageSize);
    int countByCategoryId(int categoryId);
    
    // Phân trang toàn bộ video
    List<Video_24110028> findAllWithPagination(int page, int pageSize);
    int countTotalVideos();

    // Câu 4: Tăng số lượt view khi xem chi tiết video
    void incrementViews(String videoId);

    boolean insert(Video_24110028 video);
    boolean update(Video_24110028 video);
    boolean delete(String id);
}
