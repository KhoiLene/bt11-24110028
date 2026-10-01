package vn.edu.ute.dao;

import vn.edu.ute.model.Share_24110028;
import java.util.List;

public interface IShareDAO_24110028 {
    int countByVideoId(String videoId);
    List<Share_24110028> findByVideoId(String videoId);
    boolean insert(Share_24110028 share);
}
