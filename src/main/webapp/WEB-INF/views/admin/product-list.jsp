<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Sản Phẩm Video - UTE SHOP Admin</title>
</head>
<body>
<div class="container-fluid py-4 px-md-5">
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <h3 class="fw-bold mb-1 text-dark"><i class="bi bi-box-seam-fill text-primary me-2"></i>Quản Lý Sản Phẩm Bán Hàng Qua Video</h3>
            <p class="text-muted mb-0">Thêm mới, sửa đổi thông tin giá, video demo và trạng thái kinh doanh của sản phẩm</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/products/add" class="btn btn-danger rounded-pill px-4 shadow-sm">
            <i class="bi bi-plus-circle me-1"></i>Đăng Bán Sản Phẩm Mới
        </a>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Bảng danh sách sản phẩm -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-4">Mã SP</th>
                        <th>Hình Ảnh</th>
                        <th>Tên Sản Phẩm</th>
                        <th class="text-end">Đơn Giá Bán</th>
                        <th class="text-center">Lượt Xem Video</th>
                        <th class="text-center">Trạng Thái</th>
                        <th class="text-center pe-4" style="width: 140px;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty products}">
                            <tr>
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="bi bi-box2 fs-1 d-block mb-2"></i>
                                    Chưa có sản phẩm nào trong hệ thống!
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${products}">
                                <tr>
                                    <td class="ps-4 fw-bold text-dark">${p.videoId}</td>
                                    <td>
                                        <img src="${p.poster}" alt="${p.title}" class="rounded-3 object-fit-cover shadow-sm" 
                                             width="50" height="50" onerror="this.src='https://placehold.co/50x50?text=SP'">
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark">${p.title}</div>
                                        <small class="text-muted line-clamp-1" style="max-width: 320px;">${p.description}</small>
                                    </td>
                                    <td class="text-end fw-bold text-danger">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge bg-light text-dark border">
                                            <i class="bi bi-eye me-1"></i>${p.views}
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${p.active}">
                                                <span class="badge bg-success rounded-pill px-3">Đang bán</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary rounded-pill px-3">Ngừng bán</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center pe-4">
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="${pageContext.request.contextPath}/admin/products/edit?id=${p.videoId}" 
                                               class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/products/delete?id=${p.videoId}" 
                                               class="btn btn-sm btn-outline-danger" title="Xóa"
                                               onclick="return confirm('Bạn có chắc muốn xóa sản phẩm ${p.videoId}?');">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
