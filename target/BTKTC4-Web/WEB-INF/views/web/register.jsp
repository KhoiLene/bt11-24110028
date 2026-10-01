<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Ký Tài Khoản - Kích Hoạt Bằng OTP Qua Mail</title>
    <style>
        .rule-valid {
            color: #198754 !important;
            font-weight: 600;
            transition: all 0.2s ease-in-out;
        }
        .rule-valid .rule-icon {
            color: #198754 !important;
            font-size: 1.1rem;
            filter: drop-shadow(0 0 4px #25d366);
        }
        .rule-checklist-box {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            transition: all 0.3s ease-in-out;
        }
        .rule-checklist-glow {
            background-color: #e8f5e9 !important;
            border-color: #81c784 !important;
            box-shadow: 0 0 12px rgba(46, 125, 50, 0.25);
        }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="bg-success text-white p-4 text-center">
                    <i class="bi bi-person-plus-fill fs-1 mb-2"></i>
                    <h4 class="fw-bold mb-1">ĐĂNG KÝ TÀI KHOẢN</h4>
                    <p class="mb-0 small opacity-75">Kích hoạt tài khoản bằng mã OTP gửi qua Email</p>
                </div>
                <div class="card-body p-4 p-md-5">

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateBeforeSubmit();">
                        <div class="mb-3">
                            <label for="username" class="form-label fw-semibold">Tên đăng nhập (Username): <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="username" name="username" placeholder="Nhập tên đăng nhập" required autofocus>
                        </div>

                        <!-- Mật khẩu với Checklist xác thực trực tiếp (Sáng xanh lá khi đúng yêu cầu) -->
                        <div class="mb-3">
                            <label for="password" class="form-label fw-semibold">Mật khẩu: <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Tối thiểu 8 ký tự, gồm hoa, thường, số" required 
                                       oninput="checkPasswordRules(this.value)">
                                <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordView()">
                                    <i class="bi bi-eye" id="toggleIcon"></i>
                                </button>
                            </div>

                            <!-- Hộp checklist điều kiện mật khẩu -->
                            <div class="p-3 mt-2 rounded-3 rule-checklist-box" id="passwordChecklist">
                                <div class="small fw-bold text-secondary mb-2 d-flex justify-content-between align-items-center">
                                    <span><i class="bi bi-shield-lock-fill me-1"></i>Yêu cầu bảo mật mật khẩu:</span>
                                    <span id="passStatusBadge" class="badge bg-secondary">Chưa đạt</span>
                                </div>
                                <ul class="list-unstyled mb-0 small">
                                    <li id="rule-length" class="text-muted d-flex align-items-center gap-2 py-1">
                                        <i class="bi bi-circle rule-icon text-secondary"></i>
                                        <span class="rule-text">Tối thiểu <strong>8 ký tự</strong></span>
                                    </li>
                                    <li id="rule-upper" class="text-muted d-flex align-items-center gap-2 py-1">
                                        <i class="bi bi-circle rule-icon text-secondary"></i>
                                        <span class="rule-text">Có ít nhất 1 chữ cái <strong>in hoa (A-Z)</strong></span>
                                    </li>
                                    <li id="rule-lower" class="text-muted d-flex align-items-center gap-2 py-1">
                                        <i class="bi bi-circle rule-icon text-secondary"></i>
                                        <span class="rule-text">Có ít nhất 1 chữ cái <strong>in thường (a-z)</strong></span>
                                    </li>
                                    <li id="rule-number" class="text-muted d-flex align-items-center gap-2 py-1">
                                        <i class="bi bi-circle rule-icon text-secondary"></i>
                                        <span class="rule-text">Có ít nhất 1 <strong>chữ số (0-9)</strong></span>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="fullname" class="form-label fw-semibold">Họ và tên: <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Nhập họ và tên đầy đủ" required>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">Email nhận mã OTP: <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="example@gmail.com" required>
                            <div class="form-text">Mã OTP 6 chữ số sẽ được gửi đến email này để kích hoạt.</div>
                        </div>

                        <div class="mb-4">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại:</label>
                            <input type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại">
                        </div>

                        <button type="submit" id="submitBtn" class="btn btn-success w-100 py-2 fw-bold rounded-pill mb-3">
                            <i class="bi bi-send me-2"></i>Gửi Mã OTP & Tiếp Tục
                        </button>
                    </form>

                    <div class="text-center border-top pt-3">
                        <span class="text-muted">Đã có tài khoản?</span>
                        <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-primary text-decoration-none ms-1">
                            Đăng nhập ngay
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function checkPasswordRules(pwd) {
        var isLen = pwd.length >= 8;
        var isUp = /[A-Z]/.test(pwd);
        var isLow = /[a-z]/.test(pwd);
        var isNum = /[0-9]/.test(pwd);

        setRuleStatus('rule-length', isLen);
        setRuleStatus('rule-upper', isUp);
        setRuleStatus('rule-lower', isLow);
        setRuleStatus('rule-number', isNum);

        var box = document.getElementById('passwordChecklist');
        var badge = document.getElementById('passStatusBadge');

        if (isLen && isUp && isLow && isNum) {
            box.classList.add('rule-checklist-glow');
            badge.className = 'badge bg-success';
            badge.innerText = 'Hợp lệ ✓';
        } else {
            box.classList.remove('rule-checklist-glow');
            badge.className = 'badge bg-secondary';
            badge.innerText = 'Chưa đạt';
        }
    }

    function setRuleStatus(id, valid) {
        var item = document.getElementById(id);
        if (!item) return;
        var icon = item.querySelector('.rule-icon');
        if (valid) {
            item.classList.add('rule-valid');
            item.classList.remove('text-muted');
            if (icon) {
                icon.className = 'bi bi-check-circle-fill rule-icon text-success';
            }
        } else {
            item.classList.remove('rule-valid');
            item.classList.add('text-muted');
            if (icon) {
                icon.className = 'bi bi-circle rule-icon text-secondary';
            }
        }
    }

    function validateBeforeSubmit() {
        var pwd = document.getElementById('password').value;
        var isLen = pwd.length >= 8;
        var isUp = /[A-Z]/.test(pwd);
        var isLow = /[a-z]/.test(pwd);
        var isNum = /[0-9]/.test(pwd);

        if (!isLen || !isUp || !isLow || !isNum) {
            alert('Mật khẩu chưa đáp ứng đủ yêu cầu:\n- Tối thiểu 8 ký tự\n- Có chữ hoa (A-Z)\n- Có chữ thường (a-z)\n- Có chữ số (0-9)');
            document.getElementById('password').focus();
            return false;
        }
        return true;
    }

    function togglePasswordView() {
        var pwdInput = document.getElementById('password');
        var icon = document.getElementById('toggleIcon');
        if (pwdInput.type === 'password') {
            pwdInput.type = 'text';
            icon.className = 'bi bi-eye-slash';
        } else {
            pwdInput.type = 'password';
            icon.className = 'bi bi-eye';
        }
    }
</script>
</body>
</html>
