<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập - Hệ Thống Video</title>
</head>
<body>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="bg-primary text-white p-4 text-center">
                    <i class="bi bi-person-circle fs-1 mb-2"></i>
                    <h4 class="fw-bold mb-1">ĐĂNG NHẬP</h4>
                    <p class="mb-0 small opacity-75">Sử dụng tài khoản để truy cập hệ thống</p>
                </div>
                <div class="card-body p-4 p-md-5">

                    <!-- Thông báo lỗi -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Thông báo thành công -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label fw-semibold">Tên đăng nhập (Username):</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Nhập username (ví dụ: admin)" required autofocus>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label fw-semibold">Mật khẩu (Password):</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-key"></i></span>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu (ví dụ: 123)" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2 fw-bold rounded-pill mb-3">
                            <i class="bi bi-box-arrow-in-right me-2"></i>Đăng Nhập
                        </button>
                    </form>

                    <div class="alert alert-light border small text-muted mb-4">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-info-circle me-1"></i>Tài khoản đăng nhập hệ thống:</div>
                        <div>• Quản Trị Viên: <code>admin</code> / <code>12102006</code> (vào Trang Quản Trị)</div>
                        <div class="mt-1 text-secondary">• Người dùng thường: <code>lekhoi</code> / <code>12102006</code> (không có quyền admin)</div>
                    </div>

                    <div class="text-center border-top pt-3">
                        <span class="text-muted">Chưa có tài khoản?</span>
                        <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-primary text-decoration-none ms-1">
                            Đăng ký mới (Kích hoạt OTP)
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
