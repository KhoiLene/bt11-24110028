<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${selectedCategory.categoryname} - Danh Sách Video</title>
    <style>
        .video-card-item {
            border: 2px solid #dee2e6;
            background: #fff;
            border-radius: 8px;
            padding: 16px;
            height: 100%;
            display: flex;
            flex-direction: column;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .video-card-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.1);
        }
        .item-poster {
            height: 180px;
            background-color: #212529;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #adb5bd;
            overflow: hidden;
            margin-bottom: 14px;
            border: 1px solid #dee2e6;
        }
        .item-poster img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .field-label {
            font-weight: 600;
            color: #495057;
            font-size: 0.95rem;
        }
        .field-value {
            color: #212529;
            font-size: 0.95rem;
        }
        .pagination-container {
            margin-top: 35px;
        }
        .category-badge-title {
            background-color: #e9ecef;
            padding: 8px 18px;
            border-radius: 30px;
            font-size: 1.25rem;
            font-weight: 700;
            color: #0d6efd;
            display: inline-block;
        }
    </style>
</head>
<body>
<div class="container py-4">

    <!-- Danh sách tabs chọn danh mục -->
    <div class="mb-4">
        <label class="form-label fw-bold text-muted small text-uppercase">Chọn danh mục:</label>
        <div class="d-flex flex-wrap gap-2">
            <c:forEach var="catItem" items="${categoriesWithCount}">
                <a href="${pageContext.request.contextPath}/videos?categoryId=${catItem.category.categoryId}" 
                   class="btn ${catItem.category.categoryId == selectedCategoryId ? 'btn-primary' : 'btn-outline-secondary'} rounded-pill px-3 py-2">
                    <i class="bi bi-folder2-open me-1"></i>
                    ${catItem.category.categoryname} 
                    <span class="badge ${catItem.category.categoryId == selectedCategoryId ? 'bg-light text-primary' : 'bg-secondary'} rounded-pill ms-1">
                        (${catItem.videoCount})
                    </span>
                </a>
            </c:forEach>
        </div>
    </div>

    <!-- Tiêu đề danh mục: Category Name (Count) -->
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
        <div>
            <h2 class="fw-bold mb-0 text-dark">
                ${selectedCategory.categoryname} <span class="text-primary">(${totalVideos})</span>
            </h2>
            <small class="text-muted">Hiển thị phân trang 3 video / trang</small>
        </div>
        <div class="text-end">
            <span class="badge bg-light text-dark border px-3 py-2">Trang ${currentPage} / ${totalPages}</span>
        </div>
    </div>

    <!-- Lưới 3 Video trên 1 trang -->
    <div class="row g-4">
        <c:choose>
            <c:when test="${not empty videoList}">
                <c:forEach var="item" items="${videoList}">
                    <div class="col-md-4">
                        <div class="video-card-item">
                            <!-- [poster] Trình phát video sẵn (VIDEOtest.mp4) -->
                            <div class="item-poster p-0 bg-black">
                                <video controls preload="metadata" class="w-100 h-100" style="object-fit: cover;">
                                    <source src="${pageContext.request.contextPath}/static/videos/VIDEOtest.mp4" type="video/mp4">
                                </video>
                            </div>

                            <!-- Tiêu đề: -->
                            <div class="mb-2">
                                <span class="field-label">Tiêu đề:</span>
                                <span class="field-value fw-bold text-primary">${item.video.title}</span>
                            </div>

                            <!-- Mã video: -->
                            <div class="mb-2">
                                <span class="field-label">Mã video:</span>
                                <span class="badge bg-secondary font-monospace">${item.video.videoId}</span>
                            </div>

                            <!-- Category name: -->
                            <div class="mb-2">
                                <span class="field-label">Category name:</span>
                                <span class="badge bg-info-subtle text-info">${item.categoryName}</span>
                            </div>

                            <!-- View: -->
                            <div class="mb-2">
                                <span class="field-label">View:</span>
                                <span class="field-value fw-bold text-muted">${item.video.views}</span>
                            </div>

                            <!-- Share(10) và Like(10) -->
                            <div class="d-flex gap-2 mb-3">
                                <span class="badge bg-light text-dark border px-2 py-2">
                                    <i class="bi bi-share text-primary me-1"></i>Share(${item.shareCount})
                                </span>
                                <span class="badge bg-light text-dark border px-2 py-2">
                                    <i class="bi bi-heart-fill text-danger me-1"></i>Like(${item.likeCount})
                                </span>
                            </div>

                            <!-- Nút xem chi tiết  -->
                            <div class="mt-auto pt-2 border-top">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${item.video.videoId}" 
                                   class="btn btn-outline-primary btn-sm w-100 rounded-pill">
                                    <i class="bi bi-info-circle me-1"></i>Xem Chi Tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 text-center py-5">
                    <i class="bi bi-camera-video-off display-3 text-muted mb-3"></i>
                    <p class="fs-5 text-muted">Chưa có video nào trong danh mục này.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Phân trang theo mẫu: << 1 2 3 4 5 >>  -->
    <c:if test="${totalPages > 1}">
        <div class="pagination-container d-flex justify-content-center">
            <nav aria-label="Page navigation">
                <ul class="pagination pagination-lg">
                    <!-- Nút << (Trang đầu hoặc Trang trước) -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${selectedCategoryId}&page=1" aria-label="First">
                            &lt;&lt;
                        </a>
                    </li>
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${selectedCategoryId}&page=${currentPage - 1}" aria-label="Previous">
                            &lt;
                        </a>
                    </li>

                    <!-- Các số trang 1 2 3 4 5 ... -->
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${selectedCategoryId}&page=${i}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <!-- Nút >> (Trang sau hoặc Trang cuối) -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${selectedCategoryId}&page=${currentPage + 1}" aria-label="Next">
                            &gt;
                        </a>
                    </li>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${selectedCategoryId}&page=${totalPages}" aria-label="Last">
                            &gt;&gt;
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:if>

</div>
</body>
</html>
