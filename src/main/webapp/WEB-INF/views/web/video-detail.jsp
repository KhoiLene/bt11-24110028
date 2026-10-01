<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${videoDetail.video.title} - Video Bán Hàng & Đặt Mua COD</title>
    <style>
        .video-player-container {
            width: 100%;
            height: 420px;
            background-color: #000;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .video-player-container video {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        .purchase-card {
            border: 1px solid #e9ecef;
            background-color: #ffffff;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.06);
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .detail-label {
            font-weight: 600;
            color: #6c757d;
            min-width: 130px;
            display: inline-block;
        }
        .price-hero {
            color: #dc3545;
            font-size: 2rem;
            font-weight: 800;
            line-height: 1.2;
        }
        .btn-buy-primary {
            background: linear-gradient(45deg, #e52d27, #b31217);
            color: white;
            font-weight: 700;
            border: none;
            padding: 12px 24px;
            font-size: 1.1rem;
            border-radius: 50px;
            transition: all 0.2s ease-in-out;
        }
        .btn-buy-primary:hover {
            background: linear-gradient(45deg, #b31217, #e52d27);
            color: white;
            box-shadow: 0 6px 16px rgba(229, 45, 39, 0.35);
            transform: translateY(-2px);
        }
        .btn-buy-secondary {
            border: 2px solid #dc3545;
            color: #dc3545;
            font-weight: 600;
            border-radius: 50px;
            padding: 10px 20px;
            background: transparent;
            transition: all 0.2s;
        }
        .btn-buy-secondary:hover {
            background: #dc3545;
            color: white;
        }
        .guarantee-box {
            background-color: #f8f9fa;
            border-radius: 12px;
            padding: 12px 16px;
            border: 1px dashed #ced4da;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <!-- Breadcrumb điều hướng -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/videos?categoryId=${videoDetail.video.categoryId}" class="text-decoration-none">${videoDetail.categoryName}</a></li>
            <li class="breadcrumb-item active" aria-current="page">${videoDetail.video.title}</li>
        </ol>
    </nav>

    <!-- Thông báo thêm giỏ hàng -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show rounded-pill px-4 shadow-sm mb-4" role="alert">
            <i class="bi bi-cart-check-fill me-2 fs-5"></i><strong>${successMessage}</strong>
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-sm btn-success ms-3 rounded-pill fw-bold">Xem Giỏ Hàng Ngay</a>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- HÀNG CHÍNH: BÊN TRÁI VIDEO - BÊN PHẢI NÚT MUA HÀNG VÀ ĐƠN GIÁ -->
    <div class="row g-4 mb-4">
        <!-- Khung Video Player Trực Tiếp -->
        <div class="col-lg-7">
            <div class="video-player-container mb-3">
                <video controls autoplay preload="metadata" class="w-100 h-100">
                    <source src="${pageContext.request.contextPath}/static/videos/VIDEOtest.mp4" type="video/mp4">
                </video>
            </div>
            
            <!-- Tiêu đề và tương tác video bên dưới video -->
            <div class="bg-white p-3 rounded-4 shadow-sm border">
                <div class="d-flex justify-content-between align-items-start mb-2">
                    <div>
                        <span class="badge bg-danger-subtle text-danger mb-1 fw-bold">
                            <i class="bi bi-tag-fill me-1"></i>${videoDetail.categoryName}
                        </span>
                        <h4 class="fw-bold text-dark mb-0">${videoDetail.video.title}</h4>
                    </div>
                </div>

                <div class="d-flex flex-wrap justify-content-between align-items-center pt-2 border-top gap-2 text-muted small">
                    <div class="d-flex gap-3 align-items-center">
                        <span><i class="bi bi-eye-fill me-1 text-primary"></i><strong>${videoDetail.video.views}</strong> lượt xem</span>
                        <span class="badge bg-light text-dark border px-2 py-1">
                            <i class="bi bi-heart-fill text-danger me-1"></i>${videoDetail.likeCount} Thích
                        </span>
                        <span class="badge bg-light text-dark border px-2 py-1">
                            <i class="bi bi-share-fill text-primary me-1"></i>${videoDetail.shareCount} Chia sẻ
                        </span>
                    </div>
                    <span>Mã SP: <code class="fw-bold">${videoDetail.video.videoId}</code></span>
                </div>
            </div>
        </div>

        <!-- Khung Mua Hàng Siêu Tốc (Shopping Box) -->
        <div class="col-lg-5">
            <div class="purchase-card">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <span class="badge bg-success-subtle text-success px-3 py-1 rounded-pill fw-bold">
                        <i class="bi bi-check-circle-fill me-1"></i>Còn hàng - Sẵn sàng giao COD
                    </span>
                    <small class="text-muted">Giao hàng 1 - 3 ngày</small>
                </div>

                <h3 class="fw-bold text-dark mb-2">${videoDetail.video.title}</h3>

                <!-- Giá bán nổi bật -->
                <div class="p-3 bg-light rounded-4 mb-3 border">
                    <small class="text-muted fw-bold d-block text-uppercase" style="letter-spacing: 0.5px;">GIÁ ƯU ĐÃI KHI MUA TỪ VIDEO:</small>
                    <div class="d-flex align-items-baseline gap-2">
                        <span class="price-hero">
                            <fmt:formatNumber value="${videoDetail.video.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                        </span>
                        <span class="badge bg-danger rounded-pill">Ưu Đãi COD</span>
                    </div>
                    <small class="text-success fw-semibold"><i class="bi bi-truck me-1"></i>Miễn phí vận chuyển COD toàn quốc</small>
                </div>

                <!-- Form Mua Hàng & Chọn Số Lượng (1 - 99) -->
                <form action="${pageContext.request.contextPath}/cart/add" method="post" class="mb-3">
                    <input type="hidden" name="videoId" value="${videoDetail.video.videoId}">
                    <input type="hidden" name="redirect" value="/video/detail?id=${videoDetail.video.videoId}">

                    <div class="mb-3">
                        <label class="form-label fw-bold text-dark">Số Lượng Đặt Mua:</label>
                        <div class="d-flex align-items-center gap-2">
                            <div class="input-group" style="width: 150px;">
                                <button class="btn btn-outline-secondary" type="button" 
                                        onclick="let q = document.getElementById('qtyInput'); if(parseInt(q.value) > 1) q.value = parseInt(q.value) - 1;">
                                    <i class="bi bi-dash"></i>
                                </button>
                                <input type="number" id="qtyInput" name="quantity" value="1" min="1" max="99" 
                                       class="form-control text-center fw-bold fs-5" required>
                                <button class="btn btn-outline-secondary" type="button" 
                                        onclick="let q = document.getElementById('qtyInput'); if(parseInt(q.value) < 99) q.value = parseInt(q.value) + 1;">
                                    <i class="bi bi-plus"></i>
                                </button>
                            </div>
                            <small class="text-muted">(Giới hạn 1 đến 99 món)</small>
                        </div>
                    </div>

                    <!-- NÚT MUA HÀNG NGAY QUA VIDEO -->
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-buy-primary d-flex align-items-center justify-content-center gap-2 shadow">
                            <i class="bi bi-bag-check-fill fs-5"></i>
                            <span>MUA HÀNG NGAY (GIAO COD)</span>
                        </button>
                    </div>
                </form>

                <!-- Cam kết mua hàng -->
                <div class="guarantee-box mt-auto">
                    <h6 class="fw-bold text-dark mb-2 small"><i class="bi bi-shield-check text-success me-1"></i>CAM KẾT DỊCH VỤ UTE SHOP:</h6>
                    <ul class="list-unstyled mb-0 small text-muted">
                        <li class="mb-1"><i class="bi bi-check2 text-success me-1"></i><strong>Kiểm tra hàng trước:</strong> Được xem hàng trước khi trả tiền shipper.</li>
                        <li class="mb-1"><i class="bi bi-check2 text-success me-1"></i><strong>Thanh toán an toàn:</strong> Trả tiền mặt COD tận nhà, không cần chuyển khoản trước.</li>
                        <li><i class="bi bi-check2 text-success me-1"></i><strong>Đổi trả 7 ngày:</strong> Đổi mới nếu sản phẩm không đúng như video mô tả.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- MÔ TẢ CHI TIẾT SẢN PHẨM -->
    <div class="card border-0 shadow-sm rounded-4 p-4 mb-4">
        <h5 class="fw-bold text-dark mb-3 border-start border-4 border-primary ps-3">
            <i class="bi bi-card-text text-primary me-2"></i>Mô Tả Sản Phẩm & Video Trải Nghiệm
        </h5>
        <div class="text-secondary ps-3" style="line-height: 1.8; font-size: 1.05rem;">
            ${videoDetail.video.description}
        </div>
    </div>

    <!-- Nút quay lại -->
    <div class="text-center mt-3">
        <a href="${pageContext.request.contextPath}/videos?categoryId=${videoDetail.video.categoryId}" class="btn btn-outline-secondary rounded-pill px-4">
            <i class="bi bi-arrow-left me-1"></i>Quay lại danh mục ${videoDetail.categoryName}
        </a>
    </div>
</div>
</body>
</html>
