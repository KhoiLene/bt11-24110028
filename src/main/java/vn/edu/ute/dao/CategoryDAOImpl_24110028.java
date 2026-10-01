package vn.edu.ute.dao;

import vn.edu.ute.model.Category_24110028;
import vn.edu.ute.model.CategoryDTO_24110028;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class CategoryDAOImpl_24110028 implements ICategoryDAO_24110028 {

    @Override
    public List<Category_24110028> findAll() {
        List<Category_24110028> list = new ArrayList<>();
        String sql = "SELECT CategoryId, Categoryname, Categorycode, Images, Status FROM Category ORDER BY CategoryId ASC";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Category_24110028(
                        rs.getInt("CategoryId"),
                        rs.getString("Categoryname"),
                        rs.getString("Categorycode"),
                        rs.getString("Images"),
                        rs.getBoolean("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Category_24110028 findById(int id) {
        String sql = "SELECT CategoryId, Categoryname, Categorycode, Images, Status FROM Category WHERE CategoryId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Category_24110028(
                            rs.getInt("CategoryId"),
                            rs.getString("Categoryname"),
                            rs.getString("Categorycode"),
                            rs.getString("Images"),
                            rs.getBoolean("Status")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<CategoryDTO_24110028> findAllWithVideoCount() {
        List<CategoryDTO_24110028> list = new ArrayList<>();
        String sql = "SELECT c.CategoryId, c.Categoryname, c.Categorycode, c.Images, c.Status, "
                   + "       COUNT(v.VideoId) AS VideoCount "
                   + "FROM Category c "
                   + "LEFT JOIN Videos v ON c.CategoryId = v.CategoryId AND v.Active = 1 "
                   + "GROUP BY c.CategoryId, c.Categoryname, c.Categorycode, c.Images, c.Status "
                   + "ORDER BY c.CategoryId ASC";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category_24110028 c = new Category_24110028(
                        rs.getInt("CategoryId"),
                        rs.getString("Categoryname"),
                        rs.getString("Categorycode"),
                        rs.getString("Images"),
                        rs.getBoolean("Status")
                );
                int count = rs.getInt("VideoCount");
                list.add(new CategoryDTO_24110028(c, count));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countVideosByCategoryId(int categoryId) {
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
    public boolean insert(Category_24110028 category) {
        String sql = "INSERT INTO Category (Categoryname, Categorycode, Images, Status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getCategoryname());
            ps.setString(2, category.getCategorycode());
            ps.setString(3, category.getImages());
            ps.setBoolean(4, category.isStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Category_24110028 category) {
        String sql = "UPDATE Category SET Categoryname = ?, Categorycode = ?, Images = ?, Status = ? WHERE CategoryId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getCategoryname());
            ps.setString(2, category.getCategorycode());
            ps.setString(3, category.getImages());
            ps.setBoolean(4, category.isStatus());
            ps.setInt(5, category.getCategoryId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Category WHERE CategoryId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
