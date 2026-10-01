package vn.edu.ute.dao;

import vn.edu.ute.model.Video_24110028;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class VideoDAOImpl_24110028 implements IVideoDAO_24110028 {

    private Video_24110028 mapVideo(ResultSet rs) throws SQLException {
        Integer catId = rs.getObject("CategoryId") != null ? rs.getInt("CategoryId") : null;
        BigDecimal price = rs.getBigDecimal("Price");
        return new Video_24110028(
                rs.getString("VideoId"),
                rs.getString("Title"),
                rs.getString("Poster"),
                rs.getInt("Views"),
                rs.getString("Description"),
                rs.getBoolean("Active"),
                catId,
                price != null ? price : BigDecimal.ZERO
        );
    }

    @Override
    public Video_24110028 findById(String id) {
        String sql = "SELECT VideoId, Title, Poster, Views, Description, Active, CategoryId, Price FROM Videos WHERE VideoId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapVideo(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Video_24110028> findAll() {
        List<Video_24110028> list = new ArrayList<>();
        String sql = "SELECT VideoId, Title, Poster, Views, Description, Active, CategoryId, Price FROM Videos WHERE Active = 1 ORDER BY VideoId ASC";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapVideo(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Video_24110028> findByCategoryId(int categoryId) {
        List<Video_24110028> list = new ArrayList<>();
        String sql = "SELECT VideoId, Title, Poster, Views, Description, Active, CategoryId, Price FROM Videos WHERE CategoryId = ? AND Active = 1 ORDER BY VideoId ASC";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapVideo(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Video_24110028> findByCategoryIdWithPagination(int categoryId, int page, int pageSize) {
        List<Video_24110028> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT VideoId, Title, Poster, Views, Description, Active, CategoryId, Price "
                   + "FROM Videos WHERE CategoryId = ? AND Active = 1 "
                   + "ORDER BY VideoId ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapVideo(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countByCategoryId(int categoryId) {
        String sql = "SELECT COUNT(*) FROM Videos WHERE CategoryId = ? AND Active = 1";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
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
    public List<Video_24110028> findAllWithPagination(int page, int pageSize) {
        List<Video_24110028> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT VideoId, Title, Poster, Views, Description, Active, CategoryId, Price "
                   + "FROM Videos WHERE Active = 1 "
                   + "ORDER BY VideoId ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapVideo(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countTotalVideos() {
        String sql = "SELECT COUNT(*) FROM Videos WHERE Active = 1";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public void incrementViews(String videoId) {
        String sql = "UPDATE Videos SET Views = Views + 1 WHERE VideoId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, videoId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean insert(Video_24110028 video) {
        String sql = "INSERT INTO Videos (VideoId, Title, Poster, Views, Description, Active, CategoryId, Price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, video.getVideoId());
            ps.setString(2, video.getTitle());
            ps.setString(3, video.getPoster());
            ps.setInt(4, video.getViews());
            ps.setString(5, video.getDescription());
            ps.setBoolean(6, video.isActive());
            if (video.getCategoryId() != null) {
                ps.setInt(7, video.getCategoryId());
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }
            ps.setBigDecimal(8, video.getPrice());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Video_24110028 video) {
        String sql = "UPDATE Videos SET Title = ?, Poster = ?, Views = ?, Description = ?, Active = ?, CategoryId = ?, Price = ? WHERE VideoId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, video.getTitle());
            ps.setString(2, video.getPoster());
            ps.setInt(3, video.getViews());
            ps.setString(4, video.getDescription());
            ps.setBoolean(5, video.isActive());
            if (video.getCategoryId() != null) {
                ps.setInt(6, video.getCategoryId());
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }
            ps.setBigDecimal(7, video.getPrice());
            ps.setString(8, video.getVideoId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(String id) {
        String sql = "DELETE FROM Videos WHERE VideoId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
