package vn.edu.ute.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class CartItem_24110028 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Video_24110028 video;
    private int quantity;

    public CartItem_24110028() {
    }

    public CartItem_24110028(Video_24110028 video, int quantity) {
        this.video = video;
        this.setQuantity(quantity);
    }

    public Video_24110028 getVideo() {
        return video;
    }

    public void setVideo(Video_24110028 video) {
        this.video = video;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity < 1) {
            this.quantity = 1;
        } else if (quantity > 99) {
            this.quantity = 99;
        } else {
            this.quantity = quantity;
        }
    }

    public BigDecimal getAmount() {
        if (video == null || video.getPrice() == null) {
            return BigDecimal.ZERO;
        }
        return video.getPrice().multiply(BigDecimal.valueOf(quantity));
    }
}
