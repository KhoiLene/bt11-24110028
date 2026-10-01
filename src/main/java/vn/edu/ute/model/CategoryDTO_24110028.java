package vn.edu.ute.model;

import java.io.Serializable;

public class CategoryDTO_24110028 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Category_24110028 category;
    private int videoCount;

    public CategoryDTO_24110028() {
    }

    public CategoryDTO_24110028(Category_24110028 category, int videoCount) {
        this.category = category;
        this.videoCount = videoCount;
    }

    public Category_24110028 getCategory() {
        return category;
    }

    public void setCategory(Category_24110028 category) {
        this.category = category;
    }

    public int getVideoCount() {
        return videoCount;
    }

    public void setVideoCount(int videoCount) {
        this.videoCount = videoCount;
    }
}
