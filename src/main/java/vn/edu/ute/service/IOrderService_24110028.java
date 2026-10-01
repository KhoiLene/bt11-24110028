package vn.edu.ute.service;

import vn.edu.ute.model.Order_24110028;

import java.util.List;

public interface IOrderService_24110028 {
    int createOrder(Order_24110028 order);
    Order_24110028 findById(int orderId);
    List<Order_24110028> findByUsername(String username, String status);
    List<Order_24110028> findAll(String status);
    boolean updateStatus(int orderId, String newStatus);
    int countTotalOrders();
}
