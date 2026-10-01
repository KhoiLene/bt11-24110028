<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${isEdit ? 'Chỉnh Sửa Sản Phẩm' : 'Đăng Bán Sản Phẩm Mới'} - UTE SHOP Admin</title>
</head>
<body>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <div>
                    <h3 class="fw-bold mb-1 text-dark">
                        <i class="bi ${isEdit ? 'bi-pencil-square text-primary' : 'bi-plus-circle text-danger'} me-2"></i>
                        ${isEdit ? 'Chỉnh Sửa Thông Tin Sản Phẩm' : 'Đăng Bán Sản Phẩm Mới'}
                    </h3>
                    <p class="text-muted mb-0">Quản lý nội dung video và giá bán sản phẩm</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary rounded-pill">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
                </a>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5">
                <form action="${pageContext.request.contextPath}/admin/products/${isEdit ? 'edit' : 'add'}" method="post">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="videoId" class="form-label fw-semibold">Mã Sản Phẩm / Video ID <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="videoId" name="videoId" 
                                   value="${product.videoId}" ${isEdit ? 'readonly' : 'required'} 
                                   placeholder="Ví dụ: SP18 hoặc dQw4w9WgXcQ">
                            <small class="text-muted">Mã định danh sản phẩm hoặc ID Youtube</small>
                        </div>

                        <div class="col-md-6">
                            <label for="categoryId" class="form-label fw-semibold">Danh Mục Sản Phẩm</label>
                            <select class="form-select" id="categoryId" name="categoryId">
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.categoryId}" ${product.categoryId == cat.categoryId ? 'selected' : ''}>
                                        ${cat.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-12">
                            <label for="title" class="form-label fw-semibold">Tên Sản Phẩm <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   value="${product.title}" placeholder="Nhập tên sản phẩm hiển thị..." required>
                        </div>

                        <div class="col-md-6">
                            <label for="price" class="form-label fw-semibold">Đơn Giá Bán (VNĐ) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="number" step="1000" min="0" class="form-control" id="price" name="price" 
                                       value="${product.price}" required placeholder="0">
                                <span class="input-group-text">₫</span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold d-block">Trạng Thái Kinh Doanh</label>
                            <div class="form-check form-switch mt-2">
                                <input class="form-check-input" type="checkbox" id="active" name="active" value="true" 
                                       ${product.active ? 'checked' : ''}>
                                <label class="form-check-label" for="active">Hiển thị bán trên website</label>
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="poster" class="form-label fw-semibold">Đường Dẫn Hình Ảnh / Poster (URL)</label>
                            <input type="text" class="form-control" id="poster" name="poster" 
                                   value="${product.poster}" placeholder="https://images.unsplash.com/...">
                            <small class="text-muted">Dán link ảnh đại diện cho sản phẩm</small>
                        </div>

                        <div class="col-12">
                            <label for="description" class="form-label fw-semibold">Mô Tả Sản Phẩm</label>
                            <textarea class="form-control" id="description" name="description" rows="4" 
                                      placeholder="Mô tả thông số, tính năng nổi bật của sản phẩm...">${product.description}</textarea>
                        </div>

                        <div class="col-12 mt-4 d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary rounded-pill px-4">
                                Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-primary rounded-pill px-5 fw-bold shadow-sm">
                                <i class="bi bi-save me-1"></i>${isEdit ? 'Lưu Thay Đổi' : 'Đăng Bán Ngay'}
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
