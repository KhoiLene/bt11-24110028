package vn.edu.ute.dao;

import vn.edu.ute.model.Favorite_24110028;
import java.util.List;

public interface IFavoriteDAO_24110028 {
    int countByVideoId(String videoId);
    List<Favorite_24110028> findByVideoId(String videoId);
    boolean isLiked(String username, String videoId);
    boolean insert(Favorite_24110028 favorite);
    boolean delete(String username, String videoId);
}
