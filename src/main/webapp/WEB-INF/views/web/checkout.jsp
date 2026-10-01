<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh Toán Đơn Hàng COD - UTE SHOP</title>
</head>
<body>
<div class="container py-4">
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart" class="text-decoration-none">Giỏ Hàng</a></li>
            <li class="breadcrumb-item active" aria-current="page">Thanh Toán Đơn Hàng (COD)</li>
        </ol>
    </nav>

    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h2 class="fw-bold mb-1 text-dark"><i class="bi bi-wallet2 text-danger me-2"></i>Thanh Toán Đơn Hàng COD</h2>
            <p class="text-muted mb-0">Thanh toán tiền mặt tận nơi khi nhận và kiểm tra hàng hóa</p>
        </div>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/checkout" method="post">
        <div class="row g-4">
            <!-- Form thông tin nhận hàng -->
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm rounded-4 p-4 mb-4">
                    <h5 class="fw-bold text-dark mb-3"><i class="bi bi-geo-alt-fill text-danger me-2"></i>Thông Tin Giao Hàng</h5>
                    
                    <div class="mb-3">
                        <label for="customerName" class="form-label fw-semibold">Họ và tên người nhận <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-lg" id="customerName" name="customerName" 
                               value="${not empty defaultName ? defaultName : ''}" placeholder="Ví dụ: Nguyễn Văn A" required>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label fw-semibold">Số điện thoại liên hệ <span class="text-danger">*</span></label>
                        <input type="tel" class="form-control form-control-lg" id="phone" name="phone" 
                               placeholder="Ví dụ: 0912345678" pattern="[0-9]{9,11}" required>
                        <small class="text-muted">Nhân viên giao hàng sẽ gọi điện xác nhận trước khi giao</small>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label fw-semibold">Địa chỉ giao hàng chi tiết <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="address" name="address" rows="3" 
                                  placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố..." required></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="note" class="form-label fw-semibold">Ghi chú đơn hàng (Tùy chọn)</label>
                        <textarea class="form-control" id="note" name="note" rows="2" 
                                  placeholder="Ví dụ: Giao giờ hành chính, gọi trước khi đến..."></textarea>
                    </div>
                </div>

                <!-- Phương thức thanh toán -->
                <div class="card border-0 shadow-sm rounded-4 p-4">
                    <h5 class="fw-bold text-dark mb-3"><i class="bi bi-credit-card-2-front-fill text-primary me-2"></i>Phương Thức Thanh Toán</h5>
                    
                    <div class="form-check p-3 border rounded-3 bg-light d-flex align-items-center gap-3">
                        <input class="form-check-input ms-0 me-2" type="radio" name="paymentMethod" id="codMethod" value="COD" checked>
                        <label class="form-check-label w-100" for="codMethod">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <strong class="text-dark d-block"><i class="bi bi-cash-stack text-success me-1"></i>Thanh toán khi nhận hàng (COD)</strong>
                                    <small class="text-muted">Bạn chỉ thanh toán tiền mặt cho shipper sau khi nhận và kiểm tra hàng.</small>
                                </div>
                                <span class="badge bg-success">Khuyên dùng</span>
                            </div>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Tóm tắt đơn hàng bên phải -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm rounded-4 p-4 sticky-top" style="top: 90px;">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-dark mb-0">Đơn Hàng Của Bạn</h5>
                        <span class="badge bg-danger rounded-pill">${cart.totalQuantity} sản phẩm</span>
                    </div>

                    <!-- Danh sách sản phẩm thu gọn -->
                    <div class="list-group list-group-flush mb-3" style="max-height: 280px; overflow-y: auto;">
                        <c:forEach var="item" items="${cart.items}">
                            <div class="list-group-item px-0 py-2 border-bottom d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-2">
                                    <img src="${item.video.poster}" alt="${item.video.title}" 
                                         class="rounded-2 object-fit-cover" width="45" height="45"
                                         onerror="this.src='https://placehold.co/45x45?text=SP'">
                                    <div>
                                        <small class="fw-semibold text-dark d-block line-clamp-1" style="max-width: 170px;">
                                            ${item.video.title}
                                        </small>
                                        <small class="text-muted">SL: x${item.quantity}</small>
                                    </div>
                                </div>
                                <span class="fw-bold text-danger small">
                                    <fmt:formatNumber value="${item.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </span>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Tạm tính:</span>
                        <span class="fw-semibold">
                            <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                        </span>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <span class="text-muted">Phí vận chuyển:</span>
                        <span class="text-success fw-semibold">Miễn phí</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fs-5 fw-bold text-dark">Tổng tiền COD:</span>
                        <span class="fs-4 fw-bold text-danger">
                            <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                        </span>
                    </div>

                    <button type="submit" class="btn btn-danger btn-lg rounded-pill fw-bold w-100 py-3 shadow-sm">
                        <i class="bi bi-check2-circle me-2"></i>Xác Nhận Đặt Hàng (COD)
                    </button>
                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-link text-muted text-decoration-none text-center w-100 mt-2">
                        <i class="bi bi-arrow-left me-1"></i>Quay lại chỉnh sửa giỏ hàng
                    </a>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>
