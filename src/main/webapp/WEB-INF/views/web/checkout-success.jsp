<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt Hàng Thành Công - UTE SHOP</title>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 text-center mb-4">
                <div class="mb-3">
                    <i class="bi bi-check-circle-fill text-success" style="font-size: 4rem;"></i>
                </div>
                <h3 class="fw-bold text-dark mb-2">Đặt Hàng Thành Công!</h3>
                <p class="text-muted mb-4">Cảm ơn bạn đã mua sắm tại <strong>UTE SHOP</strong>. Đơn hàng của bạn đã được ghi nhận và đang được xử lý.</p>

                <div class="bg-light rounded-4 p-3 mb-4 text-start">
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <span class="text-muted small d-block">Mã Đơn Hàng:</span>
                            <span class="fw-bold fs-5 text-danger">#${order.orderId}</span>
                        </div>
                        <div class="col-sm-6 text-sm-end">
                            <span class="text-muted small d-block">Trạng Thái Đơn Hàng:</span>
                            <span class="badge ${order.statusBadgeClass} fs-6 px-3 py-2 rounded-pill">${order.status}</span>
                        </div>
                        <div class="col-sm-6">
                            <span class="text-muted small d-block">Phương Thức Thanh Toán:</span>
                            <span class="fw-semibold text-dark"><i class="bi bi-cash-stack text-success me-1"></i>Thanh toán khi nhận hàng (${order.paymentMethod})</span>
                        </div>
                        <div class="col-sm-6 text-sm-end">
                            <span class="text-muted small d-block">Thời Gian Đặt:</span>
                            <span class="fw-semibold text-dark">
                                <fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="text-start mb-4">
                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-geo-alt-fill text-danger me-1"></i>Thông Tin Nhận Hàng:</h6>
                    <div class="p-3 border rounded-3 bg-white">
                        <p class="mb-1"><strong>Người nhận:</strong> ${order.customerName}</p>
                        <p class="mb-1"><strong>Số điện thoại:</strong> ${order.phone}</p>
                        <p class="mb-1"><strong>Địa chỉ:</strong> ${order.address}</p>
                        <c:if test="${not empty order.note}">
                            <p class="mb-0"><strong>Ghi chú:</strong> ${order.note}</p>
                        </c:if>
                    </div>
                </div>

                <div class="text-start mb-4">
                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-box-seam text-primary me-1"></i>Chi Tiết Sản Phẩm:</h6>
                    <div class="table-responsive border rounded-3">
                        <table class="table align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Sản Phẩm</th>
                                    <th class="text-center">Đơn Giá</th>
                                    <th class="text-center">Số Lượng</th>
                                    <th class="text-end">Thành Tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${order.details}">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <img src="${item.video.poster}" alt="${item.video.title}" 
                                                     class="rounded-2 object-fit-cover" width="40" height="40"
                                                     onerror="this.src='https://placehold.co/40x40?text=SP'">
                                                <span class="fw-semibold text-dark">${item.video.title}</span>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </td>
                                        <td class="text-center fw-bold">x${item.quantity}</td>
                                        <td class="text-end fw-bold text-danger">
                                            <fmt:formatNumber value="${item.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot class="table-light">
                                <tr>
                                    <td colspan="3" class="text-end fw-bold">Tổng Thanh Toán COD:</td>
                                    <td class="text-end fw-bold text-danger fs-5">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <div class="d-flex flex-wrap gap-2 justify-content-center">
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-primary rounded-pill px-4">
                        <i class="bi bi-clock-history me-1"></i>Xem Lịch Sử Đơn Hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/videos" class="btn btn-danger rounded-pill px-4">
                        <i class="bi bi-bag-plus me-1"></i>Tiếp Tục Mua Sắm
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
