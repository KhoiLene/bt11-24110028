<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Đặt Hàng - UTE SHOP</title>
    <style>
        .nav-status .nav-link {
            color: #495057;
            font-weight: 500;
            border-radius: 20px;
            padding: 8px 16px;
            margin: 2px 4px;
            transition: all 0.2s;
            white-space: nowrap;
        }
        .nav-status .nav-link:hover {
            background-color: #e9ecef;
            color: #0d6efd;
        }
        .nav-status .nav-link.active {
            background-color: #0d6efd;
            color: #fff !important;
            font-weight: 600;
            box-shadow: 0 2px 6px rgba(13,110,253,0.3);
        }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
        <div>
            <h2 class="fw-bold mb-1 text-dark"><i class="bi bi-clock-history text-primary me-2"></i>Lịch Sử Đơn Hàng Của Bạn</h2>
            <p class="text-muted mb-0">Theo dõi tiến độ đơn hàng theo thời gian thực và quản lý các đơn đã đặt</p>
        </div>
        <a href="${pageContext.request.contextPath}/videos" class="btn btn-outline-danger rounded-pill">
            <i class="bi bi-bag-plus me-1"></i>Tiếp tục mua hàng
        </a>
    </div>

    <!-- Alert thông báo hướng dẫn database -->
    <div class="alert alert-info border-0 shadow-sm rounded-4 mb-4">
        <div class="d-flex align-items-center">
            <i class="bi bi-info-circle-fill fs-4 me-3 text-info"></i>
            <div>
                <strong>Hướng dẫn kiểm tra chức năng:</strong> Bạn có thể vào Database SQL Server (bảng <code>Orders</code>) cập nhật cột <code>Status</code> hoặc dùng giao diện Quản Trị Admin để đổi trạng thái và lọc quan sát đơn hàng thay đổi theo 8 trạng thái tương ứng.
            </div>
        </div>
    </div>

    <!-- Thanh bộ lọc 8 trạng thái -->
    <div class="card border-0 shadow-sm rounded-4 p-3 mb-4">
        <div class="d-flex overflow-auto nav-status py-1">
            <a href="${pageContext.request.contextPath}/orders?status=ALL" 
               class="nav-link ${selectedStatus == 'ALL' or empty selectedStatus ? 'active' : ''}">
                <i class="bi bi-grid-fill me-1"></i>Tất cả
            </a>
            <c:forEach var="st" items="${statuses}">
                <a href="${pageContext.request.contextPath}/orders?status=${st}" 
                   class="nav-link ${selectedStatus == st ? 'active' : ''}">
                    ${st}
                </a>
            </c:forEach>
        </div>
    </div>

    <!-- Danh sách đơn hàng -->
    <c:choose>
        <c:when test="${empty orders}">
            <div class="text-center py-5 bg-white rounded-4 shadow-sm p-5 my-3">
                <i class="bi bi-inbox text-muted" style="font-size: 4rem;"></i>
                <h5 class="fw-bold mt-3 text-secondary">Chưa có đơn hàng nào trong trạng thái này</h5>
                <p class="text-muted">
                    <c:choose>
                        <c:when test="${selectedStatus != 'ALL' and not empty selectedStatus}">
                            Không tìm thấy đơn hàng nào ở trạng thái "<strong>${selectedStatus}</strong>".
                        </c:when>
                        <c:otherwise>
                            Bạn chưa đặt đơn hàng nào. Hãy khám phá các sản phẩm ngay!
                        </c:otherwise>
                    </c:choose>
                </p>
                <a href="${pageContext.request.contextPath}/videos" class="btn btn-danger rounded-pill px-4 mt-2">
                    <i class="bi bi-cart3 me-1"></i>Mua Sắm Ngay
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach var="order" items="${orders}">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                            <!-- Header đơn hàng -->
                            <div class="card-header bg-light d-flex justify-content-between align-items-center py-3 px-4 flex-wrap gap-2">
                                <div>
                                    <span class="fw-bold text-dark me-2">Mã Đơn: <span class="text-danger">#${order.orderId}</span></span>
                                    <span class="text-muted small">
                                        <i class="bi bi-calendar3 me-1"></i><fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </span>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-secondary rounded-pill">${order.paymentMethod}</span>
                                    <span class="badge ${order.statusBadgeClass} fs-6 px-3 py-1 rounded-pill">${order.status}</span>
                                </div>
                            </div>

                            <!-- Body đơn hàng: Thông tin nhận hàng & Danh sách món -->
                            <div class="card-body p-4">
                                <div class="row g-3">
                                    <div class="col-md-4 border-end-md">
                                        <h6 class="fw-bold text-muted small text-uppercase mb-2"><i class="bi bi-person-lines-fill me-1"></i>Thông tin người nhận</h6>
                                        <p class="mb-1 fw-bold text-dark">${order.customerName}</p>
                                        <p class="mb-1 text-muted small"><i class="bi bi-telephone me-1"></i>${order.phone}</p>
                                        <p class="mb-1 text-muted small"><i class="bi bi-geo-alt me-1"></i>${order.address}</p>
                                        <c:if test="${not empty order.note}">
                                            <p class="mb-0 text-muted small fst-italic"><i class="bi bi-chat-left-dots me-1"></i>${order.note}</p>
                                        </c:if>
                                    </div>
                                    <div class="col-md-8">
                                        <h6 class="fw-bold text-muted small text-uppercase mb-2"><i class="bi bi-bag-check me-1"></i>Sản phẩm đã đặt</h6>
                                        <div class="list-group list-group-flush">
                                            <c:forEach var="item" items="${order.details}">
                                                <div class="list-group-item px-0 py-2 border-bottom d-flex align-items-center justify-content-between">
                                                    <div class="d-flex align-items-center gap-3">
                                                        <a href="${pageContext.request.contextPath}/videos/detail?id=${item.video.videoId}">
                                                            <img src="${item.video.poster}" alt="${item.video.title}" 
                                                                 class="rounded-3 object-fit-cover shadow-sm" width="55" height="55"
                                                                 onerror="this.src='https://placehold.co/55x55?text=SP'">
                                                        </a>
                                                        <div>
                                                            <a href="${pageContext.request.contextPath}/videos/detail?id=${item.video.videoId}" 
                                                               class="text-decoration-none text-dark fw-semibold">
                                                                ${item.video.title}
                                                            </a>
                                                            <small class="text-muted d-block">
                                                                <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/> 
                                                                x <strong>${item.quantity}</strong>
                                                            </small>
                                                        </div>
                                                    </div>
                                                    <span class="fw-bold text-danger">
                                                        <fmt:formatNumber value="${item.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                    </span>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Footer đơn hàng: Tổng tiền -->
                            <div class="card-footer bg-white px-4 py-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
                                <span class="text-muted small">Phương thức: <strong>Thanh toán tiền mặt khi giao hàng (COD)</strong></span>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="text-muted">Tổng thanh toán:</span>
                                    <span class="fs-5 fw-bold text-danger">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
