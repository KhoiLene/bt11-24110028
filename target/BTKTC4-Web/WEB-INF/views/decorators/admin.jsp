<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:title default="Trang Quản Trị Hệ Thống - Đề Số 04" /></title>
    <!-- Google Fonts: Be Vietnam Pro -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Be Vietnam Pro', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background-color: #f4f6f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .admin-navbar {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        .admin-navbar .navbar-brand {
            font-weight: 700;
            color: #38bdf8 !important;
            letter-spacing: 0.5px;
        }
        .admin-navbar .nav-link {
            color: #cbd5e1;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 6px;
            transition: all 0.2s;
        }
        .admin-navbar .nav-link:hover, .admin-navbar .nav-link.active {
            color: #fff !important;
            background-color: rgba(255,255,255,0.1);
        }
        .main-content {
            flex: 1;
        }
        .card-custom {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            background: #fff;
        }
        .footer {
            background-color: #0f172a;
            color: #94a3b8;
            padding: 25px 0;
            margin-top: 50px;
            border-top: 1px solid #1e293b;
        }
        .footer .highlight {
            color: #38bdf8;
            font-weight: 600;
        }
    </style>
    <sitemesh:head />
</head>
<body>

    <!-- ==================== ADMIN NAVBAR  ==================== -->
    <nav class="navbar navbar-expand-lg navbar-dark admin-navbar sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/admin/home">
                <i class="bi bi-shield-shaded text-info fs-4"></i>
                <span>ADMIN PANEL</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="adminNavbar">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/home">
                            <i class="bi bi-speedometer2 me-1"></i>Bảng Điều Khiển
                        </a>
                    </li>
                    <!-- Quản lý Users có phân trang 6 users / trang  -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                            <i class="bi bi-people-fill me-1"></i>Quản Trị Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-warning" href="${pageContext.request.contextPath}/home" target="_blank">
                            <i class="bi bi-box-arrow-up-right me-1"></i>Xem Trang Chủ User
                        </a>
                    </li>
                </ul>

                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center gap-2 text-white" href="#" role="button" data-bs-toggle="dropdown">
                            <c:choose>
                                <c:when test="${not empty sessionScope.currentUser.images}">
                                    <img src="${sessionScope.currentUser.images}" alt="avatar" class="rounded-circle border border-info" width="32" height="32">
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-person-circle fs-5 text-info"></i>
                                </c:otherwise>
                            </c:choose>
                            <span class="fw-semibold">${sessionScope.currentUser.fullname}</span>
                            <span class="badge bg-danger">ADMIN</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow">
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/home">
                                    <i class="bi bi-house me-2"></i>Trang Người Dùng
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- ==================== BODY NỘI DUNG ADMIN ==================== -->
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
