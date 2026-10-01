package vn.edu.ute.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.edu.ute.dao.IOrderDAO_24110028;
import vn.edu.ute.model.Order_24110028;

import java.util.List;

@Service
public class OrderServiceImpl_24110028 implements IOrderService_24110028 {

    @Autowired
    private IOrderDAO_24110028 orderDAO;

    @Override
    public int createOrder(Order_24110028 order) {
        return orderDAO.createOrder(order);
    }

    @Override
    public Order_24110028 findById(int orderId) {
        return orderDAO.findById(orderId);
    }

    @Override
    public List<Order_24110028> findByUsername(String username, String status) {
        return orderDAO.findByUsername(username, status);
    }

    @Override
    public List<Order_24110028> findAll(String status) {
        return orderDAO.findAll(status);
    }

    @Override
    public boolean updateStatus(int orderId, String newStatus) {
        return orderDAO.updateStatus(orderId, newStatus);
    }

    @Override
    public int countTotalOrders() {
        return orderDAO.countTotalOrders();
    }
}
