<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${mode == 'create' ? 'Thêm Người Dùng Mới' : 'Cập Nhật Người Dùng'} - Quản Trị</title>
</head>
<body>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold mb-0 text-primary">
                        <i class="bi ${mode == 'create' ? 'bi-person-plus-fill' : 'bi-person-gear'} me-2"></i>
                        ${mode == 'create' ? 'Thêm Người Dùng Mới (Create)' : 'Cập Nhật Thông Tin Người Dùng (Update)'}
                    </h5>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary btn-sm rounded-pill">
                        <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
                    </a>
                </div>
                <div class="card-body p-4">

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/users/${mode}" method="post">
                        <div class="row g-3">
                            <!-- Username -->
                            <div class="col-md-6">
                                <label for="username" class="form-label fw-semibold">Tên đăng nhập (Username): <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="username" name="username" 
                                       value="${user.username}" 
                                       ${mode == 'edit' ? 'readonly' : 'required'} 
                                       placeholder="Nhập username">
                                <c:if test="${mode == 'edit'}">
                                    <div class="form-text text-muted">Không thể thay đổi tên đăng nhập.</div>
                                </c:if>
                            </div>

                            <!-- Password -->
                            <div class="col-md-6">
                                <label for="password" class="form-label fw-semibold">
                                    Mật khẩu (Password): 
                                    <c:choose>
                                        <c:when test="${mode == 'create'}"><span class="text-danger">*</span></c:when>
                                        <c:otherwise><span class="text-muted small">(Để trống nếu giữ nguyên)</span></c:otherwise>
                                    </c:choose>
                                </label>
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="${mode == 'create' ? 'Nhập mật khẩu' : 'Nhập mật khẩu mới (nếu muốn đổi)'}" 
                                       ${mode == 'create' ? 'required' : ''}>
                            </div>

                            <!-- Fullname -->
                            <div class="col-md-6">
                                <label for="fullname" class="form-label fw-semibold">Họ và tên đầy đủ: <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="fullname" name="fullname" 
                                       value="${user.fullname}" required placeholder="Ví dụ: Nguyễn Văn An">
                            </div>

                            <!-- Email -->
                            <div class="col-md-6">
                                <label for="email" class="form-label fw-semibold">Địa chỉ Email: <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="${user.email}" required placeholder="user@gmail.com">
                            </div>

                            <!-- Phone -->
                            <div class="col-md-6">
                                <label for="phone" class="form-label fw-semibold">Số điện thoại:</label>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       value="${user.phone}" placeholder="0912345678">
                            </div>

                            <!-- Images URL -->
                            <div class="col-md-6">
                                <label for="images" class="form-label fw-semibold">Hình ảnh Avatar (URL):</label>
                                <input type="url" class="form-control" id="images" name="images" 
                                       value="${user.images}" placeholder="https://example.com/avatar.jpg">
                            </div>

                            <!-- Admin & Active Checkboxes -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold d-block">Vai trò hệ thống:</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="checkbox" id="admin" name="admin" value="true" ${user.admin ? 'checked' : ''}>
                                    <label class="form-check-label fw-bold text-danger" for="admin">
                                        <i class="bi bi-shield-lock-fill me-1"></i>Là Quản Trị Viên (Admin)
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold d-block">Trạng thái kích hoạt:</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="checkbox" id="active" name="active" value="true" ${user == null or user.active ? 'checked' : ''}>
                                    <label class="form-check-label fw-bold text-success" for="active">
                                        <i class="bi bi-check-circle-fill me-1"></i>Đã kích hoạt tài khoản (Active)
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 pt-3 border-top d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary px-4 rounded-pill">
                                Hủy Bỏ
                            </a>
                            <button type="submit" class="btn btn-primary px-4 rounded-pill fw-bold">
                                <i class="bi bi-save me-1"></i>${mode == 'create' ? 'Tạo Người Dùng' : 'Lưu Thay Đổi'}
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
