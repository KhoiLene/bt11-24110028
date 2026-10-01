package vn.edu.ute.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart_24110028 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Map<String, CartItem_24110028> items = new LinkedHashMap<>();

    public Cart_24110028() {
    }

    public void addItem(Video_24110028 video, int quantity) {
        if (video == null) return;
        String id = video.getVideoId();
        if (items.containsKey(id)) {
            CartItem_24110028 item = items.get(id);
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            items.put(id, new CartItem_24110028(video, quantity));
        }
    }

    public void updateQuantity(String videoId, int quantity) {
        if (items.containsKey(videoId)) {
            if (quantity <= 0) {
                items.remove(videoId);
            } else {
                items.get(videoId).setQuantity(quantity);
            }
        }
    }

    public void removeItem(String videoId) {
        items.remove(videoId);
    }

    public void clear() {
        items.clear();
    }

    public Collection<CartItem_24110028> getItems() {
        return items.values();
    }

    public int getTotalQuantity() {
        int sum = 0;
        for (CartItem_24110028 item : items.values()) {
            sum += item.getQuantity();
        }
        return sum;
    }

    public BigDecimal getTotalAmount() {
        BigDecimal sum = BigDecimal.ZERO;
        for (CartItem_24110028 item : items.values()) {
            sum = sum.add(item.getAmount());
        }
        return sum;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
}
