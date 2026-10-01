<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ - UTE Video</title>
</head>
<body>
    <div class="container">
        <!-- Hero Banner -->
        <div class="p-5 mb-4 bg-primary text-white rounded-4 shadow-sm text-center">
            <h1 class="display-5 fw-bold mb-4">Chào Mừng Đến Với UTE Video</h1>
            <div class="d-flex justify-content-center gap-3">
                <a href="${pageContext.request.contextPath}/videos" class="btn btn-warning btn-lg px-4 fw-bold">
                    <i class="bi bi-play-circle me-2"></i>Khám Phá Video
                </a>
                <c:if test="${empty sessionScope.currentUser}">
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-light btn-lg px-4">
                        <i class="bi bi-person-plus me-2"></i>Đăng Ký Ngay
                    </a>
                </c:if>
            </div>
        </div>

        <!-- Danh mục nổi bật  -->
        <div class="mb-5">
            <h3 class="fw-bold mb-4 border-start border-4 border-primary ps-3">Danh Mục Video</h3>
            <div class="row g-3">
                <c:forEach var="item" items="${categoriesWithCount}">
                    <div class="col-md-4 col-lg-3">
                        <div class="card h-100 border-0 shadow-sm rounded-3 overflow-hidden text-center hover-shadow">
                            <div class="card-body p-4">
                                <i class="bi bi-folder-fill fs-1 text-primary mb-2"></i>
                                <h5 class="card-title fw-bold mb-1">${item.category.categoryname}</h5>
                                <span class="badge bg-primary-subtle text-primary rounded-pill px-3 py-2">
                                    ${item.videoCount} Video
                                </span>
                                <div class="mt-3">
                                    <a href="${pageContext.request.contextPath}/videos?categoryId=${item.category.categoryId}" class="btn btn-outline-primary btn-sm rounded-pill w-100">
                                        Xem Video
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Video Nổi Bật -->
        <div>
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold mb-0 border-start border-4 border-primary ps-3">Video Mới Nhất</h3>
                <a href="${pageContext.request.contextPath}/videos" class="btn btn-link text-decoration-none">
                    Xem tất cả <i class="bi bi-arrow-right"></i>
                </a>
            </div>
            <div class="row g-4">
                <c:forEach var="item" items="${featuredVideos}">
                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm rounded-3 overflow-hidden">
                            <div class="position-relative bg-black d-flex align-items-center justify-content-center" style="height: 200px;">
                                <video controls preload="metadata" class="w-100 h-100" style="object-fit: cover;">
                                    <source src="${pageContext.request.contextPath}/static/videos/VIDEOtest.mp4" type="video/mp4">
                                </video>
                            </div>
                            <div class="card-body">
                                <span class="badge bg-info-subtle text-info mb-2">${item.categoryName}</span>
                                <h6 class="card-title fw-bold text-truncate">${item.video.title}</h6>
                                <p class="card-text text-secondary small text-truncate">${item.video.description}</p>
                                <div class="d-flex justify-content-between align-items-center border-top pt-2">
                                    <small class="text-muted">
                                        <i class="bi bi-share text-primary me-1"></i>${item.shareCount}
                                        <i class="bi bi-hand-thumbs-up text-danger ms-2 me-1"></i>${item.likeCount}
                                    </small>
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${item.video.videoId}" class="btn btn-primary btn-sm rounded-pill px-3">
                                        Xem Chi Tiết
                                    </a>
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
