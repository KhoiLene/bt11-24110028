<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Người Dùng</title>
</head>
<body>
<div class="container py-4">

    <!-- Tiêu đề & Nút Thêm mới -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1 text-dark">Quản Trị Bảng Dữ Liệu Users</h3>
            <p class="text-muted mb-0">Chức năng CRUD (Tạo, Xem, Cập nhật, Xóa) có phân trang đúng <strong>6 user / 01 trang</strong></p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/users/create" class="btn btn-primary rounded-pill px-4">
            <i class="bi bi-person-plus-fill me-1"></i>Thêm Người Dùng Mới
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

    <!-- Bảng danh sách Users -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <span class="fw-bold text-secondary">
                <i class="bi bi-table me-1"></i>Danh sách người dùng (Tổng số: ${totalUsers} | Hiển thị: 6 users / trang)
            </span>
            <span class="badge bg-primary rounded-pill px-3 py-2">Trang ${currentPage} / ${totalPages}</span>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th scope="col">Tên đăng nhập (Username)</th>
                        <th scope="col">Họ và tên</th>
                        <th scope="col">Email</th>
                        <th scope="col">Số điện thoại</th>
                        <th scope="col" class="text-center">Vai trò</th>
                        <th scope="col" class="text-center">Trạng thái</th>
                        <th scope="col" class="text-center" style="width: 150px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${userList}">
                        <tr>
                            <td>
                                <strong class="text-primary">${u.username}</strong>
                            </td>
                            <td>${u.fullname}</td>
                            <td>${u.email}</td>
                            <td>${u.phone}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${u.admin}">
                                        <span class="badge bg-danger">Admin</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">User</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${u.active}">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle">Kích hoạt</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning-subtle text-warning border border-warning-subtle">Chưa kích hoạt</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a href="${pageContext.request.contextPath}/admin/users/edit?username=${u.username}" class="btn btn-outline-primary" title="Cập nhật">
                                        <i class="bi bi-pencil-square"></i> Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/users/delete?username=${u.username}" 
                                       class="btn btn-outline-danger" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng [${u.username}] không?');"
                                       title="Xóa">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Phân trang chuẩn 6 user / trang  -->
    <c:if test="${totalPages > 1}">
        <div class="d-flex justify-content-center">
            <nav aria-label="User list pagination">
                <ul class="pagination">
                    <!-- Đầu trang / Trang trước -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=1" aria-label="First">&lt;&lt;</a>
                    </li>
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 1}" aria-label="Previous">&lt;</a>
                    </li>

                    <!-- Danh sách các trang -->
                    <c:forEach var="p" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == p ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${p}">${p}</a>
                        </li>
                    </c:forEach>

                    <!-- Trang sau / Cuối trang -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage + 1}" aria-label="Next">&gt;</a>
                    </li>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${totalPages}" aria-label="Last">&gt;&gt;</a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:if>

</div>
</body>
</html>
