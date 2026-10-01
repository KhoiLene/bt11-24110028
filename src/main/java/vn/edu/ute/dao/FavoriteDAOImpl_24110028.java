package vn.edu.ute.dao;

import vn.edu.ute.model.Favorite_24110028;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class FavoriteDAOImpl_24110028 implements IFavoriteDAO_24110028 {

    @Override
    public int countByVideoId(String videoId) {
        String sql = "SELECT COUNT(*) FROM Favorites WHERE VideoId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, videoId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Favorite_24110028> findByVideoId(String videoId) {
        List<Favorite_24110028> list = new ArrayList<>();
        String sql = "SELECT FavoriteId, LikedDate, VideoId, Username FROM Favorites WHERE VideoId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, videoId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Favorite_24110028(
                            rs.getInt("FavoriteId"),
                            rs.getDate("LikedDate"),
                            rs.getString("VideoId"),
                            rs.getString("Username")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean isLiked(String username, String videoId) {
        String sql = "SELECT 1 FROM Favorites WHERE Username = ? AND VideoId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, videoId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean insert(Favorite_24110028 favorite) {
        String sql = "INSERT INTO Favorites (LikedDate, VideoId, Username) VALUES (?, ?, ?)";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, new java.sql.Date(favorite.getLikedDate().getTime()));
            ps.setString(2, favorite.getVideoId());
            ps.setString(3, favorite.getUsername());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(String username, String videoId) {
        String sql = "DELETE FROM Favorites WHERE Username = ? AND VideoId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, videoId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
