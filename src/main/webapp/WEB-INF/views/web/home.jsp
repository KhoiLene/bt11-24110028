<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>UTE SHOP - Bán Hàng Qua Video & Mua Sắm Trực Tuyến</title>
    <style>
        .hero-banner {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 50%, #e52d27 100%);
            border-radius: 20px;
            color: #ffffff;
            padding: 50px 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
        }
        .hero-banner::after {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 250px;
            height: 250px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 50%;
        }
        .category-card {
            border: 1px solid #e9ecef;
            border-radius: 16px;
            background: #ffffff;
            transition: all 0.25s ease-in-out;
            text-align: center;
            padding: 24px 16px;
        }
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            border-color: #0d6efd;
        }
        .product-video-card {
            border: 1px solid #e9ecef;
            border-radius: 16px;
            background: #ffffff;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
            transition: all 0.25s ease-in-out;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .product-video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.12);
        }
        .video-wrapper {
            position: relative;
            background-color: #000;
            height: 220px;
            overflow: hidden;
        }
        .video-wrapper video {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .price-tag {
            font-size: 1.35rem;
            font-weight: 700;
            color: #dc3545;
        }
        .btn-buy-now {
            background: linear-gradient(45deg, #e52d27, #b31217);
            color: white;
            font-weight: 600;
            border: none;
            transition: all 0.2s;
        }
        .btn-buy-now:hover {
            background: linear-gradient(45deg, #b31217, #e52d27);
            color: white;
            box-shadow: 0 4px 12px rgba(229, 45, 39, 0.4);
            transform: scale(1.02);
        }
        .trust-badge {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(5px);
            border-radius: 30px;
            padding: 8px 18px;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
    </style>
</head>
<body>
<div class="container py-3">

    <!-- Thông báo thêm giỏ hàng thành công -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show rounded-pill px-4 shadow-sm mb-4" role="alert">
            <i class="bi bi-cart-check-fill me-2 fs-5"></i><strong>${successMessage}</strong>
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-sm btn-success ms-3 rounded-pill fw-bold">Xem Giỏ Hàng & Thanh Toán COD</a>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- HERO BANNER BÁN HÀNG QUA VIDEO -->
    <div class="hero-banner mb-5">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <span class="badge bg-warning text-dark px-3 py-2 rounded-pill fw-bold mb-3">
                    <i class="bi bi-fire me-1"></i>XU HƯỚNG MUA SẮM 2026
                </span>
                <h1 class="display-5 fw-bold mb-3">UTE SHOP - BÁN HÀNG QUA VIDEO</h1>
                <p class="lead mb-4 opacity-90">
                    Trải nghiệm mua sắm chân thực nhất: Xem video mô tả & review thực tế của từng sản phẩm, đặt hàng nhanh chóng với hình thức <strong>Thanh toán khi nhận hàng (COD)</strong> an tâm tuyệt đối!
                </p>
                <div class="d-flex flex-wrap gap-3 mb-4">
                    <a href="${pageContext.request.contextPath}/videos" class="btn btn-warning btn-lg px-4 rounded-pill fw-bold text-dark shadow-sm">
                        <i class="bi bi-play-circle-fill me-2"></i>Xem Tất Cả Video Sản Phẩm
                    </a>
                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light btn-lg px-4 rounded-pill fw-bold">
                        <i class="bi bi-cart3 me-2"></i>Giỏ Hàng Của Bạn
                    </a>
                </div>
                <div class="d-flex flex-wrap gap-2">
                    <span class="trust-badge"><i class="bi bi-truck text-warning"></i> Giao hàng COD toàn quốc</span>
                    <span class="trust-badge"><i class="bi bi-shield-check text-warning"></i> Kiểm tra hàng trước khi trả tiền</span>
                    <span class="trust-badge"><i class="bi bi-arrow-repeat text-warning"></i> Đổi trả dễ dàng 7 ngày</span>
                </div>
            </div>
            <div class="col-lg-4 text-center d-none d-lg-block">
                <div class="p-3 bg-white bg-opacity-10 rounded-4 border border-white border-opacity-25 shadow">
                    <i class="bi bi-camera-reels-fill text-warning" style="font-size: 6rem;"></i>
                    <h5 class="fw-bold mt-2 text-white">Video Chân Thực 100%</h5>
                    <small class="text-white text-opacity-75">Không lo sản phẩm khác hình ảnh thực tế</small>
                </div>
            </div>
        </div>
    </div>

    <!-- DANH MỤC SẢN PHẨM MUA SẮM -->
    <div class="mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1 text-dark border-start border-4 border-danger ps-3">Danh Mục Sản Phẩm</h3>
                <p class="text-muted mb-0 small ps-3">Chọn danh mục để xem các video review và ưu đãi tương ứng</p>
            </div>
        </div>
        <div class="row g-3">
            <c:forEach var="item" items="${categoriesWithCount}">
                <div class="col-6 col-md-4 col-lg">
                    <a href="${pageContext.request.contextPath}/videos?categoryId=${item.category.categoryId}" class="text-decoration-none">
                        <div class="category-card h-100">
                            <div class="mb-2">
                                <c:choose>
                                    <c:when test="${item.category.categoryId == 1}">
                                        <i class="bi bi-house-gear-fill fs-1 text-danger"></i>
                                    </c:when>
                                    <c:when test="${item.category.categoryId == 2}">
                                        <i class="bi bi-bag-heart-fill fs-1 text-primary"></i>
                                    </c:when>
                                    <c:when test="${item.category.categoryId == 3}">
                                        <i class="bi bi-laptop-fill fs-1 text-success"></i>
                                    </c:when>
                                    <c:when test="${item.category.categoryId == 4}">
                                        <i class="bi bi-flower1 fs-1 text-warning"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-cup-hot-fill fs-1 text-info"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <h6 class="fw-bold text-dark mb-1 line-clamp-1">${item.category.categoryname}</h6>
                            <span class="badge bg-danger-subtle text-danger rounded-pill px-2 py-1">
                                ${item.videoCount} Sản phẩm
                            </span>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- SẢN PHẨM VIDEO QUẢNG BÁ NỔI BẬT (CÓ NÚT MUA HÀNG TRỰC TIẾP) -->
    <div class="mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h3 class="fw-bold mb-1 text-dark border-start border-4 border-danger ps-3">
                    <i class="bi bi-broadcast text-danger me-1"></i>Sản Phẩm Đang Bán Qua Video
                </h3>
                <p class="text-muted mb-0 small ps-3">Xem video giới thiệu và bấm <strong>Mua Hàng Ngay</strong> bên dưới mỗi video</p>
            </div>
            <a href="${pageContext.request.contextPath}/videos" class="btn btn-outline-danger rounded-pill px-4 fw-semibold">
                Xem tất cả sản phẩm <i class="bi bi-arrow-right ms-1"></i>
            </a>
        </div>

        <div class="row g-4">
            <c:forEach var="item" items="${featuredVideos}">
                <div class="col-md-6 col-lg-4">
                    <div class="product-video-card">
                        <!-- Khung Video Player Trực Tiếp -->
                        <div class="video-wrapper">
                            <video controls preload="metadata" class="w-100 h-100">
                                <source src="${pageContext.request.contextPath}/static/videos/VIDEOtest.mp4" type="video/mp4">
                            </video>
                            <span class="badge bg-danger position-absolute top-0 start-0 m-2 rounded-pill px-2 py-1 shadow-sm">
                                <i class="bi bi-play-circle-fill me-1"></i>Demo Video
                            </span>
                        </div>

                        <!-- Thông tin sản phẩm & Giá bán -->
                        <div class="card-body p-3 d-flex flex-column">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="badge bg-light text-primary border">${item.categoryName}</span>
                                <small class="text-muted"><i class="bi bi-eye me-1"></i>${item.video.views} lượt xem</small>
                            </div>

                            <h5 class="fw-bold mb-1">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${item.video.videoId}" 
                                   class="text-decoration-none text-dark hover-primary line-clamp-2">
                                    ${item.video.title}
                                </a>
                            </h5>

                            <p class="text-muted small mb-3 line-clamp-2">${item.video.description}</p>

                            <!-- Đơn giá và ưu đãi COD -->
                            <div class="p-2 bg-light rounded-3 mb-3 d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted d-block" style="font-size: 0.75rem;">ĐƠN GIÁ BÁN:</small>
                                    <span class="price-tag">
                                        <fmt:formatNumber value="${item.video.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </span>
                                </div>
                                <span class="badge bg-success-subtle text-success rounded-pill px-2 py-1 small">
                                    <i class="bi bi-cash-stack me-1"></i>Giao COD
                                </span>
                            </div>

                            <!-- Lượt like / share -->
                            <div class="d-flex justify-content-between align-items-center text-muted small mb-3 border-top pt-2">
                                <span><i class="bi bi-hand-thumbs-up-fill text-danger me-1"></i>${item.likeCount} Thích</span>
                                <span><i class="bi bi-share-fill text-primary me-1"></i>${item.shareCount} Chia sẻ</span>
                                <span>Mã: <code>${item.video.videoId}</code></span>
                            </div>

                            <!-- NÚT MUA HÀNG NGAY & XEM CHI TIẾT -->
                            <div class="mt-auto d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${item.video.videoId}" 
                                   class="btn btn-outline-secondary btn-sm rounded-pill px-3 d-flex align-items-center justify-content-center" 
                                   title="Xem chi tiết video và thông tin">
                                    <i class="bi bi-info-circle me-1"></i>Chi Tiết
                                </a>

                                <!-- Nút Mua Hàng Trực Tiếp (Thêm vào giỏ) -->
                                <form action="${pageContext.request.contextPath}/cart/add" method="post" class="flex-fill d-inline mb-0">
                                    <input type="hidden" name="videoId" value="${item.video.videoId}">
                                    <input type="hidden" name="quantity" value="1">
                                    <input type="hidden" name="redirect" value="/home">
                                    <button type="submit" class="btn btn-buy-now btn-sm rounded-pill w-100 py-2 d-flex align-items-center justify-content-center">
                                        <i class="bi bi-cart-plus-fill me-1 fs-6"></i>
                                        <span>MUA HÀNG NGAY</span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>
