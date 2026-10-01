<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:title default="Hệ Thống Xem Video - Đề Số 04" /></title>
    <!-- Google Fonts: Be Vietnam Pro (Tối ưu hoàn hảo cho tiếng Việt) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Be Vietnam Pro', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-content {
            flex: 1;
        }
        .navbar-brand {
            font-weight: 700;
            color: #0d6efd !important;
            letter-spacing: 0.5px;
        }
        .nav-link {
            font-weight: 500;
            color: #333;
            transition: color 0.2s;
        }
        .nav-link:hover, .nav-link.active {
            color: #0d6efd !important;
        }
        .footer {
            background-color: #212529;
            color: #dee2e6;
            padding: 25px 0;
            margin-top: 50px;
        }
        .footer h6 {
            color: #fff;
            font-weight: 700;
        }
        .footer .highlight {
            color: #ffc107;
            font-weight: 600;
        }
    </style>
    <sitemesh:head />
</head>
<body>

    <!-- ==================== HEADER  ==================== -->
    <nav class="navbar navbar-expand-lg navbar-white bg-white shadow-sm sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/home">
                <span class="fs-4 fw-bold">UTE VIDEO</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="userNavbar">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <!-- Menu: Trang Chủ  -->
                    <li class="nav-link-item">
                        <a class="nav-link px-3" href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house-door me-1"></i>Trang Chủ
                        </a>
                    </li>
                    <!-- Menu: Sản phẩm  -->
                    <li class="nav-link-item">
                        <a class="nav-link px-3" href="${pageContext.request.contextPath}/videos">
                            <i class="bi bi-collection-play me-1"></i>Sản phẩm
                        </a>
                    </li>
                    <!-- Menu: Trang quản trị - Chỉ Admin mới có chức năng này  -->
                    <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.admin}">
                        <li class="nav-link-item">
                            <a class="nav-link px-3 text-danger fw-bold" href="${pageContext.request.contextPath}/admin/home">
                                <i class="bi bi-shield-lock-fill me-1"></i>Trang quản trị
                            </a>
                        </li>
                    </c:if>
                </ul>

                <!-- Menu: Đăng nhập / Đăng ký / Tài khoản  -->
                <ul class="navbar-nav ms-auto align-items-center">
                    <c:choose>
                        <c:when test="${empty sessionScope.currentUser}">
                            <li class="nav-item">
                                <a class="nav-link px-3" href="${pageContext.request.contextPath}/login">
                                    <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-primary btn-sm px-3 rounded-pill" href="${pageContext.request.contextPath}/register">
                                    <i class="bi bi-person-plus me-1"></i>Đăng ký
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" role="button" data-bs-toggle="dropdown">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.currentUser.images}">
                                            <img src="${sessionScope.currentUser.images}" alt="avatar" class="rounded-circle border" width="32" height="32">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-person-circle fs-5 text-primary"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="fw-semibold">${sessionScope.currentUser.fullname}</span>
                                    <c:if test="${sessionScope.currentUser.admin}">
                                        <span class="badge bg-danger">Admin</span>
                                    </c:if>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <c:if test="${sessionScope.currentUser.admin}">
                                        <li>
                                            <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin/home">
                                                <i class="bi bi-speedometer2 me-2"></i>Vào Trang Quản Trị
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="bi bi-box-arrow-right me-2 text-muted"></i>Đăng xuất
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- ==================== BODY (NỘI DUNG TỪNG TRANG) ==================== -->
    <main class="main-content py-4">
        <sitemesh:body />
    </main>

    <!-- ==================== FOOTER  ==================== -->
    <footer class="footer py-3">
        <div class="container text-center">
            <p class="mb-0 text-white">
                <span class="highlight">Mã đề: 4 (Đề số 04)</span> &nbsp;|&nbsp; 
                Họ tên: <strong class="text-white">Lê Nguyễn Minh Khôi</strong> &nbsp;|&nbsp; 
                MSSV: <strong class="text-white">24110028</strong>
            </p>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
