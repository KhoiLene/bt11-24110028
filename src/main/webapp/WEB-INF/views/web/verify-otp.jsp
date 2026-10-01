<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xác Thực Mã OTP - Kích Hoạt Tài Khoản</title>
</head>
<body>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="bg-warning text-dark p-4 text-center">
                    <i class="bi bi-shield-check fs-1 mb-2"></i>
                    <h4 class="fw-bold mb-1">XÁC THỰC MÃ OTP</h4>
                    <p class="mb-0 small">Kích hoạt tài khoản người dùng</p>
                </div>
                <div class="card-body p-4 p-md-5">

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <div class="alert alert-info border-0 mb-4">
                        <i class="bi bi-envelope-check me-2"></i>Mã OTP 6 chữ số đã được gửi tới địa chỉ: <br>
                        <strong>${sessionScope.otpEmail}</strong>
                    </div>

                    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                        <div class="mb-4">
                            <label for="otp" class="form-label fw-semibold text-center w-100">Nhập Mã OTP gồm 6 chữ số:</label>
                            <input type="text" class="form-control form-control-lg text-center fw-bold letter-spacing-2" 
                                   id="otp" name="otp" maxlength="6" placeholder="______" required autofocus style="letter-spacing: 6px; font-size: 1.5rem;">
                        </div>

                        <button type="submit" class="btn btn-warning w-100 py-2 fw-bold rounded-pill mb-3">
                            <i class="bi bi-check2-circle me-2"></i>Kích Hoạt Tài Khoản
                        </button>
                    </form>

                    <div class="text-center border-top pt-3">
                        <a href="${pageContext.request.contextPath}/register" class="text-muted text-decoration-none small">
                            <i class="bi bi-arrow-left me-1"></i>Đăng ký lại thông tin khác
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
