package vn.edu.ute.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class OrderDetail_24110028 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int detailId;
    private int orderId;
    private String videoId;
    private BigDecimal price;
    private int quantity;
    private BigDecimal amount;
    private Video_24110028 video;

    public OrderDetail_24110028() {
    }

    public OrderDetail_24110028(int detailId, int orderId, String videoId, BigDecimal price, int quantity, BigDecimal amount) {
        this.detailId = detailId;
        this.orderId = orderId;
        this.videoId = videoId;
        this.price = price;
        this.quantity = quantity;
        this.amount = amount;
    }

    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Video_24110028 getVideo() {
        return video;
    }

    public void setVideo(Video_24110028 video) {
        this.video = video;
    }
}
