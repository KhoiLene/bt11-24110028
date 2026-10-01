<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng Điều Khiển Quản Trị Hệ Thống</title>
</head>
<body>
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1 text-dark">Bảng Điều Khiển Quản Trị Hệ Thống</h3>
            <p class="text-muted mb-0">Quản lý toàn diện tài khoản, video và danh mục nội dung</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/users/create" class="btn btn-primary rounded-pill px-4">
                <i class="bi bi-person-plus-fill me-1"></i>Thêm Người Dùng
            </a>
        </div>
    </div>

    <!-- Thống kê tổng quan -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 bg-primary text-white p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase opacity-75 mb-2">Tổng Số Người Dùng</h6>
                        <h2 class="fw-bold mb-0">${totalUsers} Users</h2>
                        <small class="opacity-75">Quản lý phân quyền tài khoản</small>
                    </div>
                    <i class="bi bi-people-fill display-4 opacity-50"></i>
                </div>
                <div class="mt-3 pt-3 border-top border-white border-opacity-25">
                    <a href="${pageContext.request.contextPath}/admin/users" class="text-white text-decoration-none small fw-semibold">
                        Quản lý người dùng <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 bg-success text-white p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase opacity-75 mb-2">Tổng Số Video</h6>
                        <h2 class="fw-bold mb-0">${totalVideos} Videos</h2>
                        <small class="opacity-75">Nội dung trực tuyến</small>
                    </div>
                    <i class="bi bi-camera-video-fill display-4 opacity-50"></i>
                </div>
                <div class="mt-3 pt-3 border-top border-white border-opacity-25">
                    <a href="${pageContext.request.contextPath}/videos" target="_blank" class="text-white text-decoration-none small fw-semibold">
                        Xem trang video người dùng <i class="bi bi-box-arrow-up-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 bg-dark text-white p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase opacity-75 mb-2">Số Lượng Danh Mục</h6>
                        <h2 class="fw-bold mb-0">${totalCategories} Danh Mục</h2>
                        <small class="opacity-75">Phân loại nội dung</small>
                    </div>
                    <i class="bi bi-folder-fill display-4 opacity-50"></i>
                </div>
                <div class="mt-3 pt-3 border-top border-white border-opacity-25">
                    <span class="text-white opacity-75 small">Âm Nhạc, Phim Ảnh, Công Nghệ...</span>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
