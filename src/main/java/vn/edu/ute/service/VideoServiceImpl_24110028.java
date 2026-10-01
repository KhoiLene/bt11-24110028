package vn.edu.ute.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.edu.ute.dao.ICategoryDAO_24110028;
import vn.edu.ute.dao.IFavoriteDAO_24110028;
import vn.edu.ute.dao.IShareDAO_24110028;
import vn.edu.ute.dao.IVideoDAO_24110028;
import vn.edu.ute.model.Category_24110028;
import vn.edu.ute.model.Video_24110028;
import vn.edu.ute.model.VideoDetailDTO_24110028;

import java.util.ArrayList;
import java.util.List;

@Service
public class VideoServiceImpl_24110028 implements IVideoService_24110028 {

    private final IVideoDAO_24110028 videoDAO;
    private final ICategoryDAO_24110028 categoryDAO;
    private final IShareDAO_24110028 shareDAO;
    private final IFavoriteDAO_24110028 favoriteDAO;

    @Autowired
    public VideoServiceImpl_24110028(IVideoDAO_24110028 videoDAO,
                                    ICategoryDAO_24110028 categoryDAO,
                                    IShareDAO_24110028 shareDAO,
                                    IFavoriteDAO_24110028 favoriteDAO) {
        this.videoDAO = videoDAO;
        this.categoryDAO = categoryDAO;
        this.shareDAO = shareDAO;
        this.favoriteDAO = favoriteDAO;
    }

    private VideoDetailDTO_24110028 buildDTO(Video_24110028 video) {
        if (video == null) return null;
        String catName = "Chưa phân loại";
        if (video.getCategoryId() != null) {
            Category_24110028 c = categoryDAO.findById(video.getCategoryId());
            if (c != null) {
                catName = c.getCategoryname();
            }
        }
        int shareCount = shareDAO.countByVideoId(video.getVideoId());
        int likeCount = favoriteDAO.countByVideoId(video.getVideoId());
        return new VideoDetailDTO_24110028(video, catName, shareCount, likeCount);
    }

    @Override
    public VideoDetailDTO_24110028 getVideoDetail(String videoId) {
        videoDAO.incrementViews(videoId);
        Video_24110028 video = videoDAO.findById(videoId);
        return buildDTO(video);
    }

    @Override
    public List<VideoDetailDTO_24110028> getVideosByCategoryIdWithPagination(int categoryId, int page, int pageSize) {
        if (page < 1) page = 1;
        List<Video_24110028> videos = videoDAO.findByCategoryIdWithPagination(categoryId, page, pageSize);
        List<VideoDetailDTO_24110028> dtos = new ArrayList<>();
        for (Video_24110028 v : videos) {
            dtos.add(buildDTO(v));
        }
        return dtos;
    }

    @Override
    public int countVideosByCategoryId(int categoryId) {
        return videoDAO.countByCategoryId(categoryId);
    }

    @Override
    public int getTotalPagesByCategory(int categoryId, int pageSize) {
        int total = videoDAO.countByCategoryId(categoryId);
        return (int) Math.ceil((double) total / pageSize);
    }

    @Override
    public List<VideoDetailDTO_24110028> getAllVideosWithPagination(int page, int pageSize) {
        if (page < 1) page = 1;
        List<Video_24110028> videos = videoDAO.findAllWithPagination(page, pageSize);
        List<VideoDetailDTO_24110028> dtos = new ArrayList<>();
        for (Video_24110028 v : videos) {
            dtos.add(buildDTO(v));
        }
        return dtos;
    }

    @Override
    public int countTotalVideos() {
        return videoDAO.countTotalVideos();
    }

    @Override
    public int getTotalPagesAll(int pageSize) {
        int total = videoDAO.countTotalVideos();
        return (int) Math.ceil((double) total / pageSize);
    }

    @Override
    public List<Video_24110028> findAll() {
        return videoDAO.findAll();
    }

    @Override
    public Video_24110028 findById(String id) {
        return videoDAO.findById(id);
    }

    @Override
    public boolean insert(Video_24110028 video) {
        return videoDAO.insert(video);
    }

    @Override
    public boolean update(Video_24110028 video) {
        return videoDAO.update(video);
    }

    @Override
    public boolean delete(String id) {
        return videoDAO.delete(id);
    }
}
