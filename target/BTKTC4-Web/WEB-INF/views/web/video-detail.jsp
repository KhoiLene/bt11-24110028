<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${videoDetail.video.title} - Chi Tiết Video</title>
    <style>
        .video-detail-box {
            border: 2px solid #dee2e6;
            background-color: #ffffff;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .poster-container {
            width: 100%;
            height: 280px;
            background-color: #000;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #adb5bd;
            overflow: hidden;
            border: 1px solid #ced4da;
        }
        .poster-container video, .poster-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .detail-label {
            font-weight: 600;
            color: #495057;
            min-width: 140px;
            display: inline-block;
        }
        .description-box {
            border-top: 1px solid #dee2e6;
            margin-top: 20px;
            padding-top: 16px;
            line-height: 1.6;
            color: #333;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/videos?categoryId=${videoDetail.video.categoryId}" class="text-decoration-none">${videoDetail.categoryName}</a></li>
            <li class="breadcrumb-item active" aria-current="page">${videoDetail.video.title}</li>
        </ol>
    </nav>


    <!-- KHUNG CHI TIẾT VIDEO -->
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="video-detail-box">
                <div class="row g-4">
                    <!-- [poster] -->
                    <div class="col-md-5">
                        <div class="poster-container position-relative">
                            <video controls preload="metadata" class="w-100 h-100" style="object-fit: cover;">
                                <source src="${pageContext.request.contextPath}/static/videos/VIDEOtest.mp4" type="video/mp4">
                            </video>
                        </div>
                    </div>

                    <!-- Thông tin chi tiết bên phải -->
                    <div class="col-md-7 d-flex flex-column justify-content-center">
                        <div class="mb-2">
                            <span class="detail-label">Tiêu đề:</span>
                            <span class="fs-5 fw-bold text-primary">${videoDetail.video.title}</span>
                        </div>

                        <div class="mb-2">
                            <span class="detail-label">Mã video:</span>
                            <span class="badge bg-secondary font-monospace">${videoDetail.video.videoId}</span>
                        </div>

                        <div class="mb-2">
                            <span class="detail-label">Category name:</span>
                            <span class="badge bg-info-subtle text-info fw-semibold">${videoDetail.categoryName}</span>
                        </div>

                        <div class="mb-2">
                            <span class="detail-label">View:</span>
                            <span class="fw-bold text-dark"><i class="bi bi-eye text-muted me-1"></i>${videoDetail.video.views}</span>
                        </div>

                        <div class="mb-2">
                            <span class="detail-label">Share:</span>
                            <span class="badge bg-light text-dark border px-3 py-2">
                                <i class="bi bi-share-fill text-primary me-1"></i>Share(${videoDetail.shareCount})
                            </span>
                        </div>

                        <div class="mb-2">
                            <span class="detail-label">Like:</span>
                            <span class="badge bg-light text-dark border px-3 py-2">
                                <i class="bi bi-heart-fill text-danger me-1"></i>Like(${videoDetail.likeCount})
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Description theo mẫu đề -->
                <div class="description-box">
                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-card-text me-1 text-primary"></i>Description:</h6>
                    <p class="text-secondary mb-0">
                        ${videoDetail.video.description}
                    </p>
                </div>
            </div>

            <!-- Nút quay lại -->
            <div class="mt-4 text-center">
                <a href="${pageContext.request.contextPath}/videos?categoryId=${videoDetail.video.categoryId}" class="btn btn-outline-secondary px-4 rounded-pill">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách Video
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
