package vn.edu.ute.dao;

import vn.edu.ute.model.Share_24110028;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class ShareDAOImpl_24110028 implements IShareDAO_24110028 {

    @Override
    public int countByVideoId(String videoId) {
        String sql = "SELECT COUNT(*) FROM Shares WHERE VideoId = ?";
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
    public List<Share_24110028> findByVideoId(String videoId) {
        List<Share_24110028> list = new ArrayList<>();
        String sql = "SELECT ShareId, Emails, SharedDate, Username, VideoId FROM Shares WHERE VideoId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, videoId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Share_24110028(
                            rs.getInt("ShareId"),
                            rs.getString("Emails"),
                            rs.getDate("SharedDate"),
                            rs.getString("Username"),
                            rs.getString("VideoId")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean insert(Share_24110028 share) {
        String sql = "INSERT INTO Shares (Emails, SharedDate, Username, VideoId) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, share.getEmails());
            ps.setDate(2, new java.sql.Date(share.getSharedDate().getTime()));
            ps.setString(3, share.getUsername());
            ps.setString(4, share.getVideoId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
