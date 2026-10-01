<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Đơn Hàng - UTE SHOP Admin</title>
</head>
<body>
<div class="container-fluid py-4 px-md-5">
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <h3 class="fw-bold mb-1 text-dark"><i class="bi bi-cart-check-fill text-danger me-2"></i>Quản Lý Đơn Hàng</h3>
            <p class="text-muted mb-0">Theo dõi, lọc theo 8 trạng thái và cập nhật tiến độ xử lý đơn hàng COD</p>
        </div>
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

    <!-- Bộ lọc 8 trạng thái -->
    <div class="card border-0 shadow-sm rounded-4 p-3 mb-4">
        <div class="d-flex overflow-auto gap-2 pb-1">
            <a href="${pageContext.request.contextPath}/admin/orders?status=ALL" 
               class="btn btn-sm ${selectedStatus == 'ALL' or empty selectedStatus ? 'btn-primary' : 'btn-outline-secondary'} rounded-pill px-3">
                <i class="bi bi-grid-fill me-1"></i>Tất cả (${orders.size()})
            </a>
            <c:forEach var="st" items="${statuses}">
                <a href="${pageContext.request.contextPath}/admin/orders?status=${st}" 
                   class="btn btn-sm ${selectedStatus == st ? 'btn-primary' : 'btn-outline-secondary'} rounded-pill px-3 text-nowrap">
                    ${st}
                </a>
            </c:forEach>
        </div>
    </div>

    <!-- Bảng danh sách đơn hàng -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-4">Mã Đơn</th>
                        <th>Khách Hàng & SĐT</th>
                        <th>Địa Chỉ Giao Hàng</th>
                        <th>Chi Tiết Sản Phẩm</th>
                        <th class="text-end">Tổng Tiền COD</th>
                        <th class="text-center">Trạng Thái Hiện Tại</th>
                        <th class="text-center pe-4" style="min-width: 220px;">Cập Nhật Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty orders}">
                            <tr>
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                    Không tìm thấy đơn hàng nào thuộc trạng thái này!
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <td class="ps-4">
                                        <span class="fw-bold text-danger">#${o.orderId}</span>
                                        <small class="text-muted d-block">
                                            <fmt:formatDate value="${o.createdDate}" pattern="dd/MM HH:mm"/>
                                        </small>
                                        <span class="badge bg-light text-dark border">${o.paymentMethod}</span>
                                    </td>
                                    <td>
                                        <strong class="text-dark d-block">${o.customerName}</strong>
                                        <small class="text-muted"><i class="bi bi-telephone me-1"></i>${o.phone}</small>
                                        <c:if test="${not empty o.username}">
                                            <small class="text-primary d-block">TK: ${o.username}</small>
                                        </c:if>
                                    </td>
                                    <td>
                                        <small class="text-dark d-block" style="max-width: 200px;">${o.address}</small>
                                        <c:if test="${not empty o.note}">
                                            <small class="text-muted fst-italic d-block">Note: ${o.note}</small>
                                        </c:if>
                                    </td>
                                    <td>
                                        <ul class="list-unstyled mb-0 small" style="max-width: 250px;">
                                            <c:forEach var="item" items="${o.details}">
                                                <li class="d-flex align-items-center gap-2 mb-1">
                                                    <span class="badge bg-secondary">x${item.quantity}</span>
                                                    <span class="text-truncate">${item.video.title}</span>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </td>
                                    <td class="text-end fw-bold text-danger">
                                        <fmt:formatNumber value="${o.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge ${o.statusBadgeClass} px-3 py-2 rounded-pill">${o.status}</span>
                                    </td>
                                    <td class="text-center pe-4">
                                        <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="post" class="d-flex gap-1 justify-content-center">
                                            <input type="hidden" name="orderId" value="${o.orderId}">
                                            <input type="hidden" name="returnStatus" value="${selectedStatus}">
                                            <select name="newStatus" class="form-select form-select-sm" style="width: 150px;">
                                                <c:forEach var="stOption" items="${statuses}">
                                                    <option value="${stOption}" ${o.status == stOption ? 'selected' : ''}>
                                                        ${stOption}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <button type="submit" class="btn btn-sm btn-outline-primary" title="Lưu trạng thái">
                                                <i class="bi bi-check-lg"></i>
                                            </button>
                                        </form>
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
