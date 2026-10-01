<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng Mua Sắm - UTE SHOP</title>
</head>
<body>
<div class="container py-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h2 class="fw-bold mb-1 text-dark"><i class="bi bi-cart3 text-danger me-2"></i>Giỏ Hàng Của Bạn</h2>
            <p class="text-muted mb-0">Xem và điều chỉnh các sản phẩm đã chọn trước khi thanh toán</p>
        </div>
        <a href="${pageContext.request.contextPath}/videos" class="btn btn-outline-primary rounded-pill">
            <i class="bi bi-arrow-left me-1"></i>Tiếp tục xem sản phẩm
        </a>
    </div>

    <!-- Thông báo -->
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
    <c:if test="${not empty warningMessage}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-circle-fill me-2"></i>${warningMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty cart or empty cart.items or cart.totalQuantity == 0}">
            <div class="text-center py-5 bg-white rounded-4 shadow-sm p-5 my-3">
                <i class="bi bi-cart-x text-muted" style="font-size: 5rem;"></i>
                <h4 class="fw-bold mt-3 text-secondary">Giỏ hàng của bạn đang trống</h4>
                <p class="text-muted">Hãy xem các video giới thiệu sản phẩm và bấm "Thêm vào giỏ" để mua sắm ngay nhé!</p>
                <a href="${pageContext.request.contextPath}/videos" class="btn btn-danger btn-lg rounded-pill px-5 mt-2">
                    <i class="bi bi-bag-plus me-2"></i>Khám Phá Sản Phẩm Ngay
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <!-- Danh sách sản phẩm trong giỏ -->
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                        <div class="table-responsive">
                            <table class="table align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th scope="col" class="ps-4">Sản Phẩm</th>
                                        <th scope="col" class="text-center">Đơn Giá</th>
                                        <th scope="col" class="text-center" style="width: 170px;">Số Lượng (1-99)</th>
                                        <th scope="col" class="text-end">Thành Tiền</th>
                                        <th scope="col" class="text-center" style="width: 60px;">Xóa</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${cart.items}">
                                        <tr>
                                            <td class="ps-4">
                                                <div class="d-flex align-items-center gap-3">
                                                    <a href="${pageContext.request.contextPath}/videos/detail?id=${item.video.videoId}">
                                                        <img src="${item.video.poster}" alt="${item.video.title}" 
                                                             class="rounded-3 object-fit-cover shadow-sm" width="70" height="70"
                                                             onerror="this.src='https://placehold.co/70x70?text=SP'">
                                                    </a>
                                                    <div>
                                                        <a href="${pageContext.request.contextPath}/videos/detail?id=${item.video.videoId}" 
                                                           class="text-decoration-none text-dark fw-semibold line-clamp-2">
                                                            ${item.video.title}
                                                        </a>
                                                        <small class="text-muted d-block">Mã SP: ${item.video.videoId}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center fw-semibold text-danger">
                                                <fmt:formatNumber value="${item.video.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </td>
                                            <td class="text-center">
                                                <div class="d-flex align-items-center justify-content-center gap-1">
                                                    <!-- Giảm 1 -->
                                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-inline">
                                                        <input type="hidden" name="videoId" value="${item.video.videoId}">
                                                        <input type="hidden" name="quantity" value="${item.quantity - 1}">
                                                        <button type="submit" class="btn btn-sm btn-outline-secondary px-2 py-1 rounded" 
                                                                ${item.quantity le 1 ? 'disabled' : ''}>
                                                            <i class="bi bi-dash"></i>
                                                        </button>
                                                    </form>

                                                    <!-- Ô nhập số lượng trực tiếp -->
                                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-inline">
                                                        <input type="hidden" name="videoId" value="${item.video.videoId}">
                                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="99" 
                                                               class="form-control form-control-sm text-center fw-bold" 
                                                               style="width: 55px;" onchange="this.form.submit()">
                                                    </form>

                                                    <!-- Tăng 1 -->
                                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-inline">
                                                        <input type="hidden" name="videoId" value="${item.video.videoId}">
                                                        <input type="hidden" name="quantity" value="${item.quantity + 1}">
                                                        <button type="submit" class="btn btn-sm btn-outline-secondary px-2 py-1 rounded"
                                                                ${item.quantity ge 99 ? 'disabled' : ''}>
                                                            <i class="bi bi-plus"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                            <td class="text-end fw-bold text-dark">
                                                <fmt:formatNumber value="${item.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/cart/remove?videoId=${item.video.videoId}" 
                                                   class="btn btn-sm btn-outline-danger border-0 rounded-circle" 
                                                   title="Xóa khỏi giỏ" onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?');">
                                                    <i class="bi bi-trash3"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="card-footer bg-white d-flex justify-content-between align-items-center py-3">
                            <a href="${pageContext.request.contextPath}/cart/clear" class="btn btn-sm btn-outline-secondary"
                               onclick="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?');">
                                <i class="bi bi-trash me-1"></i>Xóa toàn bộ giỏ
                            </a>
                            <small class="text-muted"><i class="bi bi-info-circle me-1"></i>Giới hạn số lượng từ 1 đến 99 sản phẩm mỗi loại</small>
                        </div>
                    </div>
                </div>

                <!-- Cột tóm tắt & Thanh toán -->
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm rounded-4 p-4 sticky-top" style="top: 90px;">
                        <h5 class="fw-bold mb-3 text-dark">Tóm Tắt Đơn Hàng</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tổng số lượng sản phẩm:</span>
                            <span class="fw-semibold">${cart.totalQuantity} món</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tạm tính:</span>
                            <span class="fw-semibold">
                                <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Phí giao hàng:</span>
                            <span class="text-success fw-semibold">Miễn phí (COD)</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="fs-5 fw-bold text-dark">Tổng Thanh Toán:</span>
                            <span class="fs-4 fw-bold text-danger">
                                <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-danger btn-lg rounded-pill fw-bold w-100 py-3 shadow-sm">
                            <i class="bi bi-cash-coin me-2"></i>Thanh Toán Khi Nhận Hàng (COD)
                        </a>
                        <div class="mt-3 text-center">
                            <small class="text-muted"><i class="bi bi-shield-check text-success me-1"></i>Thanh toán tiền mặt tận nơi khi nhận hàng an toàn 100%</small>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
