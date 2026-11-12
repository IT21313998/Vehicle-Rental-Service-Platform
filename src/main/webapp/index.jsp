<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("pageTitle", "DriveHub - Premium Vehicle Rental & Chauffeur Services"); %>
<%@ include file="includes/header.jsp" %>

<!-- Modern SaaS Hero Section with Quick Booking Widget -->
<div class="position-relative overflow-hidden rounded-4 mb-5 shadow-lg" 
     style="background: radial-gradient(circle at 80% 20%, rgba(79, 70, 229, 0.35) 0%, rgba(11, 15, 25, 0.95) 70%), url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=1600') center/cover no-repeat; min-height: 540px; display: flex; align-items: center; border: 1px solid rgba(255, 255, 255, 0.1);">
    
    <div class="container py-5 text-white">
        <div class="row align-items-center g-5">
            <div class="col-lg-7">
                <div class="d-inline-flex align-items-center gap-2 px-3 py-1 rounded-pill mb-3" 
                     style="background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.2); backdrop-filter: blur(8px);">
                    <span class="badge bg-primary rounded-pill px-2 py-1 small">NEW</span>
                    <span class="small fw-semibold text-light">Autonomous &amp; Executive Fleet Available</span>
                </div>
                
                <h1 class="display-3 fw-bold mb-3 heading-brand text-white" style="letter-spacing: -0.03em; line-height: 1.15;">
                    Drive the Future.<br>
                    <span style="background: linear-gradient(135deg, #38bdf8 0%, #818cf8 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                        On Your Terms.
                    </span>
                </h1>
                
                <p class="fs-5 text-light opacity-75 mb-4 col-xl-10" style="line-height: 1.6;">
                    Unlock seamless vehicle rentals with real-time transparent rates, instant digital booking, zero-liability protection, and optional dedicated chauffeur services.
                </p>

                <div class="d-flex flex-wrap gap-3 mb-4">
                    <a href="${pageContext.request.contextPath}/rentals?action=book" class="btn btn-saas-primary btn-lg px-4 rounded-pill">
                        <i class="bi bi-key-fill me-2"></i> Book Instant Rental
                    </a>
                    <a href="${pageContext.request.contextPath}/vehicles?action=list" class="btn btn-saas-secondary btn-lg px-4 rounded-pill">
                        <i class="bi bi-car-front me-2 text-primary"></i> Explore Full Fleet
                    </a>
                </div>

                <!-- Trust Badges -->
                <div class="d-flex align-items-center gap-4 text-light opacity-75 small pt-2">
                    <div class="d-flex align-items-center gap-1">
                        <i class="bi bi-check-circle-fill text-success"></i> Instant Confirmation
                    </div>
                    <div class="d-flex align-items-center gap-1">
                        <i class="bi bi-shield-lock-fill text-info"></i> Zero Deposit with VIP Plan
                    </div>
                    <div class="d-flex align-items-center gap-1">
                        <i class="bi bi-star-fill text-warning"></i> 4.9/5 Rating (1,200+ reviews)
                    </div>
                </div>
            </div>

            <!-- Quick Reservation Card -->
            <div class="col-lg-5">
                <div class="p-4 rounded-4 shadow-2xl" 
                     style="background: rgba(17, 24, 39, 0.85); backdrop-filter: blur(20px); border: 1px solid rgba(255, 255, 255, 0.15);">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="text-white fw-bold heading-brand mb-0"><i class="bi bi-lightning-charge-fill text-warning me-2"></i>Quick Booking</h5>
                        <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 small">Fleet Ready</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/rentals" method="get">
                        <input type="hidden" name="action" value="book">

                        <div class="mb-3">
                            <label class="form-label text-light small fw-semibold">Pickup Location</label>
                            <div class="input-group">
                                <span class="input-group-text bg-dark border-secondary text-secondary"><i class="bi bi-geo-alt-fill text-info"></i></span>
                                <input type="text" class="form-control bg-dark text-light border-secondary" placeholder="City Airport, Hotel or Central Hub" value="International Airport Terminal 1">
                            </div>
                        </div>

                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <label class="form-label text-light small fw-semibold">Rental Mode</label>
                                <select class="form-select bg-dark text-light border-secondary">
                                    <option value="SELF_DRIVE">Self-Drive</option>
                                    <option value="CHAUFFEUR">Chauffeur Service</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label class="form-label text-light small fw-semibold">Vehicle Class</label>
                                <select class="form-select bg-dark text-light border-secondary">
                                    <option>All Classes</option>
                                    <option>Luxury Sedan</option>
                                    <option>Luxury SUV</option>
                                    <option>Passenger Van</option>
                                </select>
                            </div>
                        </div>

                        <div class="row g-2 mb-4">
                            <div class="col-6">
                                <label class="form-label text-light small fw-semibold">Pickup Date</label>
                                <input type="date" class="form-control bg-dark text-light border-secondary" value="<%= java.time.LocalDate.now().plusDays(1).toString() %>">
                            </div>
                            <div class="col-6">
                                <label class="form-label text-light small fw-semibold">Return Date</label>
                                <input type="date" class="form-control bg-dark text-light border-secondary" value="<%= java.time.LocalDate.now().plusDays(4).toString() %>">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-saas-primary w-100 py-3 fw-bold rounded-3">
                            <i class="bi bi-search me-2"></i> Search Available Vehicles
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- SaaS Live Stats Counter Row -->
<div class="row g-3 mb-5">
    <div class="col-6 col-md-3">
        <div class="stat-card text-center">
            <div class="text-primary fs-3 mb-1"><i class="bi bi-car-front-fill"></i></div>
            <h3 class="fw-bold heading-brand text-dark mb-0">50+</h3>
            <span class="small text-muted fw-semibold">Modern Vehicles</span>
        </div>
    </div>
    <div class="col-6 col-md-3">
        <div class="stat-card text-center">
            <div class="text-success fs-3 mb-1"><i class="bi bi-people-fill"></i></div>
            <h3 class="fw-bold heading-brand text-dark mb-0">15,400+</h3>
            <span class="small text-muted fw-semibold">Trips Completed</span>
        </div>
    </div>
    <div class="col-6 col-md-3">
        <div class="stat-card text-center">
            <div class="text-warning fs-3 mb-1"><i class="bi bi-star-fill"></i></div>
            <h3 class="fw-bold heading-brand text-dark mb-0">4.92 / 5</h3>
            <span class="small text-muted fw-semibold">Customer Satisfaction</span>
        </div>
    </div>
    <div class="col-6 col-md-3">
        <div class="stat-card text-center">
            <div class="text-info fs-3 mb-1"><i class="bi bi-headset"></i></div>
            <h3 class="fw-bold heading-brand text-dark mb-0">24 / 7</h3>
            <span class="small text-muted fw-semibold">Dedicated Road Support</span>
        </div>
    </div>
</div>

<!-- Three Core Features Grid -->
<div class="mb-5">
    <div class="text-center mb-4">
        <span class="badge-pill-soft badge-soft-indigo mb-2">Designed for Convenience</span>
        <h2 class="display-6 fw-bold heading-brand text-dark">Why Choose DriveHub?</h2>
        <p class="text-secondary col-lg-6 mx-auto">Enterprise features built from the ground up for seamless luxury car rental and commercial transport.</p>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="saas-card h-100 p-4 border">
                <div class="d-inline-flex p-3 rounded-3 mb-3" style="background: #e0e7ff; color: #4338ca;">
                    <i class="bi bi-shield-fill-check fs-3"></i>
                </div>
                <h4 class="fw-bold heading-brand mb-2">Comprehensive Coverage</h4>
                <p class="text-secondary small mb-3">
                    Select from 3 tailored tiers: Basic Waiver, Comprehensive Premium, or Zero Liability Protection for total peace of mind on every journey.
                </p>
                <ul class="list-unstyled small text-muted d-flex flex-column gap-2 mb-0">
                    <li><i class="bi bi-check2 text-primary me-2"></i>No hidden excess charges</li>
                    <li><i class="bi bi-check2 text-primary me-2"></i>24/7 towing &amp; emergency repair</li>
                </ul>
            </div>
        </div>

        <div class="col-md-4">
            <div class="saas-card h-100 p-4 border">
                <div class="d-inline-flex p-3 rounded-3 mb-3" style="background: #fef3c7; color: #d97706;">
                    <i class="bi bi-person-badge-fill fs-3"></i>
                </div>
                <h4 class="fw-bold heading-brand mb-2">Certified Chauffeurs</h4>
                <p class="text-secondary small mb-3">
                    Prefer to relax? Hire one of our professional, multilingual executive chauffeurs trained in diplomatic VIP etiquette and safe navigation.
                </p>
                <ul class="list-unstyled small text-muted d-flex flex-column gap-2 mb-0">
                    <li><i class="bi bi-check2 text-warning me-2"></i>VIP Airport pick-up service</li>
                    <li><i class="bi bi-check2 text-warning me-2"></i>Corporate delegations &amp; events</li>
                </ul>
            </div>
        </div>

        <div class="col-md-4">
            <div class="saas-card h-100 p-4 border">
                <div class="d-inline-flex p-3 rounded-3 mb-3" style="background: #dcfce7; color: #15803d;">
                    <i class="bi bi-percent fs-3"></i>
                </div>
                <h4 class="fw-bold heading-brand mb-2">Dynamic Volume Discount</h4>
                <p class="text-secondary small mb-3">
                    Rent for 7 days or more and receive an automatic 15% discount on your base rental rate, dynamically computed in real-time.
                </p>
                <ul class="list-unstyled small text-muted d-flex flex-column gap-2 mb-0">
                    <li><i class="bi bi-check2 text-success me-2"></i>Automatic formula recalculation</li>
                    <li><i class="bi bi-check2 text-success me-2"></i>Weekly &amp; monthly lease specials</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Featured Fleet Teaser Showcase -->
<div class="mb-5">
    <div class="d-flex justify-content-between align-items-end mb-4 flex-wrap gap-2">
        <div>
            <span class="badge-pill-soft badge-soft-cyan mb-2">Prime Fleet</span>
            <h2 class="display-6 fw-bold heading-brand mb-0">Handpicked Premium Models</h2>
        </div>
        <a href="${pageContext.request.contextPath}/vehicles?action=list" class="btn btn-saas-secondary rounded-pill px-4">
            View All Showroom Vehicles <i class="bi bi-arrow-right ms-1 text-primary"></i>
        </a>
    </div>

    <div class="row g-4">
        <!-- Showcase Car 1 -->
        <div class="col-md-6 col-lg-4">
            <div class="saas-card h-100 d-flex flex-column">
                <div class="vehicle-img-box">
                    <img src="https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800" alt="Mercedes Benz">
                    <span class="vehicle-category-pill">Sedan &bull; Luxury</span>
                    <span class="vehicle-seats-pill"><i class="bi bi-people-fill me-1"></i> 5 Seats</span>
                </div>
                <div class="p-4 d-flex flex-column flex-grow-1">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="badge bg-light text-dark border px-2 py-1 small fw-semibold">
                            <i class="bi bi-ev-front me-1 text-info"></i> Hybrid
                        </span>
                        <span class="badge bg-success-subtle text-success px-2 py-1 small fw-semibold">Available</span>
                    </div>

                    <h5 class="fw-bold text-dark mb-1">Mercedes-Benz E-Class AMG</h5>
                    <p class="small text-muted mb-3"><i class="bi bi-gear-wide-connected me-1"></i> 9-Speed Automatic &bull; All-Wheel Drive</p>

                    <div class="p-2 bg-light rounded-3 small text-secondary mb-4 border">
                        <i class="bi bi-check2-circle text-primary me-1"></i> Autopilot &bull; 540L Boot &bull; LKR 75,000 Security Deposit
                    </div>

                    <div class="mt-auto pt-3 border-top d-flex justify-content-between align-items-center">
                        <div>
                            <span class="small text-muted d-block">Starting from</span>
                            <span class="h5 fw-bold text-primary mb-0">LKR 50,000.00</span>
                            <span class="small text-muted">/day</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/rentals?action=book&vehicleId=VEH101" class="btn btn-saas-primary btn-sm px-4 rounded-pill">
                            Reserve <i class="bi bi-chevron-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Showcase Car 2 -->
        <div class="col-md-6 col-lg-4">
            <div class="saas-card h-100 d-flex flex-column">
                <div class="vehicle-img-box">
                    <img src="https://images.unsplash.com/photo-1606016159991-dfe4f2746ad5?w=800" alt="Range Rover">
                    <span class="vehicle-category-pill">SUV &bull; Adventure</span>
                    <span class="vehicle-seats-pill"><i class="bi bi-people-fill me-1"></i> 7 Seats</span>
                </div>
                <div class="p-4 d-flex flex-column flex-grow-1">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="badge bg-light text-dark border px-2 py-1 small fw-semibold">
                            <i class="bi bi-fuel-pump me-1 text-warning"></i> Petrol
                        </span>
                        <span class="badge bg-success-subtle text-success px-2 py-1 small fw-semibold">Available</span>
                    </div>

                    <h5 class="fw-bold text-dark mb-1">Range Rover Sport Autobiography</h5>
                    <p class="small text-muted mb-3"><i class="bi bi-gear-wide-connected me-1"></i> 8-Speed Automatic &bull; Terrain Response</p>

                    <div class="p-2 bg-light rounded-3 small text-secondary mb-4 border">
                        <i class="bi bi-check2-circle text-primary me-1"></i> Air Suspension &bull; 780L Boot &bull; LKR 100,000 Security Deposit
                    </div>

                    <div class="mt-auto pt-3 border-top d-flex justify-content-between align-items-center">
                        <div>
                            <span class="small text-muted d-block">Starting from</span>
                            <span class="h5 fw-bold text-primary mb-0">LKR 70,000.00</span>
                            <span class="small text-muted">/day</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/rentals?action=book&vehicleId=VEH102" class="btn btn-saas-primary btn-sm px-4 rounded-pill">
                            Reserve <i class="bi bi-chevron-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Showcase Car 3 -->
        <div class="col-md-6 col-lg-4">
            <div class="saas-card h-100 d-flex flex-column">
                <div class="vehicle-img-box">
                    <img src="https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=800" alt="Ford Transit">
                    <span class="vehicle-category-pill">Van &bull; Commercial</span>
                    <span class="vehicle-seats-pill"><i class="bi bi-people-fill me-1"></i> 12 Seats</span>
                </div>
                <div class="p-4 d-flex flex-column flex-grow-1">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="badge bg-light text-dark border px-2 py-1 small fw-semibold">
                            <i class="bi bi-fuel-pump me-1 text-danger"></i> Diesel
                        </span>
                        <span class="badge bg-success-subtle text-success px-2 py-1 small fw-semibold">Available</span>
                    </div>

                    <h5 class="fw-bold text-dark mb-1">Ford Transit Executive Minivan</h5>
                    <p class="small text-muted mb-3"><i class="bi bi-gear-wide-connected me-1"></i> 10-Speed Automatic &bull; Heavy Duty</p>

                    <div class="p-2 bg-light rounded-3 small text-secondary mb-4 border">
                        <i class="bi bi-check2-circle text-primary me-1"></i> 1,650kg Payload &bull; Passenger Air-con &bull; 2,800kg Towing
                    </div>

                    <div class="mt-auto pt-3 border-top d-flex justify-content-between align-items-center">
                        <div>
                            <span class="small text-muted d-block">Starting from</span>
                            <span class="h5 fw-bold text-primary mb-0">LKR 40,000.00</span>
                            <span class="small text-muted">/day</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/rentals?action=book&vehicleId=VEH104" class="btn btn-saas-primary btn-sm px-4 rounded-pill">
                            Reserve <i class="bi bi-chevron-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Academic & Team Workload Section -->
<div class="p-4 rounded-4 bg-white border shadow-sm mb-4">
    <div class="row align-items-center g-4">
        <div class="col-lg-8">
            <span class="badge-pill-soft badge-soft-indigo mb-2">SLIIT SE1020 Project Architecture</span>
            <h4 class="fw-bold heading-brand text-dark mb-1">2-Member Workload Distribution</h4>
            <p class="text-secondary small mb-0">
                Both group members feature 4 complete CRUD operations, individual model hierarchies, custom business calculations, and persistent file I/O operations.
            </p>
        </div>
        <div class="col-lg-4 text-lg-end">
            <a href="${pageContext.request.contextPath}/vehicles?action=manage" class="btn btn-sm btn-outline-primary rounded-pill px-3 me-2">
                Member 01 Console
            </a>
            <a href="${pageContext.request.contextPath}/rentals?action=manage" class="btn btn-sm btn-outline-success rounded-pill px-3">
                Member 02 Console
            </a>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
