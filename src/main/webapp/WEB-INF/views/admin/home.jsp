<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng Điều Khiển Quản Trị Hệ Thống - UTE SHOP</title>
</head>
<body>
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1 text-dark">Bảng Điều Khiển Quản Trị Hệ Thống</h3>
            <p class="text-muted mb-0">Quản lý bán hàng qua video, xử lý đơn hàng COD và phân quyền người dùng</p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin/products/add" class="btn btn-danger rounded-pill px-3">
                <i class="bi bi-plus-circle me-1"></i>Đăng Bán Sản Phẩm
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-success rounded-pill px-3">
                <i class="bi bi-cart-check me-1"></i>Xử Lý Đơn Hàng
            </a>
        </div>
    </div>

    <!-- Thống kê tổng quan 4 thẻ -->
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-4 bg-danger text-white p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase opacity-75 mb-2">Đơn Hàng</h6>
                        <h2 class="fw-bold mb-0">${totalOrders} Đơn</h2>
                        <small class="opacity-75">Quản lý 8 trạng thái</small>
                    </div>
                    <i class="bi bi-receipt display-5 opacity-50"></i>
                </div>
                <div class="mt-3 pt-3 border-top border-white border-opacity-25">
                    <a href="${pageContext.request.contextPath}/admin/orders" class="text-white text-decoration-none small fw-semibold">
                        Xem đơn hàng <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-4 bg-success text-white p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase opacity-75 mb-2">Sản Phẩm Video</h6>
                        <h2 class="fw-bold mb-0">${totalVideos} SP</h2>
                        <small class="opacity-75">Bán hàng qua video</small>
                    </div>
                    <i class="bi bi-bag-check-fill display-5 opacity-50"></i>
                </div>
                <div class="mt-3 pt-3 border-top border-white border-opacity-25">
                    <a href="${pageContext.request.contextPath}/admin/products" class="text-white text-decoration-none small fw-semibold">
                        Quản lý sản phẩm <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-4 bg-primary text-white p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase opacity-75 mb-2">Người Dùng</h6>
                        <h2 class="fw-bold mb-0">${totalUsers} Users</h2>
                        <small class="opacity-75">Tài khoản & phân quyền</small>
                    </div>
                    <i class="bi bi-people-fill display-5 opacity-50"></i>
                </div>
                <div class="mt-3 pt-3 border-top border-white border-opacity-25">
                    <a href="${pageContext.request.contextPath}/admin/users" class="text-white text-decoration-none small fw-semibold">
                        Quản lý users <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-4 bg-dark text-white p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase opacity-75 mb-2">Danh Mục</h6>
                        <h2 class="fw-bold mb-0">${totalCategories} Mục</h2>
                        <small class="opacity-75">Ngành hàng thương mại</small>
                    </div>
                    <i class="bi bi-folder-fill display-5 opacity-50"></i>
                </div>
                <div class="mt-3 pt-3 border-top border-white border-opacity-25">
                    <span class="text-white opacity-75 small">Gia dụng, công nghệ...</span>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
