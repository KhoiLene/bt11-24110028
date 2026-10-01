package vn.edu.ute.model;

import java.io.Serializable;

public class VideoDetailDTO_24110028 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Video_24110028 video;
    private String categoryName;
    private int shareCount;
    private int likeCount;

    public VideoDetailDTO_24110028() {
    }

    public VideoDetailDTO_24110028(Video_24110028 video, String categoryName, int shareCount, int likeCount) {
        this.video = video;
        this.categoryName = categoryName;
        this.shareCount = shareCount;
        this.likeCount = likeCount;
    }

    public Video_24110028 getVideo() {
        return video;
    }

    public void setVideo(Video_24110028 video) {
        this.video = video;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getShareCount() {
        return shareCount;
    }

    public void setShareCount(int shareCount) {
        this.shareCount = shareCount;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }
}
