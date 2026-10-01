package vn.edu.ute.dao;

import vn.edu.ute.model.User_24110028;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class UserDAOImpl_24110028 implements IUserDAO_24110028 {

    private User_24110028 mapUser(ResultSet rs) throws SQLException {
        return new User_24110028(
                rs.getString("Username"),
                rs.getString("Password"),
                rs.getString("Phone"),
                rs.getString("Fullname"),
                rs.getString("Email"),
                rs.getBoolean("Admin"),
                rs.getBoolean("Active"),
                rs.getString("Images")
        );
    }

    @Override
    public User_24110028 findByUsername(String username) {
        String sql = "SELECT Username, Password, Phone, Fullname, Email, Admin, Active, Images FROM Users WHERE Username = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User_24110028 findByUsernameAndPassword(String username, String password) {
        String sql = "SELECT Username, Password, Phone, Fullname, Email, Admin, Active, Images FROM Users WHERE Username = ? AND Password = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(User_24110028 user) {
        String sql = "INSERT INTO Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getFullname());
            ps.setString(5, user.getEmail());
            ps.setBoolean(6, user.isAdmin());
            ps.setBoolean(7, user.isActive());
            ps.setString(8, user.getImages());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(User_24110028 user) {
        String sql = "UPDATE Users SET Password = ?, Phone = ?, Fullname = ?, Email = ?, Admin = ?, Active = ?, Images = ? WHERE Username = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getPassword());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setBoolean(5, user.isAdmin());
            ps.setBoolean(6, user.isActive());
            ps.setString(7, user.getImages());
            ps.setString(8, user.getUsername());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(String username) {
        String sql = "DELETE FROM Users WHERE Username = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean activateUser(String username) {
        String sql = "UPDATE Users SET Active = 1 WHERE Username = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean existsByUsername(String username) {
        String sql = "SELECT 1 FROM Users WHERE Username = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean existsByEmail(String email) {
        String sql = "SELECT 1 FROM Users WHERE Email = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User_24110028> findAll() {
        List<User_24110028> list = new ArrayList<>();
        String sql = "SELECT Username, Password, Phone, Fullname, Email, Admin, Active, Images FROM Users ORDER BY Username ASC";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<User_24110028> findWithPagination(int page, int pageSize) {
        List<User_24110028> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT Username, Password, Phone, Fullname, Email, Admin, Active, Images "
                   + "FROM Users ORDER BY Username ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countTotalUsers() {
        String sql = "SELECT COUNT(*) FROM Users";
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
}
