package vn.edu.ute.dao;

import org.springframework.stereotype.Repository;
import vn.edu.ute.model.OrderDetail_24110028;
import vn.edu.ute.model.Order_24110028;
import vn.edu.ute.model.Video_24110028;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class OrderDAOImpl_24110028 implements IOrderDAO_24110028 {

    @Override
    public int createOrder(Order_24110028 order) {
        String insertOrderSql = "INSERT INTO Orders (Username, CustomerName, Phone, Address, Note, TotalAmount, PaymentMethod, Status, CreatedDate) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
        String insertDetailSql = "INSERT INTO OrderDetails (OrderId, VideoId, Price, Quantity, Amount) VALUES (?, ?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = DBContext_24110028.getConnection();
            conn.setAutoCommit(false);

            int orderId = 0;
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, order.getUsername());
                ps.setString(2, order.getCustomerName());
                ps.setString(3, order.getPhone());
                ps.setString(4, order.getAddress());
                ps.setString(5, order.getNote());
                ps.setBigDecimal(6, order.getTotalAmount());
                ps.setString(7, order.getPaymentMethod() != null ? order.getPaymentMethod() : "COD");
                ps.setString(8, order.getStatus() != null ? order.getStatus() : "Đơn hàng mới");

                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }

            if (orderId > 0 && order.getDetails() != null) {
                try (PreparedStatement psDetail = conn.prepareStatement(insertDetailSql)) {
                    for (OrderDetail_24110028 d : order.getDetails()) {
                        psDetail.setInt(1, orderId);
                        psDetail.setString(2, d.getVideoId());
                        psDetail.setBigDecimal(3, d.getPrice());
                        psDetail.setInt(4, d.getQuantity());
                        psDetail.setBigDecimal(5, d.getAmount());
                        psDetail.addBatch();
                    }
                    psDetail.executeBatch();
                }
            }

            conn.commit();
            return orderId;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }

    @Override
    public Order_24110028 findById(int orderId) {
        String sql = "SELECT OrderId, Username, CustomerName, Phone, Address, Note, TotalAmount, PaymentMethod, Status, CreatedDate FROM Orders WHERE OrderId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order_24110028 order = mapOrder(rs);
                    order.setDetails(findDetailsByOrderId(conn, order.getOrderId()));
                    return order;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Order_24110028> findByUsername(String username, String status) {
        List<Order_24110028> list = new ArrayList<>();
        boolean hasStatusFilter = status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("ALL") && !status.equalsIgnoreCase("Tất cả");

        String sql = "SELECT OrderId, Username, CustomerName, Phone, Address, Note, TotalAmount, PaymentMethod, Status, CreatedDate FROM Orders WHERE Username = ?";
        if (hasStatusFilter) {
            sql += " AND Status = ?";
        }
        sql += " ORDER BY OrderId DESC";

        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            if (hasStatusFilter) {
                ps.setString(2, status.trim());
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order_24110028 order = mapOrder(rs);
                    order.setDetails(findDetailsByOrderId(conn, order.getOrderId()));
                    list.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Order_24110028> findAll(String status) {
        List<Order_24110028> list = new ArrayList<>();
        boolean hasStatusFilter = status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("ALL") && !status.equalsIgnoreCase("Tất cả");

        String sql = "SELECT OrderId, Username, CustomerName, Phone, Address, Note, TotalAmount, PaymentMethod, Status, CreatedDate FROM Orders";
        if (hasStatusFilter) {
            sql += " WHERE Status = ?";
        }
        sql += " ORDER BY OrderId DESC";

        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (hasStatusFilter) {
                ps.setString(1, status.trim());
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order_24110028 order = mapOrder(rs);
                    order.setDetails(findDetailsByOrderId(conn, order.getOrderId()));
                    list.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean updateStatus(int orderId, String newStatus) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderId = ?";
        try (Connection conn = DBContext_24110028.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public int countTotalOrders() {
        String sql = "SELECT COUNT(*) FROM Orders";
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

    private Order_24110028 mapOrder(ResultSet rs) throws SQLException {
        return new Order_24110028(
                rs.getInt("OrderId"),
                rs.getString("Username"),
                rs.getString("CustomerName"),
                rs.getString("Phone"),
                rs.getString("Address"),
                rs.getString("Note"),
                rs.getBigDecimal("TotalAmount"),
                rs.getString("PaymentMethod"),
                rs.getString("Status"),
                rs.getTimestamp("CreatedDate")
        );
    }

    private List<OrderDetail_24110028> findDetailsByOrderId(Connection conn, int orderId) {
        List<OrderDetail_24110028> list = new ArrayList<>();
        String sql = "SELECT od.DetailId, od.OrderId, od.VideoId, od.Price, od.Quantity, od.Amount, v.Title, v.Poster "
                   + "FROM OrderDetails od LEFT JOIN Videos v ON od.VideoId = v.VideoId WHERE od.OrderId = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail_24110028 d = new OrderDetail_24110028(
                            rs.getInt("DetailId"),
                            rs.getInt("OrderId"),
                            rs.getString("VideoId"),
                            rs.getBigDecimal("Price"),
                            rs.getInt("Quantity"),
                            rs.getBigDecimal("Amount")
                    );
                    Video_24110028 v = new Video_24110028();
                    v.setVideoId(rs.getString("VideoId"));
                    v.setTitle(rs.getString("Title"));
                    v.setPoster(rs.getString("Poster"));
                    v.setPrice(rs.getBigDecimal("Price"));
                    d.setVideo(v);
                    list.add(d);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
