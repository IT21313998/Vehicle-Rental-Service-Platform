<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : "DriveHub - Premium Vehicle Rental Platform"}</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts: Plus Jakarta Sans & Outfit -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --primary-light: #eef2ff;
            --secondary: #06b6d4;
            --accent: #f59e0b;
            --success: #10b981;
            --danger: #ef4444;
            --dark: #0b0f19;
            --dark-card: #111827;
            --bg-page: #f8fafc;
            --surface: #ffffff;
            --border-color: #e2e8f0;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --radius-lg: 18px;
            --radius-md: 12px;
            --radius-sm: 8px;
            --shadow-subtle: 0 1px 3px rgba(0,0,0,0.05), 0 1px 2px rgba(0,0,0,0.03);
            --shadow-card: 0 10px 25px -5px rgba(15, 23, 42, 0.06), 0 8px 10px -6px rgba(15, 23, 42, 0.04);
            --shadow-hover: 0 20px 30px -10px rgba(79, 70, 229, 0.15), 0 10px 15px -3px rgba(15, 23, 42, 0.08);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-page);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            -webkit-font-smoothing: antialiased;
        }

        h1, h2, h3, h4, h5, h6, .heading-brand {
            font-family: 'Outfit', sans-serif;
            font-weight: 700;
            letter-spacing: -0.02em;
        }

        /* Glassmorphism Navbar */
        .navbar-custom {
            background: rgba(11, 15, 25, 0.92) !important;
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-family: 'Outfit', sans-serif;
            font-weight: 900;
            font-size: 1.65rem;
            letter-spacing: -0.03em;
            color: #ffffff !important;
        }
        .navbar-brand .logo-icon {
            background: linear-gradient(135deg, #4f46e5 0%, #06b6d4 100%);
            width: 40px;
            height: 40px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(79, 70, 229, 0.5);
        }
        .navbar-brand span.hub {
            background: linear-gradient(135deg, #06b6d4 0%, #38bdf8 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-link {
            font-weight: 600;
            font-size: 0.92rem;
            color: #94a3b8 !important;
            padding: 8px 16px !important;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .nav-link:hover, .nav-link.active {
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.06);
        }

        /* SaaS Buttons */
        .btn-saas-primary {
            background: linear-gradient(135deg, #4f46e5 0%, #3b82f6 100%);
            color: #ffffff;
            font-weight: 600;
            padding: 10px 22px;
            border-radius: 10px;
            border: none;
            box-shadow: 0 4px 14px rgba(79, 70, 229, 0.3);
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .btn-saas-primary:hover {
            background: linear-gradient(135deg, #4338ca 0%, #2563eb 100%);
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.45);
        }

        .btn-saas-secondary {
            background: #ffffff;
            color: var(--text-main);
            font-weight: 600;
            padding: 10px 22px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-subtle);
            transition: all 0.25s ease;
        }
        .btn-saas-secondary:hover {
            background: #f1f5f9;
            color: var(--primary);
            border-color: #cbd5e1;
            transform: translateY(-2px);
        }

        /* SaaS Cards */
        .saas-card {
            background: var(--surface);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-card);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
        }
        .saas-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
            border-color: #cbd5e1;
        }

        /* Modern Badges */
        .badge-pill-soft {
            font-size: 0.76rem;
            font-weight: 700;
            padding: 5px 12px;
            border-radius: 20px;
            letter-spacing: 0.02em;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .badge-soft-indigo { background: #eef2ff; color: #4338ca; }
        .badge-soft-cyan { background: #ecfeff; color: #0891b2; }
        .badge-soft-emerald { background: #ecfdf5; color: #059669; }
        .badge-soft-amber { background: #fffbeb; color: #d97706; }
        .badge-soft-rose { background: #fff1f2; color: #e11d48; }

        /* Vehicle Image Container */
        .vehicle-img-box {
            position: relative;
            height: 220px;
            overflow: hidden;
            background: #0f172a;
        }
        .vehicle-img-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .saas-card:hover .vehicle-img-box img {
            transform: scale(1.08);
        }
        .vehicle-category-pill {
            position: absolute;
            top: 14px;
            left: 14px;
            backdrop-filter: blur(8px);
            background: rgba(15, 23, 42, 0.85);
            color: #ffffff;
            font-size: 0.72rem;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.15);
            text-transform: uppercase;
        }
        .vehicle-seats-pill {
            position: absolute;
            bottom: 14px;
            right: 14px;
            backdrop-filter: blur(8px);
            background: rgba(15, 23, 42, 0.85);
            color: #38bdf8;
            font-size: 0.75rem;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 20px;
            border: 1px solid rgba(56, 189, 248, 0.3);
        }

        /* Metric / Stat Card */
        .stat-card {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            padding: 20px;
            box-shadow: var(--shadow-subtle);
            transition: all 0.2s ease;
        }
        .stat-card:hover {
            border-color: #cbd5e1;
            box-shadow: var(--shadow-card);
        }

        /* Filter Pills */
        .filter-btn {
            border-radius: 30px;
            padding: 8px 20px;
            font-size: 0.88rem;
            font-weight: 600;
            border: 1px solid var(--border-color);
            background: #ffffff;
            color: var(--text-muted);
            transition: all 0.2s ease;
            cursor: pointer;
        }
        .filter-btn:hover {
            background: #f1f5f9;
            color: var(--text-main);
        }
        .filter-btn.active {
            background: #4f46e5;
            color: #ffffff;
            border-color: #4f46e5;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.25);
        }

        /* Table Styling */
        .saas-table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
        }
        .saas-table thead th {
            background: #f8fafc;
            color: #64748b;
            font-size: 0.78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 14px 18px;
            border-bottom: 1px solid var(--border-color);
        }
        .saas-table tbody td {
            padding: 16px 18px;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }
        .saas-table tbody tr:hover td {
            background-color: #f8fafc;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #f1f5f9;
        }
        ::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top py-3">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/index.jsp">
            <span class="logo-icon text-white">
                <i class="bi bi-speedometer2 fs-5"></i>
            </span>
            <span>Drive<span class="hub">Hub</span></span>
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navDrive">
            <i class="bi bi-list text-white fs-3"></i>
        </button>

        <div class="collapse navbar-collapse" id="navDrive">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4 gap-1">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">
                        <i class="bi bi-house me-1"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/vehicles?action=list">
                        <i class="bi bi-car-front me-1 text-info"></i> Fleet Showroom
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/rentals?action=book">
                        <i class="bi bi-key me-1 text-warning"></i> Instant Reserve
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/rentals?action=track">
                        <i class="bi bi-search me-1 text-success"></i> Track Booking
                    </a>
                </li>
            </ul>

            <div class="d-flex align-items-center gap-3">
                <!-- Management Dropdown -->
                <div class="dropdown">
                    <button class="btn btn-outline-light btn-sm dropdown-toggle fw-semibold rounded-pill px-3 py-2 border-secondary" type="button" data-bs-toggle="dropdown">
                        <i class="bi bi-sliders me-1 text-info"></i> Management Console
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3 p-2 mt-2" style="min-width: 260px;">
                        <li><div class="dropdown-header text-uppercase fw-bold text-indigo small"><i class="bi bi-car-front me-1"></i> Member 01: Fleet Admin</div></li>
                        <li><a class="dropdown-item rounded-2 py-2" href="${pageContext.request.contextPath}/vehicles?action=add"><i class="bi bi-plus-circle me-2 text-primary"></i>Register New Vehicle</a></li>
                        <li><a class="dropdown-item rounded-2 py-2" href="${pageContext.request.contextPath}/vehicles?action=manage"><i class="bi bi-grid-3x3-gap me-2 text-primary"></i>Manage Fleet Inventory</a></li>
                        <li><hr class="dropdown-divider my-2"></li>
                        <li><div class="dropdown-header text-uppercase fw-bold text-success small"><i class="bi bi-journal-check me-1"></i> Member 02: Dispatch Admin</div></li>
                        <li><a class="dropdown-item rounded-2 py-2" href="${pageContext.request.contextPath}/rentals?action=manage"><i class="bi bi-journal-text me-2 text-success"></i>Manage Reservations</a></li>
                    </ul>
                </div>

                <a href="${pageContext.request.contextPath}/rentals?action=book" class="btn btn-saas-primary btn-sm px-4 rounded-pill">
                    <i class="bi bi-calendar2-plus me-1"></i> Book a Car
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Container -->
<div class="container my-4 flex-grow-1">
    <% 
        String msg = request.getParameter("msg");
        String err = request.getParameter("error");
        if (msg != null && !msg.isEmpty()) { 
    %>
        <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 rounded-3 d-flex align-items-center p-3 mb-4 bg-success-subtle text-success" role="alert">
            <i class="bi bi-check-circle-fill fs-4 me-3"></i>
            <div>
                <strong>Success!</strong> <%= msg.replaceAll("([A-Z])", " $1") %>
            </div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    <% if (err != null && !err.isEmpty()) { %>
        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0 rounded-3 d-flex align-items-center p-3 mb-4 bg-danger-subtle text-danger" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-4 me-3"></i>
            <div>
                <strong>Action Required:</strong> <%= err %>
            </div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
