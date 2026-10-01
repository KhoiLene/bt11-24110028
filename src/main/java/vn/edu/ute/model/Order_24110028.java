package vn.edu.ute.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Order_24110028 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int orderId;
    private String username;
    private String customerName;
    private String phone;
    private String address;
    private String note;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private String status;
    private Timestamp createdDate;
    private List<OrderDetail_24110028> details = new ArrayList<>();

    public Order_24110028() {
        this.paymentMethod = "COD";
        this.status = "Đơn hàng mới";
        this.totalAmount = BigDecimal.ZERO;
    }

    public Order_24110028(int orderId, String username, String customerName, String phone, String address,
                          String note, BigDecimal totalAmount, String paymentMethod, String status, Timestamp createdDate) {
        this.orderId = orderId;
        this.username = username;
        this.customerName = customerName;
        this.phone = phone;
        this.address = address;
        this.note = note;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.createdDate = createdDate;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public List<OrderDetail_24110028> getDetails() {
        return details;
    }

    public void setDetails(List<OrderDetail_24110028> details) {
        this.details = details;
    }

    public String getStatusBadgeClass() {
        if (status == null) return "bg-secondary";
        switch (status.trim()) {
            case "Đơn hàng mới":
                return "bg-primary";
            case "Đã xác nhận":
                return "bg-info text-dark";
            case "Chuẩn bị hàng":
                return "bg-warning text-dark";
            case "Vận chuyển":
                return "bg-secondary";
            case "Giao hàng":
                return "bg-primary";
            case "Đã giao":
                return "bg-success";
            case "Đơn hàng hủy":
                return "bg-danger";
            case "Đơn hàng hoàn":
                return "bg-dark";
            default:
                return "bg-secondary";
        }
    }
}
